package i2i.AdminServer

class Constants {

	public static final byte ORDER_PLACED = 1;
	public static final byte ORDER_ACCEPTED = 2;
	public static final byte ORDER_DISPATCHED = 3;
	public static final byte ORDER_DELIVERED = 4;
	public static final byte ORDER_REJECTED = 0;

	public static final byte AVAILABILITY_LOW = 1;
	public static final byte AVAILABILITY_MEDIUM = 2;
	public static final byte AVAILABILITY_HIGH = 3;
	public static final byte UNAVAILABLE = 0;
	
	//public static final String orderStatus[] = {'Order Rejected', 'Order Placed', 'Order Accepted', 'Order Dispatched', 'Order Delivered'}
	

	public static final String supportEmail="support@i2itech.org"//for feedback
	public static final String adminEmail="rohits.iitm@gmail.com"//for orders
	
	public static final String dateFormat="dd-MM-yyyy, h:mm a"
	
	public static final String env_DEMO='Demo'
	public static final String env_LOCAL='Local'
	public static final String env_PROD='Prod'

	public static final String envLink_DEMO='http://demoi2i.elasticbeanstalk.com/'
	public static final String envLink_PROD='http://www.pillocate.com/'
	
	public static String envLink=''
	
	//FIXME: Hard coding
	public static final int hardCodedInventoryCount=2158
}
