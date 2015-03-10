package i2i.AdminServer

import grails.transaction.Transactional
import i2i.AdminServer.ClientSync.BrandDataCommand
import i2i.AdminServer.ClientSync.InventoryService

@Transactional
class BrandDatabaseService {

	private static final tag='BrandDatabaseService'
	
	InventoryService inventoryService
	
    def serviceMethod() {

    }
	
	def getBrandIdFromBrandName(String brandName) {
		println "in getBrandIdFromBrandName"
		String brandId = BrandDatabase.findByBrandName(brandName)*.brandId
		println "Bid: "+brandId+" bn: "+brandName
		
		//FIXME
		//brandId = Availability.first().brandId
		return brandId
	}
	
	def getBrandDataFromBrandId(String brandId) {
		BrandDatabase brand = BrandDatabase.findByBrandId(brandId)
		println "getBrandDataFromBrandId: "+brand?.properties+" count: "+BrandDatabase.count()
		return brand
	}
	
	def getBrandNameFromBrandId(String brandId) {
		BrandDatabase brand = BrandDatabase.findByBrandId(brandId) //if we call with *.brandName it is giving [brandname] ??
		String brandName = brand.brandName
		println "brandname: "+brandName
		return brandName
	}
	
	
	def getListOfBrandNamesStartingWith(String brandName) {
		List brandDataList = BrandDatabase.findAllByBrandNameIlike(brandName+"%") // ignore case
		List brandDataCommandList = populateBrandDataCommandListFromBrandDataList(brandDataList)
		//findAllWhere(brandName: brandName+"%")//WhereBrandNameLike(brandName+'%')*.brandName
//		List brandNameList = new ArrayList<BrandDatabase>()
//		brandNameList.add(BrandDatabase.first())
//		brandNameList..add(BrandDatabase.last())
		return brandDataCommandList
	}
	
	def populateBrandDataCommandListFromBrandDataList(ArrayList<BrandDatabase> brandDataList) {
		ArrayList<BrandDataCommand> brandDataCommandList = new ArrayList<BrandDataCommand>()
		BrandDataCommand brandDataCommand = new BrandDataCommand()
		brandDataList.each{brandData->
			brandDataCommand = new BrandDataCommand()
			brandDataCommand.brandName = brandData.brandName+' '+brandData.strength+' '+brandData.form
			brandDataCommand.brandId = brandData.brandId
//			brandDataCommand.form = brandData.form
//			brandDataCommand.strength = brandData.strength
			brandDataCommandList.add(brandDataCommand)
		}
		return brandDataCommandList
	}
	
	def saveBrandToBrandToBeApprovedTable(BrandDatabase brand) {
		BrandToBeApproved tmpBrand = populateBrandToBeApproved(brand)
		
		if(tmpBrand.save(flush:true)) {
			return 1
		}
		else {
			println "Error in brandservice saveBrandToBrandToBeApprovedTable: "
			tmpBrand.errors.each {
				println ""+it
			}
			return 0
		}
		
	}
	
	def populateBrandToBeApproved(BrandDatabase brand) {
		BrandToBeApproved tmpBrand = new BrandToBeApproved()
		tmpBrand.brandId = generateIdForNewBrandToBeApprovedEntry()
		tmpBrand.brandName = brand.brandName
		tmpBrand.manufacturer = brand.manufacturer
		tmpBrand.generic = brand.generic
		tmpBrand.strength = brand.strength
		tmpBrand.noOfUnits = brand.noOfUnits
		tmpBrand.form = brand.form
		tmpBrand.mrp = brand.mrp
		return tmpBrand
	}
	
	//FIXME 
	/*this is for temperory brand*/
	def generateIdForNewBrandToBeApprovedEntry() {
		return (BrandToBeApproved.count()+1).toString()
	}
	
	//Changes to be made when brand data fetched from brand database
	def getBrandDataList(String searchTerm) {
		List drugList = inventoryService.getListOfBrandNamesStartingWith(searchTerm)

		if(drugList.size() == 0) {
			drugList = getListOfBrandNamesStartingWith(searchTerm)
		}
		return drugList
	}
	
	def getBrandNameFromId(String brandId, String inventoryId) {
		String brandName=""
		if(brandId) {
			brandName = getBrandNameFromBrandId(brandId)
		}
		else if(inventoryId) {
			brandName = inventoryService.getBrandNameFromInventoryId(inventoryId)
		}
		return brandName
	}
	
	def getBrandDataFromId(String brandId, String inventoryId) {
		BrandDatabase brand = null
		if(brandId){
			brand = BrandDatabase.findByBrandId(brandId)
		}
		else if(inventoryId){
			brand = inventoryService.getBrandDataFromInventoryId(inventoryId)
		}
		println "getBrandDataFromBrandId: "+brand?.properties+" count: "+BrandDatabase.count()
		return brand
	}
}
