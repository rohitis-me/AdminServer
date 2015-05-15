package i2i.AdminServer

import grails.converters.JSON
import i2i.AdminServer.ClientSync.InventoryService
import i2i.AdminServer.User.EmailService;
import i2i.AdminServer.User.FeedbackService;
import i2i.AdminServer.Constants
//import com.google.gson.reflect.TypeToken

class WebserviceController {

	SearchService searchService
	InventoryService inventoryService
	BrandDatabaseService brandDatabaseService
	StoreService storeService
	OrdersService ordersService
	EmailService emailService
	FeedbackService feedbackService
	
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

		String searchTerm = params.brandName //'amlogard'
		String circle = params.circle//Constants.circleArray[0]
		String brandId = params.brandId

		//TODO: taking inventoryId into consideration for now
		String inventoryId = params.inventoryId

		boolean availabilityFlag= false

		//FIXME filter stores with circle also||get brandId against inventoryId and search for all stores where it is available
		if(inventoryId){
			println "inventoryId available: "+inventoryId
			List stores = searchService.getListOfStoresWhereBrandIsAvailableUsingInventoryIdAndCircle(inventoryId, circle)
			if(stores)
			{
				stores.each {store-> println "STORE:"+store.storeName }
				//FIXME: get delivery time from store
				availabilityFlag= true
				
				def searchList = [
				    'storesList': stores,
					'availabilityFlag':availabilityFlag, 
					'brandId':brandId, 
					'inventoryId':inventoryId,
					'brandName': searchTerm, 
					'circle': circle]
				
				render searchList as JSON
//				render (view:"searchList", model: [storesList:stores, availabilityFlag:availabilityFlag, brandId:brandId, inventoryId:inventoryId, brandName: searchTerm, circle: circle])
			}
			else
			{
				stores = searchService.getListOfStoresInCircle(circle)
				stores.each {store-> println store.storeName }
				//FIXME: get delivery time from store
				availabilityFlag = false
				
				def searchList = [
					'storesList': stores,
					'availabilityFlag':availabilityFlag,
					'brandId':brandId,
					'inventoryId':inventoryId,
					'brandName': searchTerm,
					'circle': circle]
				
				render searchList as JSON
//				render (view:"searchList", model: [storesList:stores, availabilityFlag:availabilityFlag, brandId:brandId, inventoryId:inventoryId, brandName: searchTerm, circle: circle])
			}
		}
		else if(brandId) {
			//			List stores = searchService.getListOfStoresWhereBrandIsAvailable(brandId)
			List stores = new ArrayList<Store>()
			//FIXME: not scalable. Else condition does not use circle
			stores = searchService.getListOfStoresWhereBrandIsAvailable(brandId)
			if(stores.size() >0)
				availabilityFlag= true
			else {
				availabilityFlag = false
				stores = searchService.getListOfStoresInCircle(circle)
			}
			stores.each {store-> println store.storeName }
			
			def searchList = [
				'storesList': stores,
				'availabilityFlag':availabilityFlag,
				'brandId':brandId,
				'inventoryId':inventoryId,
				'brandName': searchTerm,
				'circle': circle]
			
			render searchList as JSON
//			render (view:"searchList", model: [storesList:stores, availabilityFlag:availabilityFlag, brandId: brandId, brandName: searchTerm, circle: circle])
		}
		else
		{
			List drugList = brandDatabaseService.getBrandDataList(searchTerm,circle)
			
			def searchSuggestions = [
				'drugList':drugList,
				'brandName': searchTerm, 
				'circle': circle]
			
			render searchSuggestions as JSON
//			render (view:"searchSuggestions", model: [drugList:drugList, brandName: searchTerm, circle: circle])
		}
		//		render "error"
	}
	
	//	@Secured(['ROLE_CONSUMER'])
	def showDeliveryDetails(OrderDetailsCommand orderDetailsCommand) {
		println "ODC properties: "+orderDetailsCommand.properties
		//println "PARAMS: "+orderDetailsCommand.properties
		
		if(orderDetailsCommand.brandId){
			def brandData = brandDatabaseService.getBrandDataFromBrandId(orderDetailsCommand.brandId)
			def storeData = storeService.getStoreDataFromStoreId(orderDetailsCommand.storeId)
			println "Branddata: "+brandData.brandId+" storedata: "+storeData.storeId
			OrderDetailsCommand orderDetails = ordersService.populateOrderDetailsFromStoreAndBrandData(storeData, brandData)
			orderDetails.deliveryHours = orderDetailsCommand.deliveryHours
			println "success"
		
			//FIXME
			orderDetails.circle = orderDetailsCommand.circle
			orderDetails.city = 'Chennai'
			orderDetails.state = 'Tamil Nadu'
			orderDetails.country = 'India'
			orderDetails.age = 40
			orderDetails.quantity = 1
			
			def deliveryDetails = [
				'orderDetails' : orderDetails, 
				'brandData':brandData, 
				'storeName':storeData?.storeName, 
				'isEmergencyDeliveryAvailable':storeData?.isEmergencyDeliveryAvailable]
			
			render deliveryDetails as JSON
//			render(view:'deliveryDetails', model: [orderDetails : orderDetails, brandData:brandData, storeName:storeData?.storeName, isEmergencyDeliveryAvailable:storeData?.isEmergencyDeliveryAvailable])
		}
		else if(orderDetailsCommand.inventoryId){
			def brandData = inventoryService.getBrandDataFromInventoryId(orderDetailsCommand.inventoryId)
			def storeData = storeService.getStoreDataFromStoreId(orderDetailsCommand.storeId)
			println "Branddata: "+brandData.brandName+" storedata: "+storeData.storeId
			OrderDetailsCommand orderDetails = ordersService.populateOrderDetailsFromStoreAndBrandData(storeData, brandData)
			orderDetails.inventoryId = orderDetailsCommand.inventoryId
			orderDetails.deliveryHours = orderDetailsCommand.deliveryHours
			println "success"
		
			//FIXME
			orderDetails.circle = orderDetailsCommand.circle
			orderDetails.city = 'Chennai'
			orderDetails.state = 'Tamil Nadu'
			orderDetails.country = 'India'
			orderDetails.age = 40
			orderDetails.quantity = 1
			
			def deliveryDetails = [
				'orderDetails' : orderDetails,
				'brandData':brandData,
				'storeName':storeData?.storeName,
				'isEmergencyDeliveryAvailable':storeData?.isEmergencyDeliveryAvailable]
			
			render deliveryDetails as JSON
//			render(view:'deliveryDetails', model: [orderDetails : orderDetails, brandData:brandData, storeName:storeData?.storeName, isEmergencyDeliveryAvailable:storeData?.isEmergencyDeliveryAvailable])
		}
	}

	def saveOrder(OrderDetailsCommand orderDetailsCommand) {
		println "ODC: "+orderDetailsCommand.properties
		
		orderDetailsCommand.offerCode = ordersService.checkOfferCode(orderDetailsCommand.offerCode)
		
		if (orderDetailsCommand.hasErrors()) {
			def orderStatus = ['orderDetails':orderDetailsCommand]
			render orderStatus as JSON
			return
		}
		
		def uId = ordersService.saveOrderFromOrderDetails(orderDetailsCommand)

		println "orderId: "+uId
		println "inventoryId: "+orderDetailsCommand.inventoryId

		if(uId) {
			Orders order = ordersService.getOrderFromUId(uId)
			if(order) {
				OrderStatusCommand orderStatusCommand = ordersService.populateOrderStatusFromOrder(order)
				orderStatusCommand.trackingId = uId
				println "OrderStatusCommand: "+orderStatusCommand.properties
				
				def orderStatus = ['orderStatusCommand':orderStatusCommand]
				
				render orderStatus as JSON
//				redirect(controller: 'webservice', action: 'showOrderStatus', params:[trackingId: uId])
			}
			else{	
				render (text: Constants.WEBSERVICE_ERROR_TRACKINGID)
			}
		}
		else {
			render (text: Constants.WEBSERVICE_ERROR_DELIVERYDETAILS)
//			flash.message = message(code: 'save.error.label', default: 'Enter valid information')
//			redirect(controller: 'webservice', action: 'showDeliveryDetails', params:params)
		}
	}
	
//	def showOrderStatus() {
//		def uId = params.trackingId
//		//		def orderStatus = ordersService.getOrderStatusFromOrderId(orderId)
//
//		//Orders order = ordersService.getOrderFromOrderId(uId)
//		Orders order = ordersService.getOrderFromUId(uId)
//		if(order) {
//			OrderStatusCommand orderStatusCommand = ordersService.populateOrderStatusFromOrder(order)
//			orderStatusCommand.trackingId = uId
//			println "OrderStatusCommand: "+orderStatusCommand.properties
//			
//			def gson = gsonBuilder.create()
//			def orderStatus = gson.toJson(orderStatusCommand).toString()
//			
//			render (text: orderStatus)
////			render(view: "orderStatus", model: [orderStatusCommand: orderStatusCommand])
//		}
//		else
//		{
//			def gson = gsonBuilder.create()
//			String orderStatus = 'Invalid order id'
//			
//			render (text: orderStatus)
////			render(view: "errors/pageNotFound")
//		}
//	}
	
	def showTrackedOrderDetails(){
		String trackingId = params?.trackingId //'Q9YH'
		String uId = trackingId?.toUpperCase()
		println "uId: "+uId
		
		Orders order = ordersService.getOrderFromUId(uId)
		if(order) {
			OrderStatusCommand orderStatusCommand = ordersService.populateOrderStatusFromOrder(order)
			orderStatusCommand.trackingId = uId
			println "OrderStatusCommand: "+orderStatusCommand.properties
			
//			def gson = gsonBuilder.create()
//			def trackOrderStatus = gson.toJson(orderStatusCommand).toString()
//				
//			render (text: trackOrderStatus)
			
			def trackOrderStatus = ['orderStatusCommand' : orderStatusCommand]
			
			render trackOrderStatus as JSON
//			render(view: "trackOrderStatus", model: [orderStatusCommand: orderStatusCommand, trackingId:trackingId])
		}
		else
		{
			render (text: Constants.WEBSERVICE_ERROR_TRACKINGID)
//			render(view: "trackOrderStatus",model: [trackingId:trackingId])
		}
	}
	
	def cancelOrder() {
		def orderId = params.orderId
		def status = ordersService.cancelOrderAndSave(orderId)

		if(status == 0)
			render (text: "Error in proccessing your request. Please try again later!")
		else{
			def order = ordersService.getOrderFromOrderId(orderId)
			render order as JSON
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
}
