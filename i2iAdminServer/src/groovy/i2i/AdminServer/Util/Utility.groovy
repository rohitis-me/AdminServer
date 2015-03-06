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
}
