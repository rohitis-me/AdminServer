package i2i.AdminServer.User.Sec

import grails.plugin.springsecurity.SpringSecurityService
import grails.transaction.Transactional
import i2i.AdminServer.User.UserProfile

@Transactional
class SecUserService {

	SpringSecurityService springSecurityService
	
	def getLoggedInStoreId() {
		def user = springSecurityService.getCurrentUser()
		def userId = user.id
		def userProfile = UserProfile.findByUserId(userId)
		def storeId = userProfile.storeId
		println "StoreId: "+storeId
		return storeId
	}
	
    def serviceMethod() {

    }
}
