package i2i.AdminServer

import grails.converters.JSON

class SearchController {

	SearchService searchService
	BrandDatabaseService brandDatabaseService
	
    def index() { }
	
	def search() {
		println "received params: "+params+ " Brand Name: "+params.brandName;
 
		String searchTerm = params.brandName
		String brandId = brandDatabaseService.getBrandIdFromBrandName(searchTerm)
				
		List stores = searchService.getListOfStoresWhereBrandIsAvailable(brandId)
		
		stores.each {store->
			println store.storeName
		}
		
		if(stores)
		render (view:"searchList", model: [storesList:stores, brandId: brandId, brandName: searchTerm])
		else
		render "error"
	}
	
	def listOfBrandNameStartingWith() {
		println "received params: "+params
		
		String searchTerm = params.term
		
		List drugList = brandDatabaseService.getListOfBrandNamesStartingWith(searchTerm)
		
		def brandMap = []
		drugList.each {
			brandMap << "${it.brandName}"
		}
		render brandMap as JSON
	}
	
}
