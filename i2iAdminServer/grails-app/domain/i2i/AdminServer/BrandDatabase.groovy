package i2i.AdminServer

class BrandDatabase {
	String brandId
	String brandName
	String manufacturer
	String generic
	String strength
	String noOfUnits
	String form
	String mrp

    static constraints = {
		brandName nullable:false, blank:false,size:3..100
		manufacturer nullable:false, blank:false,size:3..100
		generic nullable:false, blank:false,size:3..100
		strength nullable:false, blank:false,size:3..100
		noOfUnits nullable:false, blank:false,size:3..100
		form nullable:false, blank:false,size:3..100
		mrp nullable:false, blank:false,size:3..100
    }
	
	static mapping = {
		table "drugdata_tbl"
		id generator: 'assigned', column: 'brand_id', name: "brandId", type: 'string'
//		id name: 'brandId'
//		id column: 'brand_id'
	}
}
