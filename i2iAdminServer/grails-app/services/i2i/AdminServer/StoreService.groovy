package i2i.AdminServer

import java.util.List;

import grails.transaction.Transactional

@Transactional
class StoreService {

    def serviceMethod() {

    }
	
	def getStoreDataFromStoreId(String storeId) {
		Store store = Store.findByStoreId(storeId)
		return store
	}
	
	def getStoreListFromStoreIdList(List storeIds) {
		List storeList = new ArrayList<Store>();
		storeIds.each { storeId->
			Store store = Store.findByStoreId(storeId)
			
			if(store)
			storeList.add(store)
			else
			println "store not found: "+storeId
			
		}
		//return storeList
		//FIXME
		List tmpList = new ArrayList<Store>()
		tmpList.add(Store.first())
		tmpList.add(Store.last())
		return tmpList
	}
	
}
