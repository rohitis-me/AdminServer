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
			if(brandId== null || brandId == "") {
				return storeList
			}
			if(storeList.size() == 0) {
				storeList.add(Store.first())
				storeList.add(Store.last())
			}
		}
		println "storeList: "+storeList.count
		return storeList
	}
	
	def getListOfStoresInCircle(String circle) {
		println "getListOfStoresInCircle: "+circle
		List storeList = storeService.getStoresFromCircle(circle)
		println "getListOfStoresInCircle: "+storeList
		return storeList
	}
	
	def getListOfStoresWhereBrandIsAvailableUsingInventoryIdAndCircle(String inventoryId, String circle) {
		List storeIdList = availabilityService.getStoreIdsFromInventoryId(inventoryId)
		List storeList = storeService.getStoreListFromStoreIdListAndCircle(storeIdList, circle)
		println "iId: "+inventoryId+" storelist: "+storeList.size()
		println "turnontestcode: "+grailsApplication.config.turnOnTestCode
		if(grailsApplication.config.turnOnTestCode) {
			if(inventoryId== null || inventoryId == "") {
				return storeList
			}
			if(storeList.size() == 0) {
				storeList.add(Store.first())
				storeList.add(Store.last())
			}
		}
		println "storeList: "+storeList.count
		return storeList
	}
	
	
}
