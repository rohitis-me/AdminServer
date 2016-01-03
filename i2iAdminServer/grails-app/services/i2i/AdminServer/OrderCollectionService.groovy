package i2i.AdminServer

import grails.transaction.Transactional
import groovy.time.TimeCategory
import i2i.AdminServer.User.EmailService
import i2i.AdminServer.User.PatientProfile
import i2i.AdminServer.User.PatientProfileService
import i2i.AdminServer.Util.Utility

@Transactional
class OrderCollectionService {

	BrandDatabaseService brandDatabaseService
	StoreService storeService
	PatientProfileService patientProfileService
	EmailService emailService
	OrdersService ordersService
	def grailsApplication

	private final String tag= 'OrderService'

	def serviceMethod() {
	}

	def populateOrderDetailsFromPatientProfile(PatientProfile patient) {
		def orderDetailsCommand = new OrderDetailsCommand()
		orderDetailsCommand.patientName = patient.name
		orderDetailsCommand.doctorName = patient.doctorName
		orderDetailsCommand.phoneNumber = patient.phoneNumber
		orderDetailsCommand.emailID = patient.emailID
		orderDetailsCommand.age = patient.age
		orderDetailsCommand.addressLine1 = patient.addressLine1
		orderDetailsCommand.addressLine2 = patient.addressLine2
		orderDetailsCommand.circle = patient.circle
		orderDetailsCommand.city = patient.city
		orderDetailsCommand.state = patient.state
		orderDetailsCommand.country = patient.country
		return orderDetailsCommand
	}

	def populateOrderCollectionCommandFromPatientId(def patientId){
		OrderCollectionCommand orderCollCommand = new OrderCollectionCommand()
		PatientProfile patientProfile = patientProfileService.getPatientProfileDataFromPatientProfileId(patientId)
		if(patientProfile){
			orderCollCommand.patientName = patientProfile.name
			orderCollCommand.doctorName = patientProfile.doctorName
			orderCollCommand.phoneNumber = patientProfile.phoneNumber
			orderCollCommand.emailID = patientProfile.emailID
			orderCollCommand.age = patientProfile.age
			orderCollCommand.addressLine1 = patientProfile.addressLine1
			orderCollCommand.addressLine2 = patientProfile.addressLine2
			orderCollCommand.circle = patientProfile.circle
			orderCollCommand.city = patientProfile.city
			orderCollCommand.state = patientProfile.state
			orderCollCommand.country = patientProfile.country
		}
//		println 'orderCollCommand: '+ orderCollCommand.properties
		return orderCollCommand
	}
	
	def populateOrderCollectionCommandFromOrderCollection(OrderCollection order) {
		OrderCollectionCommand orderCollCommand = new OrderCollectionCommand()
		orderCollCommand.orderRefId = order.orderRefId
		orderCollCommand.orderCollectionId = order.orderCollectionId
		orderCollCommand.offerCode = order.offerCode
		orderCollCommand.attachmentId = order.attachmentId
		orderCollCommand.deliveryComment = order.deliveryComment
//		println "comment: "+ order.deliveryComment
		
		//FIXME
//		String storeId = storeService.getLoggedInStoreId()
//		if(storeId){
//			orderCollCommand.orderStatus  = ordersService.getOrderStatusFromOrderCollectionIdAndStoreId(order.orderCollectionId, storeId)
//		}
//		else{
			orderCollCommand.orderStatus  = ordersService.getOrderStatusFromOrderCollectionId(order.orderCollectionId)
//		}


		PatientProfile patientProfile = patientProfileService.getPatientProfileDataFromPatientProfileId(order.personId)
		if(patientProfile){
			orderCollCommand.patientName = patientProfile.name
			orderCollCommand.doctorName = patientProfile.doctorName
			orderCollCommand.phoneNumber = patientProfile.phoneNumber
			orderCollCommand.emailID = patientProfile.emailID
			orderCollCommand.age = patientProfile.age
			orderCollCommand.addressLine1 = patientProfile.addressLine1
			orderCollCommand.addressLine2 = patientProfile.addressLine2
			orderCollCommand.circle = patientProfile.circle
			orderCollCommand.city = patientProfile.city
			orderCollCommand.state = patientProfile.state
			orderCollCommand.country = patientProfile.country
		}
//		println 'orderCollCommand: '+ orderCollCommand.properties
		return orderCollCommand
	}

	def getListOfOrderCollectionIdsFromPatientId(String patientId){
		List orderCollIds = OrderCollection.findAllByPersonId(patientId)*.orderCollectionId
		return orderCollIds
	}
	
	def getListOfAttachmentIdsFromPatientId(String patientId){
		List attachmentIds = OrderCollection.findAllByPersonId(patientId)*.attachmentId
		return attachmentIds
	}
	
	def getOrderCollectionCommandFromOrderCollectionId(def orderCollectionId){
//		println "orderCollId "+ orderCollectionId
		OrderCollection order = OrderCollection.findByOrderCollectionId(orderCollectionId)
		return populateOrderCollectionCommandFromOrderCollection(order)
	}

	def getOrderCollectionCommandListFromOrderCollectionIdList(List orderCollectionIds){
//		println "orderCollIdCount "+ orderCollectionIds.size()
		List orderCollCommandList = new ArrayList<OrderCollectionCommand>()
		orderCollectionIds.each {
			orderCollCommandList.add(getOrderCollectionCommandFromOrderCollectionId(it))
		}
		return orderCollCommandList
	}

	def getOrderCollectionCommandListFromOrderCollectionIdListAndOrderStatus(List orderCollectionIds, byte orderStatus){
//		println "orderCollIdCount "+ orderCollectionIds.size()
		List orderCollCommandList = new ArrayList<OrderCollectionCommand>()
		orderCollectionIds.each {
			OrderCollectionCommand orderCollCommand = getOrderCollectionCommandFromOrderCollectionId(it)
			if(orderCollCommand.orderStatus == orderStatus)
				orderCollCommandList.add(orderCollCommand)
		}
		return orderCollCommandList
	}

	//FIXME
	def getEstimatedDeliveryTime(byte deliveryHours) {
		Date est = Utility.getDateTimeInIST().getTime()
		use( TimeCategory ) {
			est = est + deliveryHours.toInteger().hours
		}

		//		println "Time: "+est
		return est
	}

	def changeCommentAndSave(Long orderCollectionId, String comment){
//		println "delivery comment" + comment
		OrderCollection orderColl = OrderCollection.findByOrderCollectionId(orderCollectionId)
		if(orderColl){
			println "delivery comment" + comment
			orderColl.deliveryComment = comment
			saveOrder(orderColl)
		}
	}
	
	//FIXME: ETA
	def saveOrderFromOrderCollection(OrderCollectionCommand orderCollCommand, def patientId) {
		if(!orderCollCommand.validate()) {
			println "VALIDATION ERROR: "+orderCollCommand.properties
			orderCollCommand.errors.each { println it }
			return 0
		}
		if(!patientId){
			PatientProfile patient = patientProfileService.populatePatientProfileFromOrderCollCommand(orderCollCommand)
			patientId = patientProfileService.savePatientProfile(patient)
		}
		if(patientId!= 0) {
			//			orderDetails.estimatedDeliveryTime = Utility.getDateTimeInIST().addHours
			OrderCollection orderColl = new OrderCollection()
			orderColl.offerCode = orderCollCommand.offerCode
			orderColl.attachmentId = orderCollCommand.attachmentId
			orderColl.personId = patientId
			orderColl.orderRefId = getUniqueRandomString()
			def orderCollectionId = saveOrder(orderColl)
			orderCollCommand.orderRefId = orderColl.orderRefId

			if(orderCollectionId != 0) {
				orderCollCommand.orderCollectionId = orderCollectionId
				if(grailsApplication.config.env != Constants.env_LOCAL) {
					//OrderDetailsCommand orderDetailsCommand = populateOrderDetailsFromOrderColl(orderCollectionId)
					//sendNewOrderEmail(orderDetailsCommand)
				}
				return orderColl.orderRefId
			}
		}

		//if patient or order is not saved
		return 0
	}

	String getUniqueRandomString()
	{
		def orderRefId = Utility.generateRandomString()

		if(!getOrderFromRefId(orderRefId))
			return orderRefId

		else return getUniqueRandomString()
	}

	def saveOrder(OrderCollection order) {
		println "in save order coll"
		if(order.save(flush:true)) {
			println "saveorder collection success"
			return order.orderCollectionId
		}
		else {
			order.errors.each { println tag+" saveOrder "+it }
			return 0
		}
	}


	def getOrderFromRefId(def orderRefId)
	{
		OrderCollection order = OrderCollection.findByOrderRefId(orderRefId)
		return order
	}
	
	def getOrderCollectionFromOrderCollectionId(def orderCollId)
	{
		OrderCollection order = OrderCollection.findByOrderCollectionId(orderCollId)
		return order
	}

	def getOrderStatusFromOrderId(def orderId) {
		//		return 2
		Orders order = Orders.findByOrderId(orderId)
		return order.orderStatus
	}

	def getOrderFromOrderId(def orderId) {
		Orders order = Orders.get(orderId)
		return order
	}

	def changeOrderStatusAndSave(String storeId, Long orderCollectionId, String orderstatus, Date estDeliveryTime) {
		Orders order = getOrderFromOrderId(orderId)
		order.estimatedDeliveryTime = estDeliveryTime

		if(orderstatus=="2") order.orderStatus = Constants.ORDER_ACCEPTED
		else if(orderstatus=="3") order.orderStatus = Constants.ORDER_DISPATCHED
		else if(orderstatus=="4") order.orderStatus = Constants.ORDER_DELIVERED
		else if(orderstatus=="0") order.orderStatus = Constants.ORDER_CANCELLED
		else if(orderstatus=="-1") order.orderStatus = Constants.ORDER_REJECTED
		else order.orderStatus = Constants.ORDER_PLACED

		def status = saveOrder(order)

		if(status != 0 && grailsApplication.config.env != Constants.env_LOCAL) {
			OrderDetailsCommand orderDetailsCommand = populateOrderDetailsFromOrder(order)
			sendOrderStatusChangeEmail(orderDetailsCommand)
		}
		return status
	}

	def getListOfOrdersFromStoreId(String storeId) {
		//		println "getListOfOrdersFromStoreId: "+storeId
		List orderList = Orders.findAllByStoreId(storeId)
		return orderList
	}

	//	def getListOfOrdersFromStoreIdAndOrderStatus(String storeId, byte orderStatus) {
	//		println "getListOfOrdersFromStoreId: "+storeId +" OS: "+orderStatus
	//		List orderList = Orders.findAllByStoreIdAndOrderStatus(storeId,orderStatus)
	//		return orderList
	//	}

	def getListOfOrderDetailsFromOrdersList(List orderList) {
		List orderDetailsList = new ArrayList<OrderDetailsCommand>()
		orderList.each { order->
			orderDetailsList.add(populateOrderDetailsFromOrder(order))
		}
		return orderDetailsList
	}

	def sendNewOrderEmail(OrderCollectionCommand orderCollCommand, List orderDetailsList) {
		if(grailsApplication.config.env != Constants.env_LOCAL && orderDetailsList.size() > 0){
			//		OrderDetailsCommand orderDetails = populateOrderDetailsFromOrder(order)
			//			String emailId = storeService.getEmailIdFromStoreId(orderDetails.storeId)
			Store store = storeService.getStoreDataFromStoreId(orderDetailsList[0].storeId)
			//		println "OrderDEtailsCommand: "+orderDetails.properties
			emailService.sendOrderMail(store.emailId, Constants.mailSubject_NewOrder_Admin, orderCollCommand,orderDetailsList)
			emailService.sendTrackingIdToCustomer(Constants.mailSubject_NewOrder_Consumer, orderCollCommand,orderDetailsList, store)
		}
	}

	def sendOrderCancelEmail(OrderDetailsCommand orderDetails) {
		//		OrderDetailsCommand orderDetails = populateOrderDetailsFromOrder(order)
		String emailId = storeService.getEmailIdFromStoreId(orderDetails.storeId)
		Store store = storeService.getStoreDataFromStoreId(orderDetails.storeId)
		//		println "OrderDEtailsCommand: "+orderDetails.properties
		emailService.sendOrderMail(emailId, Constants.mailSubject_OrderCancel_Admin, orderDetails)
		emailService.sendTrackingIdToCustomer(Constants.mailSubject_OrderCancel_Consumer, orderDetails, store)
	}

	def sendOrderStatusChangeEmail(OrderDetailsCommand orderDetails) {
		//		OrderDetailsCommand orderDetails = populateOrderDetailsFromOrder(order)
		if(orderDetails.orderStatus == Constants.ORDER_ACCEPTED){
			Store store = storeService.getStoreDataFromStoreId(orderDetails.storeId)
			emailService.sendTrackingIdToCustomer(Constants.mailSubject_OrderAccepted_Consumer, orderDetails, store)
		}
		else if(orderDetails.orderStatus == Constants.ORDER_REJECTED){
			Store store = storeService.getStoreDataFromStoreId(orderDetails.storeId)
			emailService.sendTrackingIdToCustomer(Constants.mailSubject_OrderRejected_Consumer, orderDetails, store)
		}
		else if(orderDetails.orderStatus == Constants.ORDER_CANCELLED){
			Store store = storeService.getStoreDataFromStoreId(orderDetails.storeId)
			emailService.sendTrackingIdToCustomer(Constants.mailSubject_OrderCancel_Consumer, orderDetails, store)
		}
	}

	def checkOfferCode(String offerCode){
		offerCode = offerCode?.toUpperCase()
		if (offerCode) {
			if (offerCode.equals('PH137') || offerCode.equals('AP137') || offerCode.equals('SM137') || offerCode.equals('CS137') || offerCode.equals('HS137')) {
				return offerCode// true//'Coupon code entered is invalid. Click "Continue" to confirm order anyway. Click "Retry" to enter coupon code again'
			}
			else
				return ""
		}
		else
			return ""
	}
}
