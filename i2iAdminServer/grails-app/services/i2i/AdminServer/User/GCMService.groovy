package i2i.AdminServer.User

import grails.transaction.Transactional

@Transactional
class GCMService {

	def androidGcmService
	
    def serviceMethod() {

    }
	
	void sendPushNotification(Map data, List <String> registrationIds) {
			sendPushNotificationToAndroidUser(data, registrationIds)
	}
 
	void sendPushNotificationToAndroidUser(Map data, List<String> tokenList) {
		sendMulticastInstantMessage(data, tokenList)
	}
 
	void sendMulticastInstantMessage(Map data, List<String> registrationIds, String apiKey = apiKeyFromConfig()) {
		androidGcmService.sendMessage(data, registrationIds, '', apiKey)
	}
 
	String apiKeyFromConfig() {
		return grailsApplication.config.android.gcm.api.key
	}
}
