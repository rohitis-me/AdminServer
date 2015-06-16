package i2i.AdminServer

import java.util.Date;

class OrderCollection {

	String personId
	Long orderCollectionId
	String orderRefId
	String offerCode
	String attachmentId //multiple attachments are added with id|id1...
	
    static constraints = {
		personId nullable:false, blank:false,size:1..100
		orderRefId nullable:false, blank:false,size:1..100
		offerCode nullable:true, blank:true,size:1..100
		attachmentId nullable:true, blank:true,size:1..100
    }
	
	static mapping = {
		table 'orderCollection_tbl'
		id name: 'orderCollectionId', column: 'order_collection_id'
	}
}
