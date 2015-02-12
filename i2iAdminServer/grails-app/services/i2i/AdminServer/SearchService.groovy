package i2i.AdminServer

import grails.transaction.Transactional

@Transactional
class SearchService {

	def availabilityService
	def storeService
	def grailsApplication
	
    def serviceMethod() {

    }
	
	def getListOfStoresWhereBrandIsAvailable(String brandId) {
		List storeIdList = availabilityService.getStoreIdsFromBrandId(brandId)
		List storeList = storeService.getStoreListFromStoreIdList(storeIdList)
		println "bid: "+brandId+" storelist: "+storeList.size()
		println "turnontestcode: "+grailsApplication.config.turnOnTestCode
		if(grailsApplication.config.turnOnTestCode) {
			if(storeList.size() == 0) {
				storeList.add(Store.first())
				storeList.add(Store.last())
			}
		}
		println "storeList: "+storeList.count
		return storeList
	}
	
	
}
