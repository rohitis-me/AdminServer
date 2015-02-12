package i2i.AdminServer

import grails.transaction.Transactional
import i2i.AdminServer.User.PatientProfile

@Transactional
class AvailabilityService {

	BrandDatabaseService brandDatabaseService
    def serviceMethod() {

    }
	
	def getStoreIdsFromBrandId(String brandId) {
		
		def storeIdList = Availability.findAllByBrandIdAndAvailabilityIndexGreaterThan(brandId, 0)*.storeId
		println "availability service getStoreIdsFromBrandId: "+storeIdList.size()//+"\n* availability: "+availability.properties
		for(int i=0;i<storeIdList.size();i++)
		{
			for(int j=i+1;j<storeIdList.size();j++)
			{
				if(storeIdList[i] ==storeIdList[j] )
				{
					storeIdList.remove(j);
					j--;
				}
			}
		}
		return storeIdList
	}
	
	def getAvailabilityListFromStoreId(String storeId)
	{
		def brandIdList = Availability.findAllByStoreId(storeId)
		println "brandid count: "+brandIdList.size()
		return brandIdList
	}
	
	def populateInventoryAvailabilityListFromStoreId(String storeId) {
		
		List availabilityList = getAvailabilityListFromStoreId(storeId)
		
		List inventoryAvailabilityList = new ArrayList<InventoryAvailabilityCommand>()
		availabilityList.each {availability->
			InventoryAvailabilityCommand inventory = populateInventoryAvailabilityFromBrandId(availability.brandId)
			inventory.availabilityIndex = inventory.availabilityIndex
			inventoryAvailabilityList.add(inventory)
		}
		
		return inventoryAvailabilityList
	}
	
	def populateInventoryAvailabilityFromBrandId(String brandId) {
		
		BrandDatabase brand = brandDatabaseService.getBrandDataFromBrandId(brandId)
		
		InventoryAvailabilityCommand inventory = new InventoryAvailabilityCommand()
		if(brand==null) return inventory
		
		inventory.brandId = brandId
		inventory.brandName = brand.brandName
		inventory.strength = brand.strength
		inventory.form = brand.form
		
		return inventory
	}
}
