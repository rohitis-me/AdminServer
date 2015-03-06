package i2i.AdminServer

import grails.transaction.Transactional

@Transactional
class BrandDatabaseService {

	private static final tag='BrandDatabaseService'
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
		List brandNameList = BrandDatabase.findAllByBrandNameIlike(brandName+"%") // ignore case
		//findAllWhere(brandName: brandName+"%")//WhereBrandNameLike(brandName+'%')*.brandName
//		List brandNameList = new ArrayList<BrandDatabase>()
//		brandNameList.add(BrandDatabase.first())
//		brandNameList..add(BrandDatabase.last())
		return brandNameList
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
	
}
