package i2i.AdminServer



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

//@Transactional(readOnly = true)
class OrdersController {

	OrdersService ordersService
	StoreService storeService
	
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Orders.list(params), model:[ordersInstanceCount: Orders.count()]
    }

    def show(Orders ordersInstance) {
        respond ordersInstance
    }
	
	@Secured(['ROLE_CHEMIST_ADMIN'])
	def showOrderDetailsList() {
		String storeId = storeService.getLoggedInStoreId()
		
		//FIXME: has to be logged in to come here
		if(storeId == '0')
			render "error. Not logged in "
		
			
			List ordersList = ordersService.getListOfOrdersFromStoreId(storeId)
		println "orderCount "+ ordersList.size()
		
		List orderDetailsList = ordersService.getListOfOrderDetailsFromOrdersList(ordersList)
		println "done orderdetailslist"
		
		render(view:"orderDetailsList", model: [orderDetailsList: orderDetailsList])
	}
	
	@Secured(['ROLE_CHEMIST_ADMIN'])
	def showOrderDetails(OrderDetailsCommand orderDetailsCommand) {
		println "showOrderDetails params: "+params
		def orderId = orderDetailsCommand.orderId
		Orders order = ordersService.getOrderFromOrderId(orderId)
		orderDetailsCommand = ordersService.populateOrderDetailsFromOrder(order)
		render(view:"showOrderDetails", model: [orderDetailsCommand: orderDetailsCommand])
	}
	
	def showOrderStatus() {
		def uId = params.uId
//		def orderStatus = ordersService.getOrderStatusFromOrderId(orderId)
		
		//Orders order = ordersService.getOrderFromOrderId(uId)
		Orders order = ordersService.getOrderFromUId(uId)
		OrderStatusCommand orderStatusCommand = ordersService.populateOrderStatusFromOrder(order)

		println "OrderStatusCommand: "+orderStatusCommand.properties
		render(view: "orderStatus", model: [orderStatusCommand: orderStatusCommand])
	}
	
	@Secured(['ROLE_CHEMIST_ADMIN'])
	def saveOrderStatus(OrderDetailsCommand orderDetailsCommand) {
		println "in save order status: "+params
		def orderId = orderDetailsCommand.orderId
		def status = ordersService.changeOrderStatusAndSave(orderId, params.orderstatus)
		
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

	def cancelOrder(OrderDetailsCommand orderDetailsCommand) {
		println "params: "+params
		def orderId = orderDetailsCommand.orderId
		def status = ordersService.rejectOrderAndSave(orderId)
		
		if(status == 0)
			render "error"
		
		else
			redirect (controller: 'search', action: 'index')
	}
	
	def placeNextOrder() {
			redirect (controller: 'search', action: 'index')
	}
	
    def create() {
        respond new Orders(params)
    }
	
	def saveOrder(OrderDetailsCommand orderDetailsCommand) {
		println "ODC: "+orderDetailsCommand.properties
		
		def uId = ordersService.saveOrderFromOrderDetails(orderDetailsCommand)
		
		println "orderId: "+uId
		println "inventoryId: "+orderDetailsCommand.inventoryId
		
		if(uId) {
//			ordersService.sendEmail(orderDetailsCommand)
			redirect(controller: 'orders', action: 'showOrderStatus', params:[uId: uId])
		}
		else {

			flash.message = message(code: 'save.error.label', default: 'Enter valid information')
			redirect(controller: 'patientProfile', action: 'deliveryDetails', params:params)
		}
	}

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
                flash.message = message(code: 'default.created.message', args: [message(code: 'orders.label', default: 'Orders'), ordersInstance.id])
                redirect ordersInstance
            }
            '*' { respond ordersInstance, [status: CREATED] }
        }
    }

    def edit(Orders ordersInstance) {
        respond ordersInstance
    }

    @Transactional
    def update(Orders ordersInstance) {
        if (ordersInstance == null) {
            notFound()
            return
        }

        if (ordersInstance.hasErrors()) {
            respond ordersInstance.errors, view:'edit'
            return
        }

        ordersInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Orders.label', default: 'Orders'), ordersInstance.id])
                redirect ordersInstance
            }
            '*'{ respond ordersInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Orders ordersInstance) {

        if (ordersInstance == null) {
            notFound()
            return
        }

        ordersInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Orders.label', default: 'Orders'), ordersInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
