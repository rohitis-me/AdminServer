package i2i.AdminServer

//import i2i.AdminServer.BrandDatabaseService
//import i2i.AdminServer.OrderDetailsCommand
//import i2i.AdminServer.OrdersService
//import i2i.AdminServer.StoreService
//import i2i.AdminServer.ClientSync.InventoryService
import com.metasieve.shoppingcart.SessionUtils
import com.metasieve.shoppingcart.Shoppable
import com.metasieve.shoppingcart.ShoppingCartService

class ShoppingCartController {

	ShoppingCartService shoppingCartService
	StoreService storeService

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	//	BrandDatabaseService brandDatabaseService
	//	StoreService storeService
	//	OrdersService ordersService
	//	InventoryService inventoryService

	//    def index = {
	//        redirect(action: "list", params: params)
	//    }
	def addItemToCart(){
		println "add item: "+ params
		String inventoryId = params.inventoryId
		String storeId = params.storeId
		BrandOrdered brandOrdered = BrandOrdered.findByInventoryIdAndStoreId(inventoryId,storeId)
		if(!brandOrdered) {
			brandOrdered = new BrandOrdered()

			brandOrdered.brandName = params.brandName
			brandOrdered.inventoryId = params.inventoryId
			brandOrdered.brandId = params.brandId
			brandOrdered.storeId = params.storeId //FIXME store id is not unique to inventoryId

			if(!brandOrdered.save(flush:true)) {
				brandOrdered.errors.each { println "error saving brandOrdered: "+it }
			}
			println "save brandOrdered success"
		}
		
		int quantity =  params.quantity.toInteger()

		shoppingCartService.addToShoppingCart(brandOrdered, quantity)
//		shoppingCartService.getShoppingCart().save()
		//render template:"/search/disableSubmit" //
		if(params.containsKey('placeOrderNow'))
			redirect (controller: 'shoppingCart', action: 'showCartItems')
		else
			render (view:"/search/searchResult", model: [storeId:params.storeId, brandId:params.brandId, inventoryId:params.inventoryId, brandName: params.brandName, circle: params?.circle, quantity: params.quantity, disableAdd:'1'])
	}

	def removeItemFromCart(){
		String inventoryId = params.inventoryId
		int qty = params.quantity.toInteger()
		println "iid: "+inventoryId
		BrandOrdered brandOrdered = BrandOrdered.findByInventoryId(inventoryId)
		if(brandOrdered && brandOrdered.shoppingItem){
//			def qty = shoppingCartService.getQuantity(brandOrdered.shoppingItem)
			println "qty: "+ qty
			shoppingCartService.removeFromShoppingCart(brandOrdered, qty)
		}
			
		redirect (controller: 'shoppingCart', action: 'showCartItems')
	}
	
	def showCartItems(){
		println "in show cart: session: "+SessionUtils.getSession().id
		def cartItems = shoppingCartService.getItems()//com.metasieve.shoppingcart.Shoppable.list()
		
		List cartItemMapList = []
		cartItems.each{item ->
			println "id: "+ item.id
			def product = Shoppable.findByShoppingItem(item)
			def name = product.toString()
			println "item Name: "+ name
			def iid = product.inventoryId
			def qty = shoppingCartService.getQuantity(item)
			Map nameQtyMap = [:]
			nameQtyMap.put("item", name)
			nameQtyMap.put("iId", iid)
			nameQtyMap.put("qty", qty)
			cartItemMapList.add(nameQtyMap)
		}
		

		render(view:'showCartItemList', model:['cartItemMapList':cartItemMapList])
	}

	def addItemToCartAndPlaceOrder(){
		println "add item: "+ params
		String inventoryId = params.inventoryId
		BrandOrdered brandOrdered = BrandOrdered.findByInventoryIdAndStoreId(inventoryId,params.storeId)
		if(!brandOrdered) {
			brandOrdered = new BrandOrdered()

			brandOrdered.brandName = params.brandName
			brandOrdered.inventoryId = params.inventoryId
			brandOrdered.brandId = params.brandId
			brandOrdered.storeId = params.storeId

			if(!brandOrdered.save(flush:true)) {
				brandOrdered.errors.each { println "error saving brandOrdered: "+it }
			}
			println "save brandOrdered success"
		}
		
		int quantity =  params.quantity.toInteger()

		shoppingCartService.addToShoppingCart(brandOrdered, quantity)
		
		redirect (controller: 'shoppingCart', action: 'placeOrder')
//		shoppingCartService.getShoppingCart().save()
		//		println "SHOPPING CART: "
//		render template:"/search/disableSubmit" //render (view:"/search/searchResult", model: [storeId:params.storeId, brandId:params.brandId, inventoryId:params.inventoryId, brandName: params.brandName, circle: params?.circle, quantity: params.quantity])
	}
	
	def placeOrder(){
		println "params: " + params
		
//		String circle = Constants.circleArray[0] //FIXME
//		def cartItems = shoppingCartService.getItems()//com.metasieve.shoppingcart.Shoppable.list()
//
//		cartItems.each{item ->
//			def product = Shoppable.findByShoppingItem(item)
//			def store = storeService.getStoreDataFromStoreId(product.storeId)
//			if(store){
//				 circle = store.circle
//			}
//		}
		
		if(params.prescriptionUploadOption == '0')
			redirect (controller: 'patientProfile', action: 'showDeliveryDetails')
		else
			redirect (controller: 'fileAttachment', action: 'index')
	}
	
	def goToHomePage(){
		println "in go to home"
		redirect (controller: 'search', action: 'index')
	}
	
	def changeCartItemQuantity(){
		println "change quantity: "+ params
		redirect (controller: 'shoppingCart', action: 'showCartItems')
	}

}
