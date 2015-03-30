package i2i.AdminServer

import grails.transaction.Transactional
import groovy.time.TimeCategory
import i2i.AdminServer.User.EmailService
import i2i.AdminServer.User.PatientProfile
import i2i.AdminServer.User.PatientProfileService
import i2i.AdminServer.Util.Utility
import i2i.AdminServer.Constants


@Transactional
class OrdersService {

	BrandDatabaseService brandDatabaseService
	StoreService storeService
	PatientProfileService patientProfileService
	EmailService emailService
	def grailsApplication

	private final String tag= 'OrderService'

	def serviceMethod() {
	}

	//	def populateOrderDetailsCommand(Store storeData, BrandDatabase brandData) {
	//		OrderDetailsCommand orderDetails = new OrderDetailsCommand()
	//		orderDetails.brandId = brandData.brandId
	//		orderDetails.brandName = brandData.brandName
	//		orderDetails.storeId = storeData.storeId
	//		orderDetails.storeName = storeData.storeName
	//		return orderDetails
	//	}

	def populateOrderDetailsFromPatientProfile(PatientProfile patient) {
		def orderDetailsCommand = new OrderDetailsCommand()
		orderDetailsCommand.name = patient.name
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

	def populateOrderDetailsFromOrder(Orders order) {
		//		println "populateOrderDetailsFromOrder ORDER: "+order.properties
		PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(order.personId)
		//		println "populateOrderDetailsFromOrder PATIENT: "+patient.properties
		OrderDetailsCommand orderDetails = populateOrderDetailsFromPatientProfile(patient)
		//		println "ORDERDETAILS: "+orderDetails.properties
		orderDetails.brandId = order.brandId
		orderDetails.inventoryId = order.inventoryId
		orderDetails.storeId = order.storeId
		orderDetails.brandName = brandDatabaseService.getBrandNameFromId(order.brandId, order.inventoryId)

		orderDetails.quantity = order.quantity
		orderDetails.estimatedDeliveryTime = order.estimatedDeliveryTime
		orderDetails.orderId = order.orderId
		orderDetails.orderStatus = order.orderStatus
		orderDetails.trackingId = order.uId
		orderDetails.isEmergencyDeliveryNeeded = order.isEmergencyDeliveryNeeded
		return orderDetails
	}

	def populateOrderStatusFromOrder(Orders order) {
		//		println "populateOrderStatusFromOrder ORDER: "+order.properties
		//		PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(order.personId)
		//		println "PATIENT: "+patient.properties
		//		OrderDetailsCommand orderDetails = populateOrderDetailsFromPatientProfile(patient)
		//		println "ORDERDETAILS: "+order.properties
		def orderStatusCommand = new OrderStatusCommand()
		orderStatusCommand.brandId = order.brandId
		orderStatusCommand.inventoryId = order.inventoryId
		orderStatusCommand.storeId = order.storeId
		orderStatusCommand.brandName = brandDatabaseService.getBrandNameFromId(order.brandId, order.inventoryId)

		Store store = storeService.getStoreDataFromStoreId(order.storeId)
		orderStatusCommand.storeName = store.storeName
		orderStatusCommand.storePhoneNumber = store.phoneNumber
		orderStatusCommand.storeAddressLine1 = store.addressLine1
		orderStatusCommand.storeAddressLine2 = store.addressLine2
		orderStatusCommand.storeCircle = store.circle
		orderStatusCommand.storeCity = store.city
		orderStatusCommand.storeState = store.state

		//		println "storename: "+orderStatusCommand.storeName
		orderStatusCommand.orderId = order.orderId
		orderStatusCommand.orderStatus = order.orderStatus
		orderStatusCommand.quantity = order.quantity
		orderStatusCommand.trackingId = order.uId
		orderStatusCommand.estimatedDeliveryTime = order.estimatedDeliveryTime
		return orderStatusCommand
	}
	//FIXME
	def populateOrderFromOrderDetailsCommand(OrderDetailsCommand orderDetailsCommand) {
		Orders order = new Orders()
		order.brandId = orderDetailsCommand.brandId
		order.inventoryId = orderDetailsCommand.inventoryId
		order.storeId = orderDetailsCommand.storeId
		order.quantity = orderDetailsCommand.quantity

		if(orderDetailsCommand.orderId)
			order.orderId = orderDetailsCommand.orderId

		if(orderDetailsCommand.orderStatus == 0)
			order.orderStatus = 1
		else
			order.orderStatus = orderDetailsCommand.orderStatus

		//		if(orderDetailsCommand.estimatedDeliveryTime)
		order.estimatedDeliveryTime = getEstimatedDeliveryTime(orderDetailsCommand.deliveryHours)
		//		else
		//			order.estimatedDeliveryTime = getEstimatedDeliveryTime()
		//		println "estimated Del time :" + orderDetailsCommand.estimatedDeliveryTime
		order.uId = orderDetailsCommand.trackingId
		order.isEmergencyDeliveryNeeded = orderDetailsCommand.isEmergencyDeliveryNeeded
		return order
	}

	def populateOrderDetailsFromStoreAndBrandData(Store store, BrandDatabase brand) {
		OrderDetailsCommand order = new OrderDetailsCommand()
		order.brandId = brand.brandId
		order.storeId = store.storeId
		order.brandName = brand.brandName
		//		order.deliveryHours = deliveryHours
		//		order.estimatedDeliveryTime = getEstimatedDeliveryTime(deliveryHours)
		//		println "ODC estimated time "+order.estimatedDeliveryTime
		//		order.storeName = store.storeName
		//		order.storePhoneNumber = store.phoneNumber
		//		order.storeAddressLine1 = store.addressLine1
		//		order.storeAddressLine2 = store.addressLine2
		//		order.storeCircle = store.circle
		//		order.storeCity = store.city
		//		order.storeState = store.state

		return order
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


	//FIXME: ETA
	def saveOrderFromOrderDetails(OrderDetailsCommand orderDetails) {
		if(!orderDetails.validate()) {
			println "VALIDATION ERROR: "+orderDetails.properties
			orderDetails.errors.each { println it }
			return 0
		}
		PatientProfile patient = patientProfileService.populatePatientProfileFromOrderDetailsCommand(orderDetails)
		def patientId = patientProfileService.savePatientProfile(patient)
		if(patientId!= 0) {
			//			orderDetails.estimatedDeliveryTime = Utility.getDateTimeInIST().addHours
			Orders order = populateOrderFromOrderDetailsCommand(orderDetails)
			order.personId = patientId
			order.uId = getUniqueRandomString()

			def orderId = saveOrder(order)
			if(orderId != 0) {
				return order.uId
			}
		}

		//if patient or order is not saved
		return 0

	}

	String getUniqueRandomString()
	{
		def uId = Utility.generateRandomString()

		if(!getOrderFromUId(uId))
			return uId

		else return getUniqueRandomString()
	}

	def saveOrder(Orders order, boolean sendMailFlag = true) {
		println "in save order"
		if(order.save(flush:true)) {
			println "saveorder success"
			boolean chkSendMail = (sendMailFlag && !(grailsApplication.config.env == Constants.env_LOCAL))
			if(chkSendMail) {
				OrderDetailsCommand orderDetailsCommand = populateOrderDetailsFromOrder(order)
				sendEmail(orderDetailsCommand)
			}

			return order.orderId
		}
		else {
			order.errors.each { println tag+" saveOrder "+it }
			return 0
		}
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

	def getOrderFromUId(def uId)
	{
		Orders order = Orders.findByUId(uId)
		return order
	}

	def changeOrderStatusAndSave(def orderId, String orderstatus, Date estDeliveryTime) {
		Orders order = getOrderFromOrderId(orderId)
		order.estimatedDeliveryTime = estDeliveryTime

		if(orderstatus=="2") order.orderStatus = Constants.ORDER_ACCEPTED
		else if(orderstatus=="3") order.orderStatus = Constants.ORDER_DISPATCHED
		else if(orderstatus=="4") order.orderStatus = Constants.ORDER_DELIVERED
		else if(orderstatus=="0") order.orderStatus = Constants.ORDER_REJECTED
		else order.orderStatus = Constants.ORDER_PLACED

		def status = saveOrder(order, false)

		return status
	}

	def acceptOrderAndSave(def orderId) {
		Orders order = getOrderFromOrderId(orderId)
		order.orderStatus = Constants.ORDER_ACCEPTED

		def status = saveOrder(order)

		return status
	}

	def rejectOrderAndSave(def orderId) {
		println "orderid: "+orderId
		Orders order = getOrderFromOrderId(orderId)
		order.orderStatus = Constants.ORDER_REJECTED

		def status = saveOrder(order)

		return status
	}

	def getListOfOrdersFromStoreId(String storeId) {
		//		println "getListOfOrdersFromStoreId: "+storeId
		List orderList = Orders.findAllByStoreId(storeId)
		return orderList
	}

	def getListOfOrdersFromStoreIdAndOrderStatus(String storeId, byte orderStatus) {
		println "getListOfOrdersFromStoreId: "+storeId +" OS: "+orderStatus
		List orderList = Orders.findAllByStoreIdAndOrderStatus(storeId,orderStatus)
		return orderList
	}
	
	def getListOfOrderDetailsFromOrdersList(List orderList) {
		List orderDetailsList = new ArrayList<OrderDetailsCommand>()
		orderList.each { order->
			orderDetailsList.add(populateOrderDetailsFromOrder(order))
		}
		return orderDetailsList
	}

	def sendEmail(OrderDetailsCommand orderDetails) {
		//		OrderDetailsCommand orderDetails = populateOrderDetailsFromOrder(order)
		String emailId = storeService.getEmailIdFromStoreId(orderDetails.storeId)
		Store store = storeService.getStoreDataFromStoreId(orderDetails.storeId)
		//		println "OrderDEtailsCommand: "+orderDetails.properties
		emailService.sendOrderMail(emailId, "Order@i2i", orderDetails)
		emailService.sendTrackingIdToCustomer("Pillocate: Tracking Details", orderDetails, store)
	}
}
