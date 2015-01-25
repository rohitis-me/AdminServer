package i2i.AdminServer

import grails.transaction.Transactional

@Transactional
class SearchService {

	def availabilityService
	def storeService
	
    def serviceMethod() {

    }
	
	def getListOfStoresWhereBrandIsAvailable(String brandId) {
		List storeIdList = availabilityService.getStoreIdsFromBrandId(brandId)
		List storeList = storeService.getStoreListFromStoreIdList(storeIdList)
		println "bid: "+brandId+" storelist: "+storeList.count
		return storeList
	}
	
	
}
