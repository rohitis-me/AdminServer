package i2i.AdminServer

import static org.springframework.http.HttpStatus.*

import java.awt.GraphicsConfiguration.DefaultBufferCapabilities;

import grails.converters.JSON
import grails.plugin.awssdk.AmazonWebService
import groovy.json.JsonSlurper
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
import com.metasieve.shoppingcart.Quantity
import com.metasieve.shoppingcart.SessionUtils
import com.metasieve.shoppingcart.Shoppable
import com.metasieve.shoppingcart.ShoppingCartService

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

	def index() {
	}

	//TODO change once data is got from branddatabase
	def listOfBrandNameStartingWith() {
		//		println "AUTO COMPLETE: received params: "+params
		String searchTerm = params.term
		String circle = params.circle
		String city = params.city

		List drugList = brandDatabaseService.getBrandDataList(searchTerm, circle, city)

		List brandMapList = []
		drugList.each {
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
			}
			else{
				def brandRequestData = ['brandName':searchTerm, 'circle': circle,'availabilityFlag':availabilityFlag]
				render brandRequestData as JSON
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

//	def addItemToCart(){
//		println "add item: "+ params
//		String inventoryId = params.inventoryId
//		String storeId = params.storeId
//		BrandOrdered brandOrdered = BrandOrdered.findByInventoryIdAndStoreId(inventoryId,storeId)
//		if(!brandOrdered) {
//			brandOrdered = new BrandOrdered()
//
//			brandOrdered.brandName = params.brandName
//			brandOrdered.inventoryId = params.inventoryId
//			brandOrdered.brandId = params.brandId
//			brandOrdered.storeId = params.storeId //FIXME store id is not unique to inventoryId
//
//			if(!brandOrdered.save(flush:true)) {
//				brandOrdered.errors.each { println "error saving brandOrdered: "+it }
//				render (text: "Error")
//				return
//			}
//			//			println "save brandOrdered success"
//		}
//
//		int quantity =  params.quantity.toInteger()
//		if(brandOrdered && brandOrdered.shoppingItem){
//			shoppingCartService.addToShoppingCart(brandOrdered, quantity)
//
//			render (text: "Success")
//		}
//		else
//			render (text: "Error")
//	}
	
	//	def test(){
	//		def restResponse = '[{"brandName": "ABANA", "inventoryId":"23386", "brandId":"", "storeId":"4", "quantity": 1},{"brandName": "DOLO 650", "inventoryId":"26376", "brandId":"", "storeId":"4", "quantity": 1}]'
	//		println "restResponse: "+restResponse
	//
	//		redirect (controller: 'webservice', action: 'addItemsToCart', params:[cartItemList: restResponse])

	//		String inputFilePath = 'C:/Users/ChandU/Pictures/12 May/IMG_123.jpg'
	//		redirect (controller: 'webservice', action: 'uploadPrescriptionFile', params:[inputFilePath: inputFilePath])
	//	}

//	def addItemsToCart(){
//		println "add item: "+ params
//		def restResponse = params.cartItemList
//		// Parse the response
//		def cartItems = new JsonSlurper().parseText( restResponse )
//
//		cartItems.each {
//			println it
//			boolean success = true
//			String inventoryId = it.inventoryId
//			String storeId = it.storeId
//			BrandOrdered brandOrdered = BrandOrdered.findByInventoryIdAndStoreId(inventoryId,storeId)
//			if(!brandOrdered) {
//				brandOrdered = new BrandOrdered()
//
//				brandOrdered.brandName = it.brandName
//				brandOrdered.inventoryId = inventoryId
//				brandOrdered.brandId = it.brandId
//				brandOrdered.storeId = storeId //FIXME store id is not unique to inventoryId
//
//				if(!brandOrdered.save(flush:true)) {
//					brandOrdered.errors.each { println "error saving brandOrdered: "+it }
//					//					render (text: "Error")
//					success = false
//				}
//			}
//
//			if(success){
//				int quantity =  it.quantity.toInteger()
//				if(brandOrdered && brandOrdered.shoppingItem){
//					shoppingCartService.addToShoppingCart(brandOrdered, quantity)
//					//				render (text: "Success")
//				}
//			}
//			//			else
//			//				render (text: "Error")
//		}
//		render (text: "Success")
//	}
//
//	def removeItemFromCart(){
//		String inventoryId = params.inventoryId
//		int qty = params.quantity.toInteger()
//
//		BrandOrdered brandOrdered = BrandOrdered.findByInventoryId(inventoryId)
//		if(brandOrdered && brandOrdered.shoppingItem){
//			//			def qty = shoppingCartService.getQuantity(brandOrdered.shoppingItem)
//			//			println "qty: "+ qty
//			shoppingCartService.removeFromShoppingCart(brandOrdered, qty)
//
//			render (text: "Success")
//		}
//		else
//			render (text: "Error")
//
//		//		redirect (controller: 'shoppingCart', action: 'showCartItems')
//	}
//
//	def showCartItems(){
//		//		println "in show cart: session: "+SessionUtils.getSession().id
//		def cartItems = shoppingCartService.getItems()//com.metasieve.shoppingcart.Shoppable.list()
//
//		List cartItemMapList = []
//		cartItems.each{item ->
//			//			println "id: "+ item.id
//			def product = Shoppable.findByShoppingItem(item)
//			def name = product.toString()
//			//			println "item Name: "+ name
//			def iid = product.inventoryId
//			def qty = shoppingCartService.getQuantity(item)
//			Map nameQtyMap = [:]
//			nameQtyMap.put("item", name)
//			nameQtyMap.put("iId", iid)
//			nameQtyMap.put("qty", qty)
//			cartItemMapList.add(nameQtyMap)
//		}
//
//		render cartItemMapList as JSON
//		//		render(view:'showCartItemList', model:['cartItemMapList':cartItemMapList])
//	}
//
//	def changeCartItemQuantity(){
//		println "change quantity: "+ params
//		int qty =  params.quantity.toInteger()
//		String inventoryId = params.inventoryId
//		def shoppingCart = shoppingCartService.getShoppingCart()
//
//		if(shoppingCart){
//			def cartItems = shoppingCartService.getItems()
//			cartItems.each{item ->
//				def product = Shoppable.findByShoppingItem(item)
//				if(inventoryId == product.inventoryId){
//					def quantity = Quantity.findByShoppingCartAndShoppingItem(shoppingCart, item)
//					if (quantity) {
//						quantity.value = qty
//						quantity.save()
//						//						shoppingCart.save()
//					}
//				}
//			}
//		}
//
//		render (text: "Success") //redirect (controller: 'shoppingCart', action: 'showCartItems')
//	}
//
//	def clearShoppingCart(){
//		//		def session = SessionUtils.getSession()
//		shoppingCartService.emptyShoppingCart()
//		render (text: "Success")
//	}


	def uploadPrescriptionFile(){
		println "in upload file" + params
		//		List buckets
		CommonsMultipartFile file = request.getFile('inputFile')
		//		println "size " + file.getSize()
		if(file.isEmpty()) {
			render (text:"File cannot be empty")
			return
		}
		else if(file.getSize() > 10*1024*1024)
		{
			render (text:"File size cannot exceed 10 MB")
			return
		}

		try {
			ObjectMetadata objectMetadata = new ObjectMetadata();
			objectMetadata.setContentLength(file.getInputStream().available())
			objectMetadata.setContentType(file.getContentType())

			String fileOriginalName = file.getOriginalFilename()
			Date uploadDate = Utility.getDateTimeInIST().getTime()
			String filePath = 'order_prescription/'+uploadDate.getTime()+'-'+fileOriginalName
			//				println "file name: "+filePath
			Upload upload = amazonWebService.transferManager.upload(new PutObjectRequest(Constants.amazonS3Bucket,filePath,file.getInputStream(),objectMetadata).withCannedAcl(CannedAccessControlList.PublicRead))

//			while (!upload.done) {
				//					println "Transfer: $upload.description"
				//					println "  - State: $upload.state"
				//					println "  - Progress: $upload.progress.bytesTransfered"
				//					// Do work while we wait for our upload to complete…
				//					Thread.sleep(1000)
//			}
			
			String fileLocation = Constants.amazonS3Link+Constants.amazonS3Bucket+'/'+filePath
			def attachmentId = fileAttachmentService.saveFileAttachment(fileOriginalName, filePath, uploadDate)

			if(attachmentId == 0){
				render (text:message(code: 'fileAttachment.not.saved.message', default: 'Error in processing your request. Please try again!'))
				return
			}
			else{
				def fileAttachment = ['attachmentId':attachmentId]
				render fileAttachment as JSON
			}
		}
		catch (Exception exp) {
			render (text:message(code: 'fileAttachment.not.saved.message', default: 'Error in processing your request. Please try again!'))
			println "Exception: "+exp
		}
	}

//	def showDeliveryDetails() {
//		def attachmentId = params.attachmentId
//		//		println "ODC properties: "+orderDetailsCommand.properties
//		//println "PARAMS: "+orderDetailsCommand.properties
//		OrderCollectionCommand orderDetails = new OrderCollectionCommand()
//		orderDetails.circle = Constants.circleArray[0] //FIXME
//		orderDetails.city = 'Mumbai'
//		orderDetails.state = 'Maharastra'
//		orderDetails.country = 'India'
//
//		def deliveryDetails = [
//			'orderDetails' : orderDetails,
//			'attachmentId':attachmentId]
//
//		render deliveryDetails as JSON
//	}
//
//	def saveOrder(OrderCollectionCommand orderCollCommand) {
//		println "ODC: "+orderCollCommand.properties
//		//		println "params: "+params
//
//		//FIXME: do this in gsp
//		orderCollCommand.offerCode = ordersService.checkOfferCode(orderCollCommand.offerCode)
//
//		if (orderCollCommand.hasErrors()) {
//			orderCollCommand.errors.each { println it }
//			render (text: "Enter valid information")
//			return
//		}
//
//		def orderRefId = orderCollectionService.saveOrderFromOrderCollection(orderCollCommand)
//		//		println "orderRefId: "+orderRefId
//		if(!orderRefId) {
//			render (text: "Enter valid information")
//			return
//			//			redirect(controller: 'patientProfile', action: 'showDeliveryDetails', params:params)
//		}
//
//		def cartItems = shoppingCartService.getItems()//com.metasieve.shoppingcart.Shoppable.list()
//		if(cartItems.size() < 1){
//			render (text: "No items in the cart")
//			return
//		}
//
//		List orderDetailsList = []
//		cartItems.each{item ->
//			//			println "id: "+ item.id
//			def product = Shoppable.findByShoppingItem(item)
//			def qty = shoppingCartService.getQuantity(item)
//			OrderDetailsCommand orderDetails = ordersService.saveOrderFromBrandOrdered(product, qty, orderCollCommand.orderCollectionId)
//			orderDetailsList.add(orderDetails)
//		}
//
//		orderCollectionService.sendNewOrderEmail(orderCollCommand, orderDetailsList)
//
//		shoppingCartService.emptyShoppingCart()
//		//		def checkedOutItems = shoppingCartService.checkOut()
//		//		println "size: "+checkedOutItems.size()
//
//		OrderCollection orderCollection = orderCollectionService.getOrderFromRefId(orderRefId)
//		if(orderCollection) {
//			List orderList = ordersService.getListOfOrdersFromOrderCollectionId(orderCollection.orderCollectionId)
//			//			println "items count: "+orderList.size()
//			List listOrderDetails = ordersService.getListOfOrderDetailsFromOrdersList(orderList)
//			PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(orderCollection.personId)
//
//			def orderStatus = ['orderDetailsList':listOrderDetails, 'patient':patient, 'trackingId': orderRefId, 'offerCode':orderCollCommand.offerCode]
//
//			render orderStatus as JSON
//		}
//		else
//		{
//			render (text: "Error Processing your request.Please try again!")
//		}
//	}

	def addItemsToCartAndPlaceOrder(){
		println "add item: "+ params
		def restResponse = params.cartItemList
		// Parse the response
		def cartItems = new JsonSlurper().parseText( restResponse )

		if(!cartItems || (cartItems && cartItems.size() < 1) ){
			render (text: "No items in the cart")
			return
		}

		OrderCollectionCommand orderCollCommand = new OrderCollectionCommand()
		orderCollCommand.offerCode = params.offerCode
		orderCollCommand.attachmentId = params.attachmentId
		orderCollCommand.name = params.name
		orderCollCommand.phoneNumber = params.phoneNumber
		orderCollCommand.emailID = params.emailID
		orderCollCommand.age = params.age
		orderCollCommand.addressLine1 = params.addressLine1
		orderCollCommand.addressLine2 = params.addressLine2
		orderCollCommand.circle = params.circle
		orderCollCommand.city = params.city
		orderCollCommand.state = params.state
		orderCollCommand.country = params.country

		println "ODC: "+orderCollCommand.properties
		if (orderCollCommand.hasErrors()) {
			orderCollCommand.errors.each { println it }
			render (text: "Enter valid information")
			return
		}

		//FIXME: do this in gsp
		orderCollCommand.offerCode = ordersService.checkOfferCode(orderCollCommand.offerCode)
		def orderRefId = orderCollectionService.saveOrderFromOrderCollection(orderCollCommand)
		//		println "orderRefId: "+orderRefId
		if(!orderRefId) {
			render (text: "Enter valid information")
			return
		}

		List orderDetailsList = []
		cartItems.each {
			println it
			String inventoryId = it.inventoryId
			String storeId = it.storeId
			BrandOrdered brandOrdered = new BrandOrdered()

			brandOrdered.brandName = brandDatabaseService.getBrandNameFromId(it.brandId, inventoryId)//it.brandName
			brandOrdered.inventoryId = inventoryId
			brandOrdered.brandId = it.brandId
			brandOrdered.storeId = storeId //FIXME store id is not unique to inventoryId

			int quantity =  it.quantity.toInteger()
			if(brandOrdered && quantity){
				OrderDetailsCommand orderDetails = ordersService.saveOrderFromBrandOrdered(brandOrdered, quantity, orderCollCommand.orderCollectionId)
				orderDetailsList.add(orderDetails)
			}
		}

		if(!orderDetailsList || (orderDetailsList && orderDetailsList.size() < 1) ){
			render (text: "Invalid input")
			return
		}

		orderCollectionService.sendNewOrderEmail(orderCollCommand, orderDetailsList)

		OrderCollection orderCollection = orderCollectionService.getOrderFromRefId(orderRefId)
		if(orderCollection) {
			List orderList = ordersService.getListOfOrdersFromOrderCollectionId(orderCollection.orderCollectionId)
			List listOrderDetails = ordersService.getListOfOrderDetailsFromOrdersList(orderList)
			PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(orderCollection.personId)

			def orderStatus = ['orderDetailsList':listOrderDetails, 'patient':patient, 'trackingId': orderRefId, 'offerCode':orderCollCommand.offerCode]

			render orderStatus as JSON
		}
		else
		{
			render (text: "Error Processing your request.Please try again!")
		}
	}


	def showOrderCollectionDetails() {
		def trackingId = params.trackingId
		def offerCode = params.offerCode

		OrderCollection orderCollection = orderCollectionService.getOrderFromRefId(trackingId?.toUpperCase())
		if(orderCollection) {
			List orderList = ordersService.getListOfOrdersFromOrderCollectionId(orderCollection.orderCollectionId)
			List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(orderList)
			PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(orderCollection.personId)
			def orderStatus = ['orderDetailsList':orderDetailsList, 'patient':patient, 'trackingId': trackingId, 'offerCode':offerCode]

			render orderStatus as JSON
		}
		else
		{
			render (text: Constants.WEBSERVICE_ERROR_TRACKINGID)
		}
	}

	//	def cancelOrder() {
	////		println "orderId: "+params.orderId
	//		def orderId = params.orderId
	//		def trackingId = params.trackingId
	//		def status = ordersService.cancelOrderAndSave(orderId)
	//
	//		if(status == 0)
	//			render (text: "Error in proccessing your request. Please try again later!")
	//		else{
	////			redirect(controller: 'webservice', action: 'showOrderCollectionDetails', params:[trackingId: trackingId])
	//
	//			OrderCollection orderCollection = orderCollectionService.getOrderFromRefId(trackingId?.toUpperCase())
	//			if(orderCollection) {
	//				List orderList = ordersService.getListOfOrdersFromOrderCollectionId(orderCollection.orderCollectionId)
	////				println "items count: "+orderList.size()
	//				List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(orderList)
	//				PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(orderCollection.personId)
	//
	//				def orderStatus = ['orderDetailsList':orderDetailsList, 'patient':patient, 'trackingId': trackingId, 'offerCode':offerCode]
	//
	//				render orderStatus as JSON
	//			}
	//			else
	//			{
	//				render (text: "Error Processing your request.Please try again!")
	//			}
	//
	//		}
	//	}

	def cancelOrder(){
		def trackingId = params.trackingId

		OrderCollection orderCollection = orderCollectionService.getOrderFromRefId(trackingId?.toUpperCase())
		if(orderCollection) {
			def status = ordersService.cancelOrderItemsAndSave(orderCollection.orderCollectionId)
			if(status == 0)
				render(text: "Error in proccessing your request. Please try again later!")
			else{
				render(text: "Success")
			}
		}
		else
			render(text: "Error in proccessing your request. Please try again later!")
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
	}

	def getCircleArray(){
		println ""+params.city
		def circleArray = []
		if(params.city == 'Chennai')
			circleArray = ['circleArray':Constants.circleArray_Chennai]
		if(params.city == 'Mumbai')
			circleArray = ['circleArray':Constants.circleArray_Mumbai]

		render circleArray as JSON
	}

	def getCityArray(){
		def cityArray = ["Mumbai"]//, "Chennai"]
		render cityArray as JSON
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

	def isAppUpToDate(){
		def appVersion = params.appVersion
		return 1
	}

	def setLocation(){
		def session = SessionUtils.getSession()

		if(params.circle != session?.circle)
			shoppingCartService.emptyShoppingCart()

		if(params.circle){
			session.circle = params.circle
			session.city = params.city
		}

		render(text: "Success")
	}

}
