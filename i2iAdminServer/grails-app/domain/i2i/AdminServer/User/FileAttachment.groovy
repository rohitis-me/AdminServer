package i2i.AdminServer.User

class FileAttachment {

	Long attachmentId
	String name
	String path
	String description
	Date dateUploaded
	
    static constraints = {
		name nullable:false, blank:false,size:1..100
		path nullable:false, blank:false,size:1..100
		dateUploaded nullable:false, blank:false
		description nullable:true, blank:true
    }
	
	static mapping = {
		table "fileattachment_tbl"
		id name: 'attachmentId', column: 'attachment_id'
	}
}
