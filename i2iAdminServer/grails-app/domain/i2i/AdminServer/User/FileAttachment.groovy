package i2i.AdminServer.User

class FileAttachment {

	Long attachmentId
	String name
	String path
	Date dateUploaded
	
    static constraints = {
		name nullable:false, blank:false,size:1..100
		path nullable:false, blank:false,size:1..100
		dateUploaded nullable:false, blank:false
    }
	
	static mapping = {
		table "fileattachment_tbl"
		id name: 'attachmentId', column: 'attachment_id'
	}
}
