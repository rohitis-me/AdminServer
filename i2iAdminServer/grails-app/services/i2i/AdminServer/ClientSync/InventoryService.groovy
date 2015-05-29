package i2i.AdminServer.ClientSync

import i2i.AdminServer.BrandDatabase;
import grails.transaction.Transactional

@Transactional
class InventoryService {

	private static final tag='InventoryService'
	def serviceMethod() {

	}
	
	def getInventoryIdFromBrandName(String brandName) {
		println "in getInventoryIdFromBrandName"
		String brandId = Inventory.findByBrandName(brandName)*.brandId
		println "Bid: "+brandId+" bn: "+brandName
		
		return brandId
	}
	
	def getInventoryDataFromInventoryId(String inventoryId) {
		Inventory inventory = Inventory.findByInventoryId(inventoryId)
		println "getInventoryDataFromBrandId: "+inventory?.properties+" count: "+Inventory.count()
		return inventory
	}
	
	def getBrandNameFromInventoryId(String inventoryId) {
		Inventory inventory = Inventory.findByInventoryId(inventoryId) //if we call with *.brandName it is giving [brandname] ??
		String brandName = inventory.brandName
		println "brandname: "+brandName
		return brandName
	}
	
	def getBrandDataFromInventoryId(String inventoryId) {
		BrandDatabase brand = new BrandDatabase()
		brand.brandName = getBrandNameFromInventoryId(inventoryId)
		//println "getBrandDataFromInventoryId: "+brand?.properties+" count: "+BrandDatabase.count()
		return brand
	}
	
	def getListOfBrandNamesStartingWith(String brandName) {
		List inventoryList = Inventory.findAllByBrandNameIlike(brandName+"%") // ignore case
		List brandDataList = populateBrandDataListFromInventoryList(inventoryList)
		return brandDataList
	}
	
	def getListOfBrandNamesStartingWithAndStoreId(String brandName, String storeId) {
		List inventoryList = Inventory.findAllByStoreIdAndBrandNameIlike(storeId,brandName+"%") // ignore case
		if(inventoryList.size()<10) {
			inventoryList.addAll(Inventory.findAllByStoreIdAndBrandNameIlike(storeId,"% "+brandName+"%"))
		}
		List brandDataList = populateBrandDataListFromInventoryList(inventoryList)
		return brandDataList
	}
	
	def getListOfBrandNamesStartingWith(String brandName,int max, int offset) {
		List inventoryList = Inventory.findAllByBrandNameIlike(brandName+"%",[max:max, offset:offset]) // ignore case
		List brandDataList = populateBrandDataListFromInventoryList(inventoryList)
		return brandDataList
	}
	
	def getCountofBrandNamesStartingWith(String brandName) {
		def itemCount = Inventory.countByBrandNameIlike(brandName+"%") // ignore case
		return itemCount
	}
	
	
	def populateBrandDataListFromInventoryList(ArrayList<Inventory> inventoryList) {
		BrandDataCommand brandDataCommand = new BrandDataCommand()
		List brandDataList = new ArrayList<BrandDataCommand>()
		inventoryList.each {inventory->
			brandDataCommand = new BrandDataCommand()
			brandDataCommand.inventoryId = inventory.inventoryId
			brandDataCommand.brandName = inventory.brandName
			brandDataList.add(brandDataCommand)
		}
		return brandDataList
	}
	
//	def saveBrandToBrandToBeApprovedTable(BrandDatabase brand) {
//		BrandToBeApproved tmpBrand = populateBrandToBeApproved(brand)
//		
//		if(tmpBrand.save(flush:true)) {
//			return 1
//		}
//		else {
//			println "Error in brandservice saveBrandToBrandToBeApprovedTable: "
//			tmpBrand.errors.each {
//				println ""+it
//			}
//			return 0
//		}
		
//	}
	
//	def populateBrandToBeApproved(BrandDatabase brand) {
//		BrandToBeApproved tmpBrand = new BrandToBeApproved()
//		tmpBrand.brandId = generateIdForNewBrandToBeApprovedEntry()
//		tmpBrand.brandName = brand.brandName
//		tmpBrand.manufacturer = brand.manufacturer
//		tmpBrand.generic = brand.generic
//		tmpBrand.strength = brand.strength
//		tmpBrand.noOfUnits = brand.noOfUnits
//		tmpBrand.form = brand.form
//		tmpBrand.mrp = brand.mrp
//		return tmpBrand
//	}
	
	//FIXME
	/*this is for temperory brand*/
//	def generateIdForNewBrandToBeApprovedEntry() {
//		return (BrandToBeApproved.count()+1).toString()
//	}
	
}
