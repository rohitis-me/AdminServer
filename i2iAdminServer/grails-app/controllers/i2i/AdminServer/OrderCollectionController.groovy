package i2i.AdminServer



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import i2i.AdminServer.User.FileAttachmentService
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
	StoreService storeService
	FileAttachmentService fileAttachmentService

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	@Secured(['ROLE_CHEMIST_ADMIN'])
	def showOrderDetailsList() {
		String storeId = storeService.getLoggedInStoreId()

		//FIXME: has to be logged in to come here
		if(storeId == '0')
			render "error. Not logged in "

		List orderCollIds = ordersService.getListOfOrderCollectionIdsFromStoreId(storeId)
//		orderCollIds.each { println "orderCollId: "+it }
//		println "orderCollIdCount "+ orderCollIds.size()

		List orderDetailsList = orderCollectionService.getOrderCollectionCommandListFromOrderCollectionIdList(orderCollIds)
		//		List ordersList = ordersService.getListOfOrdersFromStoreId(storeId)
		//		println "orderCount "+ ordersList.size()
		//
		//		List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(ordersList)
//		println "done orderdetailslist"
		//to show current tab colour
		byte orderStatus = -2

		render(view:"orderDetailsList", model: [orderDetailsList: orderDetailsList, orderStatus:orderStatus])
	}

	@Secured(['ROLE_CHEMIST_ADMIN'])
	def showSortedOrderDetailsList() {
		String storeId = storeService.getLoggedInStoreId()

		//FIXME: has to be logged in to come here
		if(storeId == '0')
			render "error. Not logged in "

		List orderCollIds = ordersService.getListOfOrderCollectionIdsFromStoreId(storeId)
//		orderCollIds.each { println "orderCollId: "+it }
//		println "orderCollIdCount "+ orderCollIds.size()
		byte orderStatus = params.orderStatus.toInteger()

		List orderDetailsList = orderCollectionService.getOrderCollectionCommandListFromOrderCollectionIdListAndOrderStatus(orderCollIds,orderStatus)
		//		List ordersList = ordersService.getOrderCollectionCommandListFromOrderCollectionIdListAndOrderStatus(storeId,orderStatus)
		//		println "orderCount "+ ordersList.size()
		//
		//		List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(ordersList)
//		println "done orderdetailslist"

		render(view:"orderDetailsList", model: [orderDetailsList: orderDetailsList, orderStatus:orderStatus])
	}

	@Secured(['ROLE_CHEMIST_ADMIN'])
	def showOrderDetails() {
		println "showOrderDetails params: "+params
		Long orderCollId = params.orderCollectionId?.toLong()

		String storeId = storeService.getLoggedInStoreId()

		//FIXME: has to be logged in to come here
		if(storeId == '0')
			render "error. Not logged in "

		OrderCollectionCommand orderCollCommand = orderCollectionService.getOrderCollectionCommandFromOrderCollectionId(orderCollId)
		List orderDetailsCommandList = ordersService.getListOfOrdersFromOrderCollectionIdAndStoreId(orderCollId,storeId)

		String attachmentLink = ""
		if(orderCollCommand?.attachmentId)
			attachmentLink = fileAttachmentService.getAttachmentLinkFromAttachmentId(orderCollCommand?.attachmentId)
		render(view:"showOrderDetails", model: [orderDetailsCommandList: orderDetailsCommandList, orderCollCommand:orderCollCommand, attachmentLink:attachmentLink, storeId:storeId])
	}

	@Secured(['ROLE_CHEMIST_ADMIN'])
	def saveOrderStatus() {
		println "showOrderDetails params: "+params
		Long orderCollId = params.orderCollectionId?.toLong()
		String storeId = params.storeId
		String comment = params.deliveryComment

		//		println "in save order status: "+orderDetailsCommand.properties
		//		def orderId = orderDetailsCommand.orderId
		def status = ordersService.changeOrderStatusAndSave(storeId, orderCollId, params.orderstatus, params.estimatedDeliveryTime, comment)

		if(status == 0)
			render "error"
		else
			redirect (controller: 'orderCollection', action: 'showOrderDetailsList')
	}

	def saveOrderItems(OrderCollectionCommand orderCollCommand) {
		println "ODC: "+orderCollCommand.properties
//		println "params: "+params

		//FIXME: do this in gsp
		orderCollCommand.offerCode = ordersService.checkOfferCode(orderCollCommand.offerCode)

		if (orderCollCommand.hasErrors()) {
			render view: '/patientProfile/deliveryDetails', model: [orderDetails: orderCollCommand]
			//			redirect(controller: 'patientProfile', action: 'deliveryDetails', params:params)
			return
		}
//		println "offer: "+orderCollCommand.offerCode
		def cartItems = shoppingCartService.getItems()//com.metasieve.shoppingcart.Shoppable.list()
		if(!cartItems || (cartItems && cartItems.size() < 1) ){
			flash.message = message(code: 'shoppingcart.noitem.label', default: 'No items in your shopping cart!')
			redirect (controller: 'shoppingCart', action: 'showCartItems')
			return
		}
		
		def orderRefId = orderCollectionService.saveOrderFromOrderCollection(orderCollCommand)
//		println "orderRefId: "+orderRefId
		if(!orderRefId) {
			flash.message = message(code: 'save.error.label', default: 'Enter valid information')
			render view: '/patientProfile/deliveryDetails', model: [orderDetails: orderCollCommand]
			return
			//			redirect(controller: 'patientProfile', action: 'showDeliveryDetails', params:params)
		}
		
		List orderDetailsList = []
		cartItems.each{item ->
//			println "id: "+ item.id
			def product = Shoppable.findByShoppingItem(item)
			def qty = shoppingCartService.getQuantity(item)
			OrderDetailsCommand orderDetails = ordersService.saveOrderFromBrandOrdered(product, qty, orderCollCommand.orderCollectionId)
			orderDetailsList.add(orderDetails)
		}

		orderCollectionService.sendNewOrderEmail(orderCollCommand, orderDetailsList)

		shoppingCartService.emptyShoppingCart()
//		def checkedOutItems = shoppingCartService.checkOut()
//		println "size: "+checkedOutItems.size()

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
//			println "items count: "+orderList.size()
			List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(orderList)
			//			OrderStatusCommand orderStatusCommand = ordersService.populateOrderStatusFromOrder(order)
			//			orderStatusCommand.trackingId = uId
			//			orderStatusCommand.offerCode = offerCode
			//			println "OrderStatusCommand: "+orderStatusCommand.properties
			PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(orderCollection.personId)
			render(view: "orderCollectionDetails", model: [orderDetailsList:orderDetailsList, patient:patient, trackingId: trackingId, offerCode:offerCode, deliveryComment:orderCollection.deliveryComment])
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
			redirect(controller: 'orderCollection', action: 'showOrderCollectionDetails', params:[trackingId: params.trackingId])
		}
	}
	
	def cancelOrderItems(){
		def trackingId = params.trackingId

		OrderCollection orderCollection = orderCollectionService.getOrderFromRefId(trackingId?.toUpperCase())
		if(orderCollection) {
			def status = ordersService.cancelOrderItemsAndSave(orderCollection.orderCollectionId)
			if(status == 0)
				render "Error in proccessing your request. Please try again later!"
			else{
				flash.message = "Your Order has been cancelled successfully!"
				redirect(controller: 'orderCollection', action: 'showOrderCollectionDetails', params:[trackingId: trackingId])
			}
		}
		else
			render "Error in proccessing your request. Please try again later!"
	}

	def showTrackedOrderDetails(){
		String trackingId = params?.trackingId
		String trackId = trackingId?.toUpperCase()

		OrderCollection orderCollection = orderCollectionService.getOrderFromRefId(trackId)
		if(orderCollection) {
			List orderList = ordersService.getListOfOrdersFromOrderCollectionId(orderCollection.orderCollectionId)
//			println "items count: "+orderList.size()
			List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(orderList)

			PatientProfile patient = patientProfileService.getPatientProfileDataFromPatientProfileId(orderCollection.personId)
			render(view: "trackOrderCollectionDetails", model: [orderDetailsList:orderDetailsList, patient:patient, trackingId: trackingId, deliveryComment:orderCollection.deliveryComment])
		}
		else
		{
			render(view: "trackOrderCollectionDetails",model: [trackingId:trackingId])
		}
	}

	def trackOrderCollectionDetails(){
		//		render(view: "trackOrderCollectionDetails")
	}

//	def index(Integer max) {
//		params.max = Math.min(max ?: 10, 100)
//		respond OrderCollection.list(params), model:[orderCollectionInstanceCount: OrderCollection.count()]
//	}
//
//	def show(OrderCollection orderCollectionInstance) {
//		respond orderCollectionInstance
//	}
//
//	def create() {
//		respond new OrderCollection(params)
//	}

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
