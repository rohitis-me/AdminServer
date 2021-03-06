package i2i.AdminServer

import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import i2i.AdminServer.User.FileAttachmentService

//@Transactional(readOnly = true)
class OrdersController {

	OrdersService ordersService
	StoreService storeService
	FileAttachmentService fileAttachmentService

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	//    def index(Integer max) {O
	//        params.max = Math.min(max ?: 10, 100)
	//        respond Orders.list(params), model:[ordersInstanceCount: Orders.count()]
	//    }
	//
	//    def show(Orders ordersInstance) {
	//        respond ordersInstance
	//    }

	@Secured(['ROLE_CHEMIST_ADMIN'])
	def showOrderDetailsList() {
		String storeId = storeService.getLoggedInStoreId()

		//FIXME: has to be logged in to come here
		if(storeId == '0')
			render "error. Not logged in "


		List ordersList = ordersService.getListOfOrdersFromStoreId(storeId)
//		println "orderCount "+ ordersList.size()

		List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(ordersList)
//		println "done orderdetailslist"
		//to show current tab colour
		byte orderStatus = -1

		render(view:"orderDetailsList", model: [orderDetailsList: orderDetailsList, orderStatus:orderStatus])
	}

	@Secured(['ROLE_CHEMIST_ADMIN'])
	def showSortedOrderDetailsList() {
		String storeId = storeService.getLoggedInStoreId()

		//FIXME: has to be logged in to come here
		if(storeId == '0')
			render "error. Not logged in "

		byte orderStatus = params.orderStatus.toInteger()
		List ordersList = ordersService.getListOfOrdersFromStoreIdAndOrderStatus(storeId,orderStatus)
//		println "orderCount "+ ordersList.size()

		List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(ordersList)
//		println "done orderdetailslist"

		render(view:"orderDetailsList", model: [orderDetailsList: orderDetailsList, orderStatus:orderStatus])
	}

	@Secured(['ROLE_CHEMIST_ADMIN'])
	def showOrderDetails(OrderDetailsCommand orderDetailsCommand) {
//		println "showOrderDetails params: "+params
		def orderId = orderDetailsCommand.orderId
		Orders order = ordersService.getOrderFromOrderId(orderId)
		orderDetailsCommand = ordersService.populateOrderDetailsFromOrder(order)
		String attachmentLink = ""
		if(orderDetailsCommand?.attachmentId)
			attachmentLink = fileAttachmentService.getAttachmentLinkFromAttachmentId(orderDetailsCommand?.attachmentId)
		render(view:"showOrderDetails", model: [orderDetailsCommand: orderDetailsCommand, attachmentLink:attachmentLink])
	}

	def showOrderStatus() {
		def uId = params.trackingId
		def offerCode = params.offerCode
		//		def orderStatus = ordersService.getOrderStatusFromOrderId(orderId)

		//Orders order = ordersService.getOrderFromOrderId(uId)
		Orders order = ordersService.getOrderFromUId(uId)
		if(order) {
			OrderStatusCommand orderStatusCommand = ordersService.populateOrderStatusFromOrder(order)
			orderStatusCommand.trackingId = uId
			orderStatusCommand.offerCode = offerCode 
//			println "OrderStatusCommand: "+orderStatusCommand.properties
			render(view: "orderStatus", model: [orderStatusCommand: orderStatusCommand])
		}
		else
		{
			render(view: "errors/pageNotFound")
		}
	}

	@Secured(['ROLE_CHEMIST_ADMIN'])
	def saveOrderStatus(OrderDetailsCommand orderDetailsCommand) {
		println "in save order status: "+orderDetailsCommand.properties
		def orderId = orderDetailsCommand.orderId
		def status = ordersService.changeOrderStatusAndSave(orderId, params.orderstatus,orderDetailsCommand?.estimatedDeliveryTime)

		if(status == 0)
			render "error"

		else
			redirect (controller: 'orders', action: 'showOrderDetailsList')
	}

	@Secured(['ROLE_CHEMIST_ADMIN'])
	def acceptOrder(OrderDetailsCommand orderDetailsCommand) {
		println "in accept order: "+params
		def orderId = orderDetailsCommand.orderId
		def status = ordersService.acceptOrderAndSave(orderId)

		if(status == 0)
			render "error"

		else
			redirect (controller: 'orders', action: 'showOrderDetailsList')
	}

	@Secured(['ROLE_CHEMIST_ADMIN'])
	def rejectOrder(OrderDetailsCommand orderDetailsCommand) {
		println "params: "+params
		def orderId = orderDetailsCommand.orderId
		def status = ordersService.rejectOrderAndSave(orderId)

		if(status == 0)
			render "error"

		else
			redirect (controller: 'orders', action: 'showOrderDetailsList')
	}

//	def cancelOrder(OrderDetailsCommand orderDetailsCommand) {
//		println "params: "+params
//		def orderId = orderDetailsCommand.orderId
//		def status = ordersService.cancelOrderAndSave(orderId)
//
//		if(status == 0)
//			render "Error in proccessing your request. Please try again later!"
//		else{
//			redirect (controller: 'search', action: 'index')
//		}
//	}
//
//	def placeNextOrder() {
//		redirect (controller: 'search', action: 'index')
//	}
//
//	def trackOrderStatus(){
//		//		render(view: "trackOrderStatus")
//	}

//	def showTrackedOrderDetails(){
//		String trackingId = params?.trackingId
//		String uId = trackingId?.toUpperCase()
//		println "uId: "+uId
//		
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
//	}

	//    def create() {
	//        respond new Orders(params)
	//    }

//	def saveOrder(OrderDetailsCommand orderDetailsCommand) {
//		println "ODC: "+orderDetailsCommand.properties
//		println "params: "+params
//		
//		//FIXME: do this in gsp
//		orderDetailsCommand.offerCode = ordersService.checkOfferCode(orderDetailsCommand.offerCode)
//		
////		if (orderDetailsCommand.hasErrors()) {
////			render view: '/patientProfile/deliveryDetails', model: [orderDetails: orderDetailsCommand]
//////			redirect(controller: 'patientProfile', action: 'deliveryDetails', params:params)
////			return
////		}
//		
//		def uId = ordersService.saveOrderFromOrderDetails(orderDetailsCommand)
//
//		println "orderId: "+uId
//
//		if(uId) {
//			//			ordersService.sendEmail(orderDetailsCommand)
//			redirect(controller: 'orders', action: 'showOrderStatus', params:[trackingId: uId,offerCode:orderDetailsCommand?.offerCode])
//		}
//		else {
//
//			flash.message = message(code: 'save.error.label', default: 'Enter valid information')
//			redirect(controller: 'patientProfile', action: 'deliveryDetails', params:params)
//		}
//	}

	@Transactional
	def save(Orders ordersInstance) {
		if (ordersInstance == null) {
			notFound()
			return
		}

		if (ordersInstance.hasErrors()) {
			respond ordersInstance.errors, view:'create'
			return
		}

		ordersInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [
					message(code: 'orders.label', default: 'Orders'),
					ordersInstance.id
				])
				redirect ordersInstance
			}
			'*' { respond ordersInstance, [status: CREATED] }
		}
	}

	//    def edit(Orders ordersInstance) {
	//        respond ordersInstance
	//    }

	//    @Transactional
	//    def update(Orders ordersInstance) {
	//        if (ordersInstance == null) {
	//            notFound()
	//            return
	//        }
	//
	//        if (ordersInstance.hasErrors()) {
	//            respond ordersInstance.errors, view:'edit'
	//            return
	//        }
	//
	//        ordersInstance.save flush:true
	//
	//        request.withFormat {
	//            form multipartForm {
	//                flash.message = message(code: 'default.updated.message', args: [message(code: 'Orders.label', default: 'Orders'), ordersInstance.id])
	//                redirect ordersInstance
	//            }
	//            '*'{ respond ordersInstance, [status: OK] }
	//        }
	//    }
	//
	//    @Transactional
	//    def delete(Orders ordersInstance) {
	//
	//        if (ordersInstance == null) {
	//            notFound()
	//            return
	//        }
	//
	//        ordersInstance.delete flush:true
	//
	//        request.withFormat {
	//            form multipartForm {
	//                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Orders.label', default: 'Orders'), ordersInstance.id])
	//                redirect action:"index", method:"GET"
	//            }
	//            '*'{ render status: NO_CONTENT }
	//        }
	//    }
	//
	//    protected void notFound() {
	//        request.withFormat {
	//            form multipartForm {
	//                flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), params.id])
	//                redirect action: "index", method: "GET"
	//            }
	//            '*'{ render status: NOT_FOUND }
	//        }
	//    }
}
