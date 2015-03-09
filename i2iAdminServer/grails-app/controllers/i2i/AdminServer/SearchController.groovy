package i2i.AdminServer

import grails.converters.JSON
import i2i.AdminServer.ClientSync.InventoryService

class SearchController {

	SearchService searchService
	InventoryService inventoryService
	BrandDatabaseService brandDatabaseService

	def index() {
	}

	def search() {
		println "received params: "+params+ " Brand Name: "+params.brandName;

		String searchTerm = params.brandName
		String circle = params.circle
		//String brandId = brandDatabaseService.getBrandIdFromBrandName(searchTerm)
		String brandId = params.brandId
		
		//TODO: taking inventoryId into consideration for now
		String inventoryId = params.inventoryId
		
		//FIXME filter stores with circle also||get brandId against inventoryId and search for all stores where it is available
		if(inventoryId){
			List stores = searchService.getListOfStoresWhereBrandIsAvailableUsingInventoryId(inventoryId)

			stores.each {store-> println store.storeName }

			//FIXME: get delivery time from store
			String deliveryTime = '4 hours'
			render (view:"searchList", model: [storesList:stores, brandId:brandId, inventoryId:inventoryId, brandName: searchTerm, circle: circle, deliveryTime: deliveryTime])
		}
		else if(brandId) {
			//FIXME: add code here.
			List stores = searchService.getListOfStoresWhereBrandIsAvailable(brandId)
			
			stores.each {store-> println store.storeName }
			
			//FIXME: get delivery time from store
			String deliveryTime = '4 hours'
			render (view:"searchList", model: [storesList:stores, brandId: brandId, brandName: searchTerm, circle: circle, deliveryTime: deliveryTime])
		}
		else
		{
			List drugList = brandDatabaseService.getBrandDataList(searchTerm)

			render (view:"searchSuggestions", model: [drugList:drugList, brandName: searchTerm, circle: circle])
		}
		//		render "error"
	}

	//TODO change once data is got from branddatabase
	def listOfBrandNameStartingWith() {
		println "received params: "+params

		String searchTerm = params.term
		String suggestion

		List drugList = brandDatabaseService.getBrandDataList(searchTerm)
		
		List brandMapList = []
		drugList.each {
			Map brandMap = [:]
			suggestion = "${it.brandName}"//+" "+"${it.strength}"+" ${it.form}"
			//			brandMap << suggestion
			brandMap.put("id", "${it.inventoryId}")//brandId}")
			brandMap.put("name", "${it.brandName}")
			brandMap.put("label", suggestion)
			brandMapList.add(brandMap)
		}
		render brandMapList as JSON

	}

}
