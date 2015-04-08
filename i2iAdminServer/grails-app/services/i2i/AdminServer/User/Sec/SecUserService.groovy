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

//	boolean canRegister(String username, String password, String confirmPwd){
//		if(password != confirmPwd)
//			return false
//
//		if(SecUser.findByUsername(username))
//			return false
//
//		return true
//	}
//
//	def registerAndSaveNewConsumer(String username, String password){
//		println "username: "+username +" "+ "password: "+password
//		def consumerRole = SecRole.findByAuthority('ROLE_CONSUMER') ?: new SecRole(authority: 'ROLE_CONSUMER').save(failOnError: true)
//		println "role: "+consumerRole
//		
//		def consumerUser = new SecUser(
//				username: username,
//				password: password).save(flush: true)
//				
//		println "user: "+consumerUser
//				
//		if (!consumerUser.authorities.contains(consumerRole)) {
//			SecUserSecRole.create consumerUser, consumerRole
//		}
//	}
	def serviceMethod() {
	}
}
