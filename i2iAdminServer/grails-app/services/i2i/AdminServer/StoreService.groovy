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
		Store store = Store.findByStoreId(storeId)
		if(store){
		String storeName = store.storeName
		return storeName
		}
		else
		println debugStr+"getStoreNameFromStoreId store not found: "+storeId
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
//		List tmpList = new ArrayList<Store>()
//		tmpList.add(Store.first())
//		tmpList.add(Store.last())
//		return tmpList
	}
	
	def populateStoreFromStoreCommand(StoreCommand storeCommand) {
		println "storeId: "+storeCommand.storeId
		
		Store store = Store.findByStoreId(storeCommand.storeId)
		store.storeName = storeCommand.storeName
		store.phoneNumber = storeCommand.phoneNumber
		store.addressLine1 = storeCommand.addressLine1
		store.addressLine2 = storeCommand.addressLine2
		store.circle = storeCommand.circle
		store.city = storeCommand.city
		store.state = storeCommand.state
		store.latitude = storeCommand.latitude
		store.longitude = storeCommand.longitude
		println "delivery time: "+storeCommand.deliveryHoursIfAvailable
		store.deliveryHoursIfAvailable = storeCommand.deliveryHoursIfAvailable
		store.deliveryHoursIfUnavailable = storeCommand.deliveryHoursIfUnavailable
		store.isEmergencyDeliveryAvailable = storeCommand.isEmergencyDeliveryAvailable
		return store
	}
	
	def getLoggedInStoreId() {
		//FIXME: getstoreId from current logged in user
		Orders order = Orders.first()
		println "loggedstoreId: "+order.storeId
		
		if (order)
		return order.storeId
		
		else
		return '0'
	}
	
}
