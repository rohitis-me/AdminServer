package i2i.AdminServer

import grails.transaction.Transactional
import i2i.AdminServer.nonpartner.NonPartnerOrder
import i2i.AdminServer.nonpartner.NonPartnerOrderService

@Transactional
class SearchService {

	def availabilityService
	def storeService
	def grailsApplication
	NonPartnerOrderService nonPartnerOrderService

	def serviceMethod() {
	}
	
	def searchNonPartnerStoresForBrandIds(List brandIdList, List storeIdList = []) {
		NonPartnerOrder nonPartnerOrder = new NonPartnerOrder()
		//populate non partner order rows
		if(storeIdList.empty) {
			def storeList = Store.list()
			storeList.each {store->
				storeIdList.add(store.storeId)
			}
		}
		nonPartnerOrderService.insertNonPartnerOrders(brandIdList, storeIdList)
		//notify non partners of the order
	}

	
	
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
