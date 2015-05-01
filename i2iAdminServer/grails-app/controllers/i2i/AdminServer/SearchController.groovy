package i2i.AdminServer

import grails.converters.JSON
import i2i.AdminServer.ClientSync.InventoryService
import i2i.AdminServer.Util.Utility

class SearchController {

	SearchService searchService
	InventoryService inventoryService
	BrandDatabaseService brandDatabaseService
	StoreService storeService

	def index() {
		println "New session "+Utility.getDateTimeInIST().getTime().toString()
	}

	def search() {
		println "SEARCH received params: "+params+ " Brand Name: "+params.brandName;

		String searchTerm = params.brandName
		String circle = params.circle
		//String brandId = brandDatabaseService.getBrandIdFromBrandName(searchTerm)
		String brandId = params.brandId
		
		//TODO: taking inventoryId into consideration for now
		String inventoryId = params.inventoryId
		
		boolean availabilityFlag= false
		
		//FIXME filter stores with circle also||get brandId against inventoryId and search for all stores where it is available
		if(inventoryId){
			println "inventoryId available: "+inventoryId
			List stores = searchService.getListOfStoresWhereBrandIsAvailableUsingInventoryIdAndCircle(inventoryId, circle)

			if(stores)
			{
			stores.each {store-> println "STORE:"+store.storeName }

			//FIXME: get delivery time from store
			availabilityFlag= true
			render (view:"searchList", model: [storesList:stores, availabilityFlag:availabilityFlag, brandId:brandId, inventoryId:inventoryId, brandName: searchTerm, circle: circle])
			}
			else
			{
				stores = searchService.getListOfStoresInCircle(circle)
				
				stores.each {store-> println store.storeName }
				
				//FIXME: get delivery time from store
				availabilityFlag = false
				render (view:"searchList", model: [storesList:stores, availabilityFlag:availabilityFlag, brandId:brandId, inventoryId:inventoryId, brandName: searchTerm, circle: circle])
			}
		}
		else if(brandId) {
//			List stores = searchService.getListOfStoresWhereBrandIsAvailable(brandId)
			
			List stores = new ArrayList<Store>()
			
			//FIXME: not scalable. Else condition does not use circle
			
			stores = searchService.getListOfStoresWhereBrandIsAvailable(brandId)
			if(stores.size() >0)
			availabilityFlag= true
			else {
				availabilityFlag = false
				stores = searchService.getListOfStoresInCircle(circle)
			}
//			if(circle == 'Thiruvanmiyur') {
//				stores = searchService.getListOfStoresInCircle(circle)
//				availabilityFlag = false
//			}
//			else {
//				stores = searchService.getListOfStoresWhereBrandIsAvailableInCircle(brandId, circle)
//				availabilityFlag = true
//			}
//			
//			//FIXME: not scalable
//			if(!availabilityFlag) {
//				stores = searchService.getListOfStoresWhereBrandIsAvailable(brandId)
//				
//				if(stores.size() >0)
//				availabilityFlag= true
//			}
			
			
			stores.each {store-> println store.storeName }
			
			
			
			render (view:"searchList", model: [storesList:stores, availabilityFlag:availabilityFlag, brandId: brandId, brandName: searchTerm, circle: circle])
		}
		else
		{
			List drugList = brandDatabaseService.getBrandDataList(searchTerm,circle)

			render (view:"searchSuggestions", model: [drugList:drugList, brandName: searchTerm, circle: circle])
		}
		//		render "error"
	}

	//TODO change once data is got from branddatabase
	def listOfBrandNameStartingWith() {
		println "AUTO COMPLETE: received params: "+params

		String searchTerm = params.term
		String circle = params.circle
		
		String suggestion

		List drugList = brandDatabaseService.getBrandDataList(searchTerm, circle)
		
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

}
