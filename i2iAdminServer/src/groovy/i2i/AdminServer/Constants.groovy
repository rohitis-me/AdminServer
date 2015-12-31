package i2i.AdminServer

class Constants {

	public static final byte ORDER_PLACED = 1;
	public static final byte ORDER_ACCEPTED = 2;
	public static final byte ORDER_DISPATCHED = 3;
	public static final byte ORDER_DELIVERED = 4;
	public static final byte ORDER_CANCELLED = 0;
	public static final byte ORDER_REJECTED = -1;
	
	public static final byte AVAILABILITY_LOW = 1;
	public static final byte AVAILABILITY_MEDIUM = 2;
	public static final byte AVAILABILITY_HIGH = 3;
	public static final byte UNAVAILABLE = 0;
	
	//public static final String orderStatus[] = {'Order Rejected', 'Order Placed', 'Order Accepted', 'Order Dispatched', 'Order Delivered'}
	
	public static final String[] circleArray_Chennai = ["Thiruvanmiyur", "Kottivakkam", "Kandanchavadi", "Adyar", "Besant Nagar"]
	public static final String[] circleArray_Mumbai = ["Bandra", "SantaCruz", "Khar"]

	public static final String supportEmail="support@i2itech.co.in"//for feedback
	public static final String adminEmail="rohits.iitm@gmail.com"+ ","+ "adhirajalai@gmail.com"+","+ "chandu@i2itech.co.in"//for orders
	
	public static final String dateFormat="dd-MM-yyyy, h:mm a"
	
	public static final String env_DEMO='Demo'
	public static final String env_LOCAL='Local'
	public static final String env_PROD='Prod'

	public static final String envLink_LOCAL='http://localhost:8080/i2iAdminServer/'
	public static final String envLink_DEMO='http://demo.pillocate.com/'
	public static final String envLink_PROD='http://www.pillocate.com/'
	
	public static String envLink=''
	public static String analyticsTrackingId=''
	public static String[] circleArray = []
//	public static def quantityArray = new int[100]
	
	public static final String PrescriptionOnDeliveryMessage = 'Show prescription on delivery'
	public static final String PrescriptionUploadNowMessage = 'Upload prescription now'
	
	//Tracking ID for google analytics
	public static final String analyticsTrack_DEMO='UA-61334324-1'
	public static final String analyticsTrack_PROD='UA-61334324-2'
	
	public static final String ROLE_CHEMIST_ADMIN = 'ROLE_CHEMIST_ADMIN'
	public static final String ROLE_CONSUMER = 'ROLE_CONSUMER'
	
	public static final String WEBSERVICE_ERROR_DELIVERYDETAILS = '-1'
	public static final String WEBSERVICE_ERROR_TRACKINGID = '-2'
	
	public static final String mailSubject_NewOrder_Admin = 'Order@i2i'
	public static final String mailSubject_NewOrder_Consumer = 'Pillocate: Order placed successfully'
	public static final String mailSubject_OrderAccepted_Consumer = 'Pillocate: Order Confirmation'
	public static final String mailSubject_OrderRejected_Consumer = 'Pillocate: Order rejected'
	public static final String mailSubject_OrderCancel_Admin = 'Cancellation-Order@i2i'
	public static final String mailSubject_OrderCancel_Consumer = 'Pillocate: Order Cancellation'
	
	public static final String amazonS3Link ='https://s3-ap-southeast-1.amazonaws.com/'
	public static final String bucket_LOCAL='testi2i'
	public static final String bucket_DEMO='demoi2i'
	public static final String bucket_PROD='prodi2i'
	public static String amazonS3Bucket =''
	
	public static final String helpline = '+91-9930686044'
	
	public static final String ORDER_awaitingconfirmation = 'Awaiting Confirmation'
}
