package i2i.AdminServer



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import i2i.AdminServer.User.PatientProfile
import i2i.AdminServer.User.PatientProfileService

import com.metasieve.shoppingcart.Shoppable
import com.metasieve.shoppingcart.ShoppingCartService

//@Transactional(readOnly = true)
class OrderCollectionController {
	OrdersService ordersService
	OrderCollectionService orderCollectionService
	ShoppingCartService shoppingCartService
	PatientProfileService patientProfileService
	
	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def saveOrderItems(OrderCollectionCommand orderCollCommand) {
		println "ODC: "+orderCollCommand.properties
		println "params: "+params

		//FIXME: do this in gsp
		orderCollCommand.offerCode = ordersService.checkOfferCode(orderCollCommand.offerCode)

		if (orderCollCommand.hasErrors()) {
			render view: '/patientProfile/deliveryDetails', model: [orderDetails: orderCollCommand]
			//			redirect(controller: 'patientProfile', action: 'deliveryDetails', params:params)
			return
		}

		def orderRefId = orderCollectionService.saveOrderFromOrderCollection(orderCollCommand)
		println "orderRefId: "+orderRefId
		if(!orderRefId) {
			flash.message = message(code: 'save.error.label', default: 'Enter valid information')
			render view: '/patientProfile/deliveryDetails', model: [orderDetails: orderCollCommand]
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

		redirect(controller: 'orderCollection', action: 'showOrderCollectionDetails', params:[trackingId: orderRefId,offerCode:orderCollCommand.offerCode])
	}

	def showOrderCollectionDetails() {
		def trackingId = params.trackingId
		def offerCode = params.offerCode
		//		def orderStatus = ordersService.getOrderStatusFromOrderId(orderId)

		//Orders order = ordersService.getOrderFromOrderId(uId)
		OrderCollection orderCollection = orderCollectionService.getOrderFromRefId(trackingId)
		if(orderCollection) {
			List orderList = ordersService.getListOfOrdersFromOrderCollectionId(orderCollection.orderCollectionId)
			println "items count: "+orderList.size()
			List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(orderList)
			//			OrderStatusCommand orderStatusCommand = ordersService.populateOrderStatusFromOrder(order)
			//			orderStatusCommand.trackingId = uId
			//			orderStatusCommand.offerCode = offerCode
			//			println "OrderStatusCommand: "+orderStatusCommand.properties
			PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(orderCollection.personId)
			render(view: "orderCollectionDetails", model: [orderDetailsList:orderDetailsList, patient:patient, trackingId: trackingId, offerCode:offerCode])
		}
		else
		{
			render(view: "trackOrderCollectionDetails",model: [trackingId:trackingId])
		}
	}

	def placeNextOrder() {
		redirect (controller: 'search', action: 'index')
	}

	def cancelOrder() {
		println "orderId: "+params.orderId
		def orderId = params.orderId
		def status = ordersService.cancelOrderAndSave(orderId)
		
		if(status == 0)
			render "Error in proccessing your request. Please try again later!"
		else{
			redirect(controller: 'orderCollection', action: 'showOrderCollectionDetails', params:[trackingId: params.trackingId,offerCode:params.offerCode])
		}
	}

	def showTrackedOrderDetails(){
		String trackingId = params?.trackingId
		String trackId = trackingId?.toUpperCase()

		OrderCollection orderCollection = orderCollectionService.getOrderFromRefId(trackId)
		if(orderCollection) {
			List orderList = ordersService.getListOfOrdersFromOrderCollectionId(orderCollection.orderCollectionId)
			println "items count: "+orderList.size()
			List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(orderList)
			
			PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(orderCollection.personId)
			render(view: "trackOrderCollectionDetails", model: [orderDetailsList:orderDetailsList, patient:patient, trackingId: trackingId])
		}
		else
		{
			render(view: "trackOrderCollectionDetails",model: [trackingId:trackingId])
		}

		//		Orders order = ordersService.getOrderFromUId(uId)
		//		if(order && order.orderStatus != Constants.ORDER_REJECTED) {
		//			OrderStatusCommand orderStatusCommand = ordersService.populateOrderStatusFromOrder(order)
		//			orderStatusCommand.trackingId = uId
		//			println "OrderStatusCommand: "+orderStatusCommand.properties
		//			render(view: "trackOrderStatus", model: [orderStatusCommand: orderStatusCommand, trackingId:trackingId])
		//		}
		//		else
		//		{
		//			render(view: "trackOrderStatus",model: [trackingId:trackingId])
		//		}
	}

	def trackOrderCollectionDetails(){
		//		render(view: "trackOrderCollectionDetails")
	}

	def index(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		respond OrderCollection.list(params), model:[orderCollectionInstanceCount: OrderCollection.count()]
	}

	def show(OrderCollection orderCollectionInstance) {
		respond orderCollectionInstance
	}

	def create() {
		respond new OrderCollection(params)
	}

	@Transactional
	def save(OrderCollection orderCollectionInstance) {
		if (orderCollectionInstance == null) {
			notFound()
			return
		}

		if (orderCollectionInstance.hasErrors()) {
			respond orderCollectionInstance.errors, view:'create'
			return
		}

		orderCollectionInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [
					message(code: 'orderCollection.label', default: 'OrderCollection'),
					orderCollectionInstance.id
				])
				redirect orderCollectionInstance
			}
			'*' { respond orderCollectionInstance, [status: CREATED] }
		}
	}

	def edit(OrderCollection orderCollectionInstance) {
		respond orderCollectionInstance
	}

	@Transactional
	def update(OrderCollection orderCollectionInstance) {
		if (orderCollectionInstance == null) {
			notFound()
			return
		}

		if (orderCollectionInstance.hasErrors()) {
			respond orderCollectionInstance.errors, view:'edit'
			return
		}

		orderCollectionInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [
					message(code: 'OrderCollection.label', default: 'OrderCollection'),
					orderCollectionInstance.id
				])
				redirect orderCollectionInstance
			}
			'*'{ respond orderCollectionInstance, [status: OK] }
		}
	}

	@Transactional
	def delete(OrderCollection orderCollectionInstance) {

		if (orderCollectionInstance == null) {
			notFound()
			return
		}

		orderCollectionInstance.delete flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.deleted.message', args: [
					message(code: 'OrderCollection.label', default: 'OrderCollection'),
					orderCollectionInstance.id
				])
				redirect action:"index", method:"GET"
			}
			'*'{ render status: NO_CONTENT }
		}
	}

	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [
					message(code: 'orderCollection.label', default: 'OrderCollection'),
					params.id
				])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
}
