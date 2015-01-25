package i2i.AdminServer

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
		render (view:"searchList", model: [storesList:stores, brandId: brandId])
		else
		render "error"
	}
	
	def listOfBrandNameStartingWith() {
		println "received params: "+params
		
		String searchTerm = params.brandName
		
		List drugList = brandDatabaseService.getListOfBrandNamesStartingWith(brandName)
		
	}
	
}
