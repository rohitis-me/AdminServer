package i2i.AdminServer

import grails.converters.JSON
import i2i.AdminServer.ClientSync.InventoryService
import i2i.AdminServer.Util.Utility

import com.metasieve.shoppingcart.SessionUtils
import com.metasieve.shoppingcart.ShoppingCartService

class SearchController {

	SearchService searchService
	InventoryService inventoryService
	BrandDatabaseService brandDatabaseService
	StoreService storeService
	ShoppingCartService shoppingCartService

	def index() {
//		def session = SessionUtils.getSession()
//		println "circle: "+ session.circle
		//		if(params.circle){
		//			session.circle = params.circle
		//			session.city = params.city
		//		}
		//		if(!session.circle)
		//			redirect (controller:'search', action:'showLocationPage')
		println "New session: "+Utility.getDateTimeInIST().getTime().toString()
		
//		
//		response.setHeader('Source', 'IONIC')
		
//		request.headerNames.each{
//			println it
//		}
//		
//		def source = request.getHeader("Content-Type")
//		println "source"+ source
		
			
//		def http = new HTTPBuilder( 'http://localhost:8080/i2iAdminServer/search' )
//		http.request( POST, JSON ) { req ->
//			 body = [q:'groovy']
//			 headers.'User-Agent' = 'Mozilla/5.0 Ubuntu/8.10 Firefox/3.0.4'
//			 
//			 response.success = { resp, json ->
//			 // handle repsonse
//			 }
//		}
	}

	def getContentForLocationDialog = {
		def session = SessionUtils.getSession()
		//		def now = new SimpleDateFormat("yyyy-dd-MM hh:mm:ss").format(new Date())
		//		println "getting content... " + session.circle
		render(template:"dialogContent", model:[circle:session.circle])
	}

	def saveLocation(){
//		println "params: "+ params SessionUtils.setSession
		def session = SessionUtils.getSession()
		if(params.circle != session?.circle)
			shoppingCartService.emptyShoppingCart()
			
		if(params.circle){
			session.circle = params.circle
			session.city = params.city
		}
		redirect (controller:'search', action:'index')
	}

	def search() {
		println "SEARCH received params: "+params+ " Brand Name: "+params.brandName;

		String searchTerm = params.brandName
		String circle = session.circle
		String city = session.city
		//String brandId = brandDatabaseService.getBrandIdFromBrandName(searchTerm)
		String brandId = params.brandId

		//TODO: taking inventoryId into consideration for now
		String inventoryId = params.inventoryId

		boolean availabilityFlag= false

		//FIXME filter stores with circle also||get brandId against inventoryId and search for all stores where it is available
		if(inventoryId || brandId){
			//FIXME: not scalable. Else condition does not use circle
			List stores
			if(inventoryId)
				stores = searchService.getListOfStoresWhereBrandIsAvailableUsingInventoryIdAndCircle(inventoryId, circle)
			else if(brandId)
				stores = searchService.getListOfStoresWhereBrandIsAvailable(brandId)
			if(stores){
//				stores.each {store-> println "STORE:"+store.storeName }
				//FIXME: get delivery time from store
				availabilityFlag = true
				String storeId = stores.first().storeId
				def deliveryHours = stores.first()?.deliveryHoursIfAvailable
				//				redirect (controller:'testShoppingCart', action:'add', params:[id:1])
				render (view:"searchResult", model: [storeId:storeId, brandId:brandId, inventoryId:inventoryId, brandName: searchTerm, circle: circle, quantity: 1])
				//				redirect (controller:'patientProfile', action:'deliveryDetails', params:[storeId: storeId, brandId: brandId, inventoryId:inventoryId, circle: circle, deliveryHours:deliveryHours])
				//render (view:"searchList", model: [storesList:stores, availabilityFlag:availabilityFlag, brandId:brandId, inventoryId:inventoryId, brandName: searchTerm, circle: circle])
			}
			else{
				redirect (controller:'brandRequestInfo', action:'index', params: [brandName: searchTerm, circle: circle])
			}
		}
		else
		{
			List drugList = brandDatabaseService.getBrandDataList(searchTerm,circle, city)
			if(drugList){
				render (view:"searchSuggestions", model: [drugList:drugList, brandName: searchTerm, circle: circle])
			}
			else{
				redirect (controller:'brandRequestInfo', action:'index', params: [brandName: searchTerm, circle: circle])
			}
		}
		//		render "error"
	}



	//TODO change once data is got from branddatabase
	def listOfBrandNameStartingWith() {
//		println "AUTO COMPLETE: received params: "+params
		String searchTerm = params.term
		//		def session = SessionUtils.getSession()
		//		if(!session.circle)
		//			redirect (controller:'search', action:'showLocationPage')
		String circle = session.circle
		String city = session.city

		String suggestion

		List drugList = brandDatabaseService.getBrandDataList(searchTerm, circle, city)
		println "drugList: "+ drugList.size()
		List brandMapList = []
		drugList.each {
			//			println "druglist: "+it.brandId+"|"+it.inventoryId+"|"
			Map brandMap = brandDatabaseService.getBrandDataMap(it)
			suggestion = "${it.brandName}"//+" "+"${it.strength}"+" ${it.form}"
			//			brandMap << suggestion
			brandMapList.add(brandMap)
		}
		render brandMapList as JSON
	}

	def placeOrderNow(){
		redirect (controller:'shoppingCart', action:'addItemToCartAndPlaceOrder', params: params)
	}
}
