package i2i.AdminServer

import grails.transaction.Transactional

@Transactional
class SearchService {

	def availabilityService
	def storeService
	def grailsApplication

	def serviceMethod() {
	}

//	def getListOfStoresWhereBrandIsAvailableInCircle(String brandId, String circle) {
////		List storeIdList = availabilityService.getStoreIdsFromBrandId(brandId)
//		
//		List storeList = new ArrayList<Store>()
//		
//		if(circle!= 'Thiruvanmiyur')
//		storeList = Store.findAllByCircle(circle)
//		
//		println "bid: "+brandId+" storelist: "+storeList.size()
//		println "storeList: "+storeList.count
//		return storeList
//	}
	
	def getListOfStoresWhereBrandIsAvailable(List brandIdList) {
		List storeIdList = new ArrayList<String>()
		List tempList = new ArrayList<String>()
		boolean isFirstEntry = true
		brandIdList.each { brandId->
			tempList = getListOfStoreIdsWhereBrandIsAvailable(brandId)
			if(isFirstEntry) {
				storeIdList = tempList
			}
			else
			storeIdList = tempList.intersect(storeIdList)   //get list of storeIDs where current and previous brandIds are available
			
			isFirstEntry = false
		}
		List storeList = storeService.getStoreListFromStoreIdList(storeIdList)
		return storeList
	}
	
	def getListOfStoresWhereBrandIsAvailable(String brandId) {
		List storeIdList = availabilityService.getStoreIdsFromBrandId(brandId)
		List storeList = storeService.getStoreListFromStoreIdList(storeIdList)
		return storeList
	}
	
	def getListOfStoreIdsWhereBrandIsAvailable(String brandId) {
		List storeIdList = availabilityService.getStoreIdsFromBrandId(brandId)
		return storeIdList
	}

	def getListOfStoresInCircle(String circle) {
//		println "getListOfStoresInCircle: "+circle

		List circleList = new ArrayList<String>()
		circleList.add(circle)
		//FIXME: temp fix
//		if(circle == 'Thiruvanmiyur')
//		circleList.add('Kottivakkam')
		
		if(circle == 'Kandanchavadi' || circle == 'Adyar' || circle == 'Besant Nagar')
			circleList.add('Kottivakkam')

		List storeList = storeService.getStoresFromCircleList(circleList)
//		println "getListOfStoresInCircle: "+storeList
		return storeList
	}

	def getListOfStoresWhereBrandIsAvailableUsingInventoryIdAndCircle(String inventoryId, String circle) {
		List storeIdList = availabilityService.getStoreIdsFromInventoryId(inventoryId)
		List storeList = storeService.getStoreListFromStoreIdListAndCircle(storeIdList, circle)
		//FIXME temp fix
		if(storeList.size() == 0) {
			storeList = storeService.getStoreListFromStoreIdList(storeIdList)
		}
//		println "iId: "+inventoryId+" storelist: "+storeList.size()
		//		println "turnontestcode: "+grailsApplication.config.turnOnTestCode
		//		if(grailsApplication.config.turnOnTestCode) {
		//			if(inventoryId== null || inventoryId == "") {
		//				return storeList
		//			}
		//			if(storeList.size() == 0) {
		//				storeList.add(Store.first())
		//				storeList.add(Store.last())
		//			}
		//		}
//		println "storeList: "+storeList.count
		return storeList
	}
}
