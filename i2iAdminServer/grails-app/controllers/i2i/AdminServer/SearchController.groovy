package i2i.AdminServer

import grails.converters.JSON

class SearchController {

	SearchService searchService
	BrandDatabaseService brandDatabaseService

	def index() {
	}

	def search() {
		println "received params: "+params+ " Brand Name: "+params.brandName;

		String searchTerm = params.brandName
		String circle = params.circle
		//String brandId = brandDatabaseService.getBrandIdFromBrandName(searchTerm)
		String brandId = params.brandId
		//FIXME filter stores with circle also
		if(brandId){
			List stores = searchService.getListOfStoresWhereBrandIsAvailable(brandId)

			stores.each {store-> println store.storeName }

			String deliveryTime = '4 hours'
			//		if(stores)
			render (view:"searchList", model: [storesList:stores, brandId: brandId, brandName: searchTerm, circle: circle, deliveryTime: deliveryTime])
		}
		else
		{
			List drugList = brandDatabaseService.getListOfBrandNamesStartingWith(searchTerm)

			render (view:"searchSuggestions", model: [drugList:drugList, brandName: searchTerm, circle: circle])
		}
		//		render "error"
	}

	def listOfBrandNameStartingWith() {
		println "received params: "+params

		String searchTerm = params.term
		String suggestion

		List drugList = brandDatabaseService.getListOfBrandNamesStartingWith(searchTerm)

		List brandMapList = []
		drugList.each {
			Map brandMap = [:]
			suggestion = "${it.brandName}"+" "+"${it.strength}"+" ${it.form}"
			//			brandMap << suggestion
			brandMap.put("id", "${it.brandId}")
			brandMap.put("name", "${it.brandName}")
			brandMap.put("label", suggestion)
			brandMapList.add(brandMap)
		}
		render brandMapList as JSON

	}

}
