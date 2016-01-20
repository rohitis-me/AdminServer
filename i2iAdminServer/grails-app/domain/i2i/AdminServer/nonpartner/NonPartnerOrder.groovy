package i2i.AdminServer.nonpartner

class NonPartnerOrder {

	String brandId
	Byte availabilityIndex
	String storeId
	Integer quantity
	Long collectionId
	Long nonpartnerOrderId
	
    static constraints = {
    }
	
	static mapping = {
		table 'non_partner_order_tbl'
		id name: 'nonpartnerOrderId', column: 'nonpartner_order_id'
	}
}
