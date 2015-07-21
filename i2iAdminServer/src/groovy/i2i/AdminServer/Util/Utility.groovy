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
		
		TimeZone timezone = TimeZone.getTimeZone("GMT");
		Calendar cal = Calendar.getInstance(timezone)
		cal.add(Calendar.HOUR, 5)
		cal.add(Calendar.MINUTE, 30)
//		println "Calender: "+cal.getTime().toString()
		return cal
	}
}
