package i2i.AdminServer

import grails.transaction.Transactional
import i2i.AdminServer.User.PatientProfile
import i2i.AdminServer.User.PatientProfileService

@Transactional
class OrdersService {

	BrandDatabaseService brandDatabaseService
	StoreService storeService
	PatientProfileService patientProfileService
	
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
		orderDetailsCommand.state = patient.state
		return orderDetailsCommand
	}
	
	def populateOrderDetailsFromOrder(Orders order) {
		println "ORDER: "+order.properties
		PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(order.personId)
		println "PATIENT: "+patient.properties
		OrderDetailsCommand orderDetails = populateOrderDetailsFromPatientProfile(patient)
		println "ORDERDETAILS: "+order.properties
		orderDetails.brandId = order.brandId
		orderDetails.storeId = order.storeId
		orderDetails.brandName = brandDatabaseService.getBrandNameFromBrandId(order.brandId)
		orderDetails.storeName = storeService.getStoreNameFromStoreId(order.storeId)
		orderDetails.orderId = order.orderId
		return orderDetails
	}
	
	def populateOrderFromOrderDetailsCommand(OrderDetailsCommand orderDetailsCommand) {
		Orders order = new Orders()
		order.brandId = orderDetailsCommand.brandId
		order.storeId = orderDetailsCommand.storeId
		
		if(orderDetailsCommand.orderId)
		order.orderId = orderDetailsCommand.orderId
		
		if(orderDetailsCommand.orderStatus == 0)
		order.orderStatus = 1
		else
		order.orderStatus = orderDetailsCommand.orderStatus
		
		if(orderDetailsCommand.estimatedDeliveryTime)
		order.estimatedDeliveryTime = orderDetailsCommand.estimatedDeliveryTime
		else
		order.estimatedDeliveryTime = getEstimatedDeliveryTime()
		
		return order
	}
	
	def populateOrderDetailsFromStoreAndBrandData(Store store, BrandDatabase brand) {
		OrderDetailsCommand order = new OrderDetailsCommand()
		order.brandId = brand.brandId
		order.storeId = store.storeId
		order.brandName = brand.brandName
		order.storeName = store.storeName
		
		return order
	}
	
	//FIXME
	def getEstimatedDeliveryTime() {
		return new Date()
	}
	
	//FIXME: ETA
	def saveOrderFromOrderDetails(OrderDetailsCommand orderDetails) {
		PatientProfile patient = patientProfileService.populatePatientProfileFromOrderDetailsCommand(orderDetails)
		def patientId = patientProfileService.savePatientProfile(patient)
		Orders order = populateOrderFromOrderDetailsCommand(orderDetails)
		order.personId = patientId
		
		saveOrder(order)
		
	}
	
	def saveOrder(Orders order) {
		println "in save order"
		if(order.save(flush:true)) {
			println "saveorder success"
			return order.orderId
		}
		else {
			order.errors.each {
				println tag+" saveOrder "+it
			}
			return 0
		}
	}
	
	//FIXME
	def getOrderStatusFromOrderId(def orderId) {
		return 2
//		Orders order = Orders.findByOrderId(orderId)
//		return order.orderStatus
	}
	
	def getOrderFromOrderId(def orderId) {
		Orders order = Orders.get(orderId)
		return order
	}
	
	def acceptOrderAndSave(def orderId) {
		Orders order = getOrderFromOrderId(orderId)
		//FIXME: use enum
		order.orderStatus = Constants.ORDER_ACCEPTED
		
		def status = saveOrder(order)
		
		return status
	}
	
	def rejectOrderAndSave(def orderId) {
		println "orderid: "+orderId
		Orders order = getOrderFromOrderId(orderId)
		//FIXME: use constants
		order.orderStatus = Constants.ORDER_REJECTED
		
		def status = saveOrder(order)
		
		return status
	}
	
	def getListOfOrdersFromStoreId(String storeId) {
		List orderList = Orders.findAllByStoreId(storeId)
		return orderList
	}
	
	def getListOfOrderDetailsFromOrdersList(List orderList) {
		List orderDetailsList = new ArrayList<OrderDetailsCommand>()
		orderList.each { order->
			orderDetailsList.add(populateOrderDetailsFromOrder(order))
		}
		return orderDetailsList
	}
}
