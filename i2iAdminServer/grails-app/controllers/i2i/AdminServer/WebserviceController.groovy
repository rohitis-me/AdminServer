package i2i.AdminServer

import static org.springframework.http.HttpStatus.*
import grails.converters.JSON
import grails.plugin.awssdk.AmazonWebService
import i2i.AdminServer.ClientSync.InventoryService
import i2i.AdminServer.User.BrandRequestCommand
import i2i.AdminServer.User.BrandRequestInfoService
import i2i.AdminServer.User.EmailService
import i2i.AdminServer.User.FeedbackService
import i2i.AdminServer.User.FileAttachmentService
import i2i.AdminServer.User.PatientProfile
import i2i.AdminServer.User.PatientProfileService
import i2i.AdminServer.Util.Utility

import org.springframework.web.multipart.commons.CommonsMultipartFile

import com.amazonaws.services.s3.model.*
import com.amazonaws.services.s3.transfer.*
import com.metasieve.shoppingcart.SessionUtils
import com.metasieve.shoppingcart.Shoppable
import com.metasieve.shoppingcart.ShoppingCartService
//import com.google.gson.reflect.TypeToken

class WebserviceController {
	SearchService searchService
	InventoryService inventoryService
	BrandDatabaseService brandDatabaseService
	StoreService storeService
	OrdersService ordersService
	EmailService emailService
	FeedbackService feedbackService
	BrandRequestInfoService brandRequestInfoService
	OrderCollectionService orderCollectionService
	ShoppingCartService shoppingCartService
	PatientProfileService patientProfileService
	AmazonWebService amazonWebService
	FileAttachmentService fileAttachmentService
	//	//GsonBuilder
	//	def gsonBuilder

	def index() {
	}

	//TODO change once data is got from branddatabase
	def getListOfBrandNameStartingWith() {
		println "AUTO COMPLETE: received params: "+params
		String searchTerm = params.term //'amlogard'
		String circle = params.circle//Constants.circleArray[0]

		List drugList = brandDatabaseService.getBrandDataList(searchTerm, circle)

		List brandMapList = []
		drugList.each {
			//			println "druglist: "+it.brandId+"|"+it.inventoryId+"|"
			Map brandMap = brandDatabaseService.getBrandDataMap(it)
			brandMapList.add(brandMap)
		}
		render brandMapList as JSON
	}

	def search() {
		println "SEARCH received params: "+params+ " Brand Name: "+params.brandName;

		String searchTerm = params.brandName
		String circle = params.circle
		//String brandId = brandDatabaseService.getBrandIdFromBrandName(searchTerm)
		String brandId = params.brandId
		String city = params.city

		//TODO: taking inventoryId into consideration for now
		String inventoryId = params.inventoryId

		boolean availabilityFlag= false

		//FIXME filter stores with circle also||get brandId against inventoryId and search for all stores where it is available
		if(inventoryId || brandId){
			//FIXME: not scalable. Else condition does not use circle
			List stores
			if(inventoryId)
				stores = searchService.getListOfStoresWhereBrandIsAvailableUsingInventoryIdAndCircle(inventoryId, circle)
			else if(brandId)
				stores = searchService.getListOfStoresWhereBrandIsAvailable(brandId)
			if(stores){
				availabilityFlag= true
				String storeId = stores.first().storeId
				def deliveryHours = stores.first()?.deliveryHoursIfAvailable

				def searchResult = [
					'storeId': storeId,
					'availabilityFlag':availabilityFlag,
					'brandId':brandId,
					'inventoryId':inventoryId,
					'brandName': searchTerm,
					'circle': circle,
					'deliveryHours':deliveryHours,
					'quantity': 1]

				render searchResult as JSON

				//				render (view:"searchResult", model: [storeId:storeId, brandId:brandId, inventoryId:inventoryId, brandName: searchTerm, circle: circle, quantity: 1])
				//render (view:"searchList", model: [storesList:stores, availabilityFlag:availabilityFlag, brandId:brandId, inventoryId:inventoryId, brandName: searchTerm, circle: circle])
			}
			else{
				def brandRequestData = ['brandName':searchTerm, 'circle': circle,'availabilityFlag':availabilityFlag]
				render brandRequestData as JSON
				//				redirect (controller:'brandRequestInfo', action:'index', params: [brandName: searchTerm, circle: circle])
			}
		}
		else
		{
			List drugList = brandDatabaseService.getBrandDataList(searchTerm,circle, city)
			if(drugList){
				def searchSuggestions = [
					'drugList':drugList,
					'brandName': searchTerm,
					'circle': circle]

				render searchSuggestions as JSON
			}
			else{
				def brandRequestData = ['brandName':searchTerm, 'circle': circle,'availabilityFlag':availabilityFlag]
				render brandRequestData as JSON
				//				redirect (controller:'brandRequestInfo', action:'index', params: [brandName: searchTerm, circle: circle])
			}
		}
	}

	def requestNewBrand(BrandRequestCommand brandRequestCommand){
		println "BRC: "+brandRequestCommand.properties

		if (!brandRequestCommand || brandRequestCommand?.hasErrors()) {
			def brandRequestData = ['brandRequestCommand':brandRequestCommand]
			render brandRequestData as JSON
			return
		}

		String body = "BrandName: "+brandRequestCommand?.brandName + "\nEmail: "+brandRequestCommand?.emailID+ "\nPhone: "+brandRequestCommand?.phoneNumber +"\nCircle: "+brandRequestCommand?.circle
		String toAdd = Constants.adminEmail + ","+ "adhirajalai@gmail.com"+","+ "chandu@i2itech.co.in"
		emailService.sendEMail (
				toAdd,
				message(code: 'email.subject.medicineRequest'),
				body)

		def status = brandRequestInfoService.saveRequestedBrand(brandRequestCommand)

		if(status == 0)
			render (text: "Error in processing your request. Please try again!")
		else
			render (text: "Thanks for the information. We will inform you as per your contact details provided, as soon as the medicine is available")
	}

	def addItemToCart(){
		println "add item: "+ params
		String inventoryId = params.inventoryId
		String storeId = params.storeId
		BrandOrdered brandOrdered = BrandOrdered.findByInventoryIdAndStoreId(inventoryId,storeId)
		if(!brandOrdered) {
			brandOrdered = new BrandOrdered()

			brandOrdered.brandName = params.brandName
			brandOrdered.inventoryId = params.inventoryId
			brandOrdered.brandId = params.brandId
			brandOrdered.storeId = params.storeId //FIXME store id is not unique to inventoryId

			if(!brandOrdered.save(flush:true)) {
				brandOrdered.errors.each { println "error saving brandOrdered: "+it }
			}
			println "save brandOrdered success"
		}

		int quantity =  params.quantity.toInteger()
		shoppingCartService.addToShoppingCart(brandOrdered, quantity)

		render (text: "Success")
		//		if(params.placeOrderNow == '1')
		//			redirect (controller: 'shoppingCart', action: 'showCartItems')
		//		else
		//			render (view:"/search/searchResult", model: [storeId:params.storeId, brandId:params.brandId, inventoryId:params.inventoryId, brandName: params.brandName, circle: params?.circle, quantity: params.quantity, disableAdd:'1'])
	}

	def removeItemFromCart(){
		String inventoryId = params.inventoryId
		int qty = params.quantity.toInteger()

		BrandOrdered brandOrdered = BrandOrdered.findByInventoryId(inventoryId)
		if(brandOrdered && brandOrdered.shoppingItem){
			//			def qty = shoppingCartService.getQuantity(brandOrdered.shoppingItem)
			println "qty: "+ qty
			shoppingCartService.removeFromShoppingCart(brandOrdered, qty)

			render (text: "Success")
		}
		else
			render (text: "Error")

		//		redirect (controller: 'shoppingCart', action: 'showCartItems')
	}

	def showCartItems(){
		println "in show cart: session: "+SessionUtils.getSession().id
		def cartItems = shoppingCartService.getItems()//com.metasieve.shoppingcart.Shoppable.list()

		List cartItemMapList = []
		cartItems.each{item ->
			println "id: "+ item.id
			def product = Shoppable.findByShoppingItem(item)
			def name = product.toString()
			println "item Name: "+ name
			def iid = product.inventoryId
			def qty = shoppingCartService.getQuantity(item)
			Map nameQtyMap = [:]
			nameQtyMap.put("item", name)
			nameQtyMap.put("iId", iid)
			nameQtyMap.put("qty", qty)
			cartItemMapList.add(nameQtyMap)
		}

		render cartItemMapList as JSON
		//		render(view:'showCartItemList', model:['cartItemMapList':cartItemMapList])
	}

	
	def uploadPrescriptionFile(){
		println "in upload file" + params
		CommonsMultipartFile file = request.getFile('inputFile')
		println "size " + file.getSize()
		if(file.isEmpty()) {
			render (text:"File cannot be empty")
			return
		}
		else if(file.getSize() > 10*1000000)
		{
			render (text:"File size cannot exceed 10 MB")
			return
		}
		else {
			try {
				ObjectMetadata objectMetadata = new ObjectMetadata();
				objectMetadata.setContentLength(file.getInputStream().available())
				objectMetadata.setContentType(file.getContentType())

				String fileOriginalName = file.getOriginalFilename()
				Date uploadDate = Utility.getDateTimeInIST().getTime()
				String filePath = 'order_prescription/'+uploadDate.getTime()+'-'+fileOriginalName
				println "file name: "+filePath
				Upload upload = amazonWebService.transferManager.upload(new PutObjectRequest(Constants.amazonS3Bucket,filePath,file.getInputStream(),objectMetadata).withCannedAcl(CannedAccessControlList.PublicRead))

				while (!upload.done) {
					//					println "Transfer: $upload.description"
					//					println "  - State: $upload.state"
					//					println "  - Progress: $upload.progress.bytesTransfered"
					//					// Do work while we wait for our upload to complete…
					//					Thread.sleep(1000)
				}

				println "upload success: "+ upload
				String fileLocation = Constants.amazonS3Link+Constants.amazonS3Bucket+'/'+filePath
				println "file link: "+fileLocation
				def attachmentId = fileAttachmentService.saveFileAttachment(fileOriginalName, filePath, uploadDate)

				if(attachmentId == 0){
					render (text:message(code: 'fileAttachment.not.saved.message', default: 'Error in processing your request. Please try again!'))
					return
				}
				else
//					render (text:message(code: 'fileAttachment.saved.success.message', default: 'Your prescription has been uploaded successfully!'))
					def fileAttachment = ['attachmentId':attachmentId]
					render fileAttachment as JSON
			}
			catch (Exception exp) {
				render (text:message(code: 'fileAttachment.not.saved.message', default: 'Error in processing your request. Please try again!'))
				println "Exception: "+exp
			}
		}
	}
	
	//	@Secured(['ROLE_CONSUMER'])
	def showDeliveryDetails() {
		def attachmentId = params.attachmentId
		//		println "ODC properties: "+orderDetailsCommand.properties
		//println "PARAMS: "+orderDetailsCommand.properties
		OrderCollectionCommand orderDetails = new OrderCollectionCommand()
		orderDetails.circle = Constants.circleArray[0] //FIXME
		orderDetails.city = 'Mumbai'
		orderDetails.state = 'Maharastra'
		orderDetails.country = 'India'

		def deliveryDetails = [
			'orderDetails' : orderDetails,
			'attachmentId':attachmentId]

		render deliveryDetails as JSON
	}

	def saveOrder(OrderCollectionCommand orderCollCommand) {
		println "ODC: "+orderCollCommand.properties
		println "params: "+params

		//FIXME: do this in gsp
		orderCollCommand.offerCode = ordersService.checkOfferCode(orderCollCommand.offerCode)

		if (orderCollCommand.hasErrors()) {
			render (text: Constants.WEBSERVICE_ERROR_DELIVERYDETAILS)
			return
		}

		def orderRefId = orderCollectionService.saveOrderFromOrderCollection(orderCollCommand)
		println "orderRefId: "+orderRefId
		if(!orderRefId) {
			render (text: Constants.WEBSERVICE_ERROR_DELIVERYDETAILS)
			return
//			redirect(controller: 'patientProfile', action: 'showDeliveryDetails', params:params)
		}

		def cartItems = shoppingCartService.getItems()//com.metasieve.shoppingcart.Shoppable.list()
		
		List orderDetailsList = []
		cartItems.each{item ->
			println "id: "+ item.id
			def product = Shoppable.findByShoppingItem(item)
			def qty = shoppingCartService.getQuantity(item)
			OrderDetailsCommand orderDetails = ordersService.saveOrderFromBrandOrdered(product, qty, orderCollCommand.orderCollectionId)
			orderDetailsList.add(orderDetails)
		}
		
		orderCollectionService.sendNewOrderEmail(orderCollCommand, orderDetailsList)
		
		def checkedOutItems = shoppingCartService.checkOut()
		println "size: "+checkedOutItems.size()

		redirect(controller: 'webservice', action: 'showOrderCollectionDetails', params:[trackingId: orderRefId,offerCode:orderCollCommand.offerCode])
	}
	
	def showOrderCollectionDetails() {
		def trackingId = params.trackingId
		def offerCode = params.offerCode
		//		def orderStatus = ordersService.getOrderStatusFromOrderId(orderId)

		//Orders order = ordersService.getOrderFromOrderId(uId)
		OrderCollection orderCollection = orderCollectionService.getOrderFromRefId(trackingId?.toUpperCase())
		if(orderCollection) {
			List orderList = ordersService.getListOfOrdersFromOrderCollectionId(orderCollection.orderCollectionId)
			println "items count: "+orderList.size()
			List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(orderList)
			//			OrderStatusCommand orderStatusCommand = ordersService.populateOrderStatusFromOrder(order)
			//			orderStatusCommand.trackingId = uId
			//			orderStatusCommand.offerCode = offerCode
			//			println "OrderStatusCommand: "+orderStatusCommand.properties
			PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(orderCollection.personId)
			
			def orderStatus = ['orderDetailsList':orderDetailsList, 'patient':patient, 'trackingId': trackingId, 'offerCode':offerCode]
			
			render orderStatus as JSON
//			render(view: "orderCollectionDetails", model: [orderDetailsList:orderDetailsList, patient:patient, trackingId: trackingId, offerCode:offerCode])
		}
		else
		{
			render (text: Constants.WEBSERVICE_ERROR_TRACKINGID)
		}
	}

	def cancelOrder() {
		println "orderId: "+params.orderId
		def orderId = params.orderId
		def trackingId = params.trackingId
		def status = ordersService.cancelOrderAndSave(orderId)

		if(status == 0)
			render (text: "Error in proccessing your request. Please try again later!")
		else{
			redirect(controller: 'webservice', action: 'showOrderCollectionDetails', params:[trackingId: trackingId])
		}
	}

	def sendFeedback(){
		println "PARAMS: "+params

		String body = "Name: "+params.name + "\nEmail: "+params.emailID+ "\nMessage: "+params.message
		emailService.sendEMail (
				Constants.supportEmail,
				message(code: 'email.subject.feedback'),
				body)

		def status = feedbackService.saveFeedback(params.name, params.emailID, params.message)

		if(status == 0)
			render (text: "Error in processing your request. Please try again!")
		else
			render (text: "Your feedback has been recorded. Thanks!")

		//		request.withFormat {
		//			form multipartForm {
		//				render (text: "Your feedback has been recorded. Thanks!")
		//			}
		//		}
	}

	def getCircleArray(){

		def circleArray = ['circleArray':Constants.circleArray]

		render circleArray as JSON
	}

	def isValidOfferCode(){
		String couponCode = params.offerCode?.toUpperCase()
		couponCode = ordersService.checkOfferCode(couponCode)
		if (!couponCode.equals("")) {
			render (text: 'Coupon code applied successfully!')// true//'Coupon code entered is invalid. Click "Continue" to confirm order anyway. Click "Retry" to enter coupon code again'
		}
		else
			render (text: 'Invalid coupon code')
	}
<<<<<<< HEAD
	
=======

>>>>>>> origin/shopping-cart-branch
	def isAppUpToDate(){
		return 1
	}
}
