package i2i.AdminServer

import java.util.List;

import grails.transaction.Transactional

@Transactional
class StoreService {
	
	private final String debugStr = "StoreService "

    def serviceMethod() {

    }
	
	def getStoreDataFromStoreId(String storeId) {
		Store store = Store.findByStoreId(storeId)
		return store
	}
	
	def getStoreNameFromStoreId(String storeId) {
		String storeName = Store.findByStoreId(storeId)*.storeName
		return storeName
	}
	
	def getStoreListFromStoreIdList(List storeIds) {
		List storeList = new ArrayList<Store>();
		storeIds.each { storeId->
			Store store = Store.findByStoreId(storeId)
			
			if(store)
			storeList.add(store)
			else
			println debugStr+"getStoreListFromStoreIdList store not found: "+storeId
			
		}
		println "storeservice getStoreListFromStoreIdList: "+storeList.count
		return storeList
		//FIXME
//		List tmpList = new ArrayList<Store>()
//		tmpList.add(Store.first())
//		tmpList.add(Store.last())
//		return tmpList
	}
	
	def getLoggedInStoreId() {
		//FIXME: getstoreId from current logged in user
		Orders order = Orders.first()
		if (order)
		return order.storeId
		
		else
		return '0'
	}
	
}
