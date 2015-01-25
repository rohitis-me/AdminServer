package i2i.AdminServer

import grails.transaction.Transactional

@Transactional
class BrandDatabaseService {

    def serviceMethod() {

    }
	
	def getBrandIdFromBrandName(String brandName) {
		println "in getBrandIdFromBrandName"
		String brandId = BrandDatabase.findByBrandName(brandName)*.brandId
		println "Bid: "+brandId+" bn: "+brandName
		
		//FIXME
		brandId = Availability.first().brandId
		return brandId
	}
	
	def getBrandDataFromBrandId(String brandId) {
		BrandDatabase brand = BrandDatabase.findByBrandId(brandId)
		println "getBrandDataFromBrandId: "+brand?.properties+" count: "+BrandDatabase.count()
		return brand
	}
	
	//FIXME
	def getListOfBrandNamesStartingWith(String brandName) {
		List brandNameList = BrandDatabase.findAllWhereBrandNameLike(brandName+'%')*.brandName
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
		tmpBrand.brandId = getBrandId()
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
	def getBrandId() {
		return (BrandToBeApproved.count()).toString()
	}
	
}
