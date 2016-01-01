package i2i.AdminServer

import grails.transaction.Transactional
import i2i.AdminServer.ClientSync.BrandDataCommand
import i2i.AdminServer.ClientSync.InventoryService

@Transactional
class BrandDatabaseService {

	private static final tag='BrandDatabaseService'

	InventoryService inventoryService
	AvailabilityService availabilityService

	def serviceMethod() {
	}

	def getBrandIdFromBrandName(String brandName) {
		println "in getBrandIdFromBrandName"
		String brandId = BrandDatabase.findByBrandName(brandName)*.brandId
//		println "Bid: "+brandId+" bn: "+brandName

		//FIXME
		//brandId = Availability.first().brandId
		return brandId
	}

	def getBrandDataFromBrandId(String brandId) {
		BrandDatabase brand = BrandDatabase.findByBrandId(brandId)
//		println "getBrandDataFromBrandId: "+brand?.properties+" count: "+BrandDatabase.count()
		return brand
	}

	def getBrandNameFromBrandId(String brandId) {
		BrandDatabase brand = BrandDatabase.findByBrandId(brandId) //if we call with *.brandName it is giving [brandname] ??
		String brandName = brand?.brandName
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
			brandDataCommand.form = brandData.form
			brandDataCommand.noOfUnits = brandData.noOfUnits
			brandDataCommandList.add(brandDataCommand)
		}
		return brandDataCommandList
	}
	//TODO: Why this?
	def getListOfBrandNamesStartingWithAndStoreId(String brandName, String storeId) {
		List brandDataList = BrandDatabase.findAllByBrandNameIlike(brandName+"%",[max:10, offset:0]) // ignore case
		if(brandDataList.size()<5) {
			brandDataList.addAll(BrandDatabase.findAllByBrandNameIlike("% "+brandName+"%",[max:10, offset:0]))
		}
		ArrayList<BrandDataCommand> brandDataCommandList = new ArrayList<BrandDataCommand>()
		brandDataList.each{brandData->
			Byte availabilityIndex = availabilityService.getAvailabilityIndexFromBrandIdAndStoreId(brandData.brandId, storeId)
			println "availabilityIndex: "+availabilityIndex
			if(availabilityIndex>0){
				BrandDataCommand brandDataCommand = new BrandDataCommand()
				brandDataCommand.brandName = brandData.brandName //+' '+brandData.strength+' '+brandData.form
				brandDataCommand.brandId = brandData.brandId
				brandDataCommand.form = brandData.form
				brandDataCommand.noOfUnits = brandData.noOfUnits
				brandDataCommandList.add(brandDataCommand)
			}
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
			tmpBrand.errors.each { println ""+it }
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

	//TODO: Changes to be made when brand data fetched from brand database
	def getBrandDataList(String searchTerm, String circle, String city) {
		List drugList = new ArrayList<BrandDataCommand>()
		println "city: " + city + "circle: " + circle
		//FIXME: NOT scalable
//		String storeId = 0
//		if(city == 'Chennai') {
//		if(circle == 'Thiruvanmiyur') 
//			storeId = 1 //drugList = inventoryService.getListOfBrandNamesStartingWithAndStoreId(searchTerm, '1')
//		println "drug size: "+drugList.size()
//		if(drugList.size() == 0) //chose from store id = 2
//			drugList = inventoryService.getListOfBrandNamesStartingWithAndStoreId(searchTerm, '2')
//		
//		}
//		if(city == 'Mumbai') {
//
//			if(circle == 'Bandra')
//			storeId = 4 //drugList = inventoryService.getListOfBrandNamesStartingWithAndStoreId(searchTerm, '4')//Metro
//			else
//			storeId = 3 //drugList = inventoryService.getListOfBrandNamesStartingWithAndStoreId(searchTerm, '3')//HariOm- Khar and santacruz
//		}

//		drugList = getListOfBrandNamesStartingWithAndStoreId(searchTerm, storeId)
		//drugList = getListOfBrandNamesStartingWith(searchTerm)
		
//		if(drugList.size() == 0){
			List brandDataList = BrandDatabase.findAllByBrandNameIlike(searchTerm+"%", [max:10, offset:0]) // ignore case
			drugList = populateBrandDataCommandListFromBrandDataList(brandDataList)
//			drugList = getListOfBrandNamesStartingWith(searchTerm)
//		}
		
		return drugList
	}


	def getBrandDataMap(BrandDataCommand brandDataCommand){
		Map brandMap = [:]
		brandMap.put("id", brandDataCommand.inventoryId)//brandId}")done because of jquery auto complete
		brandMap.put("name", brandDataCommand.brandId)
		brandMap.put("label", brandDataCommand.brandName)
		brandMap.put("form", brandDataCommand.form)
		brandMap.put("noOfUnits", brandDataCommand.noOfUnits)
		return brandMap
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
		//println "getBrandDataFromBrandId: "+brand?.properties+" count: "+BrandDatabase.count()
		return brand
	}
}
