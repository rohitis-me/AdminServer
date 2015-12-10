package i2i.AdminServer

import static org.springframework.http.HttpStatus.*
import grails.converters.JSON
import grails.plugin.awssdk.AmazonWebService
import grails.plugin.springsecurity.annotation.Secured
import grails.rest.RestfulController;
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
import com.metasieve.shoppingcart.SessionUtils
import com.metasieve.shoppingcart.ShoppingCartService

class WebserviceController extends RestfulController {
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
	AvailabilityService availabilityService
	def springSecurityService
	
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
			BrandDatabase brand = brandDatabaseService.getBrandDataFromId(brandId, inventoryId)
			
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
					'strength': brand?.strength,
					'noOfUnits':brand?.noOfUnits,
					'form':brand?.form,
					'mrp':brand?.mrp,
					'circle': circle,
					'deliveryHours':deliveryHours,
					'quantity': 1]

				render searchResult as JSON
			}
			else{
				def brandRequestData = [
					'brandName':searchTerm, 
					'strength': brand?.strength,
					'noOfUnits':brand?.noOfUnits,
					'form':brand?.form,
					'mrp':brand?.mrp,
					'circle': circle,
					'availabilityFlag':availabilityFlag]
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

	def getStoresWhereBrandIsAvailable(){
		String circle = params.circle
		//String brandId = brandDatabaseService.getBrandIdFromBrandName(searchTerm)
		String brandId = params.brandId
		String inventoryId = params.inventoryId
		
		List stores
		if(inventoryId)
			stores = searchService.getListOfStoresWhereBrandIsAvailableUsingInventoryIdAndCircle(inventoryId, circle)
		else if(brandId)
			stores = searchService.getListOfStoresWhereBrandIsAvailable(brandId)
		if(stores){
			List storeMapList = []
			stores.each {
					Map storeMap = [:]
					storeMap.put("storeId", it.storeId)
					storeMap.put("storeName", it.storeName)
					storeMapList.add(storeMap)
			}

			render storeMapList as JSON
		}
		else 
			render (text: "Currently this Brand is not available with any seller")
	}
	
	def requestNewBrand(BrandRequestCommand brandRequestCommand){
		println "BRC: "+brandRequestCommand.properties

		if (!brandRequestCommand || brandRequestCommand?.hasErrors()) {
			def brandRequestData = ['brandRequestCommand':brandRequestCommand]
			render brandRequestData as JSON
			return
		}

		String body = "BrandName: "+brandRequestCommand?.brandName + "\nEmail: "+brandRequestCommand?.emailID+ "\nPhone: "+brandRequestCommand?.phoneNumber +"\nCircle: "+brandRequestCommand?.circle
		String toAdd = Constants.adminEmail //+ ","+ "adhirajalai@gmail.com"+","+ "chandu@i2itech.co.in"
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

	
	def test(){
		
		String availabilityList = '[{"storeId": "1", "inventoryId":"1", "brandId":"", "availabilityIndex": 2, "availabilityId":1, "lastUpdatedTimeStamp":0},{"storeId": "1", "inventoryId":"2", "brandId":"", "availabilityIndex": 2, "availabilityId":2, "lastUpdatedTimeStamp":0}]'
		redirect (controller: 'webservice', action: 'updateAvailabilityData', params:[availabilityList: availabilityList])
		}



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
		if(params.patientId){
			orderCollCommand = orderCollectionService.populateOrderCollectionCommandFromPatientId(params.patientId)
		}
		else{
			orderCollCommand.patientName = params.patientName
			orderCollCommand.doctorName = params.doctorName
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
		}
		orderCollCommand.offerCode = params.offerCode
		orderCollCommand.attachmentId = params.attachmentId
		
		
		println "ODC: "+orderCollCommand.properties
		if (orderCollCommand.hasErrors()) {
			orderCollCommand.errors.each { println it }
			render (text: "Enter valid information")
			return
		}

		//FIXME: do this in gsp
		orderCollCommand.offerCode = ordersService.checkOfferCode(orderCollCommand.offerCode)
		def orderRefId = orderCollectionService.saveOrderFromOrderCollection(orderCollCommand, params.patientId)
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
	
	
	def checkAuthentication(){
		println "Request params: "+request.properties
		boolean chk = springSecurityService.isLoggedIn()
		
		println "Login: "+ springSecurityService.isLoggedIn()
		
			println "Principal: "+springSecurityService?.principal
			
		if(chk) {
			render (text: "authenticated "+springSecurityService?.principal)
		}
		else
		render(text: "not authenticated")
	}
	
	@Secured
	def checkAuthentication2(){
		println "Request params: "+request.properties
		println "Authenticated: "+springSecurityService?.principal
		render text:"Principal: "+springSecurityService?.principal
	}
	
	///Login related
	@Secured(['ROLE_CONSUMER'])
	def getUserDetails(){
		//def userId = params.userId
		def user = secUserService.getLoggedInUserProfile()
		println "logged in User: "+ user.properties
		def userProfile = ['username':user?.username, 'email':user?.email]
		render userProfile as JSON
		//render(view:'userProfile', model: [username:user?.username, email:user?.email]
	}
	
	def getUserOrdersList(){
		//def userId = params.userId
		List ordersList = secUserService.getLoggedInUserOrderDetailsList()
		//byte orderStatus = -2
		render ordersList as JSON
		//render(view:"orderDetailsList", model: [orderDetailsList: orderDetailsList, orderStatus:orderStatus])
	}
	
//	def showOrderDetails() {
//		println "showOrderDetails params: "+params
//		Long orderCollId = params.orderCollectionId?.toLong()
//
//		OrderCollectionCommand orderCollCommand = orderCollectionService.getOrderCollectionCommandFromOrderCollectionId(orderCollId)
//		List orderDetailsCommandList = ordersService.getListOfOrderDetailsCommandFromOrderCollectionId(orderCollId)
//
////		String attachmentLink = ""
////		if(orderCollCommand?.attachmentId)
////			attachmentLink = fileAttachmentService.getAttachmentLinkFromAttachmentId(orderCollCommand?.attachmentId)
//		render(view:"orderDetails", model: [orderDetailsCommandList: orderDetailsCommandList, orderCollCommand:orderCollCommand])//, attachmentLink:attachmentLink])
//	}
	
	def getUserSavedAddresses(){
		//def userId = params.userId
		List patientProfileList = secUserService.getLoggedInUserPatientDetailsList()
		render patientProfileList as JSON
		//render(view:'savedAddressList', model:['patientProfileList':patientProfileList])
		}
//PoS webservices

	// parameter: availabilityList json
	def updateAvailabilityData() {
		String availabilityDataJsonList= params.availabilityList
		
		//List availabilityList = new ArrayList<Availability>()
		def availabilityList = new JsonSlurper().parseText( availabilityDataJsonList )
		//Type availabilityDataType = new TypeToken<List<Availability>>(){}.getType()
		//def gson = gsonBuilder.create()
		//availabilityList = gson.fromJson(availabilityDataJsonList, availabilityDataType)
		
		int status = availabilityService.updateAvailabilityData(availabilityList)
		
		render(text:status)
		
	}
	
	//param: storeId
	def getLastUpdatedAvailabilityTimeStamp() {
		def storeId = params.storeId
		def lastUpdatedTimeStamp = availabilityService.getLastUpdatedAvailabilityTimeStamp(storeId)
		render(text:lastUpdatedTimeStamp)
	}
	

}
