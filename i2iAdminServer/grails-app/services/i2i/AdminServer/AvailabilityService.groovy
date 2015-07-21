package i2i.AdminServer

import grails.transaction.Transactional

@Transactional
class AvailabilityService {

	BrandDatabaseService brandDatabaseService
	def serviceMethod() {
	}

	def getStoreIdsFromBrandId(String brandId) {

		def storeIdList = Availability.findAllByBrandIdAndAvailabilityIndexGreaterThan(brandId, 0)*.storeId
//		println "availability service getStoreIdsFromBrandId: "+storeIdList.size()//+"\n* availability: "+availability.properties
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

	def getStoreIdsFromInventoryId(String inventoryId) {

		def storeIdList = Availability.findAllByInventoryIdAndAvailabilityIndexGreaterThan(inventoryId, 0)*.storeId
//		println "availability service getStoreIdsFromInventoryId: "+storeIdList.size()//+"\n* availability: "+availability.properties
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

	def getAvailabilityFromInventoryId(String inventoryId){
		Availability availability = Availability.findByInventoryId(inventoryId)
		return availability
	}

	def getAvailabilityListFromStoreId(String storeId, int max, int offset)
	{
		def availabilityList = Availability.findAllByStoreId(storeId,[max:max, offset:offset])
		//println "brandid count: "+brandIdList.size()
		return availabilityList
	}

	def getAvailabilityCountFromStoreId(String storeId)
	{
		def itemCount = Availability.countByStoreId(storeId)
		return itemCount
	}
	
	def populateInventoryAvailabilityListFromStoreId(String storeId, int max, int offset) {

		List availabilityList = getAvailabilityListFromStoreId(storeId, max, offset)

		List inventoryAvailabilityList = new ArrayList<InventoryAvailabilityCommand>()
		availabilityList.each {availability->
			InventoryAvailabilityCommand inventory = populateInventoryAvailabilityFromId(availability?.brandId, availability?.inventoryId)
			inventory.availabilityIndex = availability.availabilityIndex
			inventory.availabilityId = availability.availabilityId
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

	def populateInventoryAvailabilityFromId(String brandId, String inventoryId) {

		BrandDatabase brand = brandDatabaseService.getBrandDataFromId(brandId, inventoryId)

		InventoryAvailabilityCommand inventory = new InventoryAvailabilityCommand()
		if(brand==null) return inventory

		inventory.brandId = brandId
		inventory.brandName = brand.brandName
		//FIXME
		if(brand.strength)
		inventory.brandName = brand.brandName+' '+brand.strength
		if(brand.form)
		inventory.brandName = brand.brandName+' '+brand.form
		if(brand.generic) {
			String generic = brand.generic
//			if(generic.length()>15)
//			generic = generic.substring(0,15)+'..'
			inventory.brandName = inventory.brandName+' ('+generic+')'
		}

		return inventory
	}

	@Transactional
	def saveAvailability(Availability availability) {
		println "in save availability"
		if(availability.save(flush:true)) {
			println "saveavailability success"
			return availability.availabilityIndex
		}
		else {
			availability.errors.each { println tag+" saveAvailability "+it }
			return 0
		}
	}

	def changeAndSaveAvailabilityIndex(long availabilityId, Byte availabilityFlag)
	{
		Availability availability = Availability.get(availabilityId)
		availability.availabilityIndex = availabilityFlag
		println "av Index: "+availability.availabilityIndex

		def status = saveAvailability(availability)

		return status
	}

	def populateInventoryAvailabilityListFromDrugList(List drugList) {
		List inventoryAvailabilityList = new ArrayList<InventoryAvailabilityCommand>()
		drugList.each {drug->
			InventoryAvailabilityCommand inventory = populateInventoryAvailabilityFromId(drug?.brandId, drug?.inventoryId)
			Availability availability = getAvailabilityFromInventoryId(drug?.inventoryId)
			inventory.availabilityIndex = availability.availabilityIndex
			inventory.availabilityId = availability.availabilityId
			inventoryAvailabilityList.add(inventory)
		}

		return inventoryAvailabilityList
	}
}
