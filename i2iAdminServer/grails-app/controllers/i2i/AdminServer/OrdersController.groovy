package i2i.AdminServer

class OrdersController {

	OrdersService ordersService
	
    def index() { }
	
	def showOrderDetails() {
		
	}
	
	def showOrderStatus() {
		def orderId = params.orderId
		def orderStatus = ordersService.getOrderStatusFromOrderId(orderId)
		render(view: "orderStatus", model: [orderStatus: orderStatus])
	}
	
}
