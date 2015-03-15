/**
 * 
 */
package i2i.AdminServer.Util
import org.apache.commons.lang.RandomStringUtils

/**
 * @author ChandU
 *
 */
class Utility {

	public static String generateRandomString() {
		
		String charset = (('A'..'Z') + ('0'..'9')).join()
		Integer length = 4
		String randomString = RandomStringUtils.random(length, charset.toCharArray())
		
		return randomString
	}
	
	public static Calendar getDateTimeInIST() {
		TimeZone timezone = TimeZone.getTimeZone("GMT+05:30");
		Calendar cal = Calendar.getInstance(timezone)
		println "Calender: "+cal.getInstance().getTime().toString()
		return cal.getInstance()
	}
}
