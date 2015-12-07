package i2i.AdminServer.User.Sec

import grails.plugin.springsecurity.SpringSecurityService
import grails.transaction.Transactional
import i2i.AdminServer.OrderCollectionService;
import i2i.AdminServer.User.FileAttachmentService;
import i2i.AdminServer.User.PatientProfile
import i2i.AdminServer.User.PatientProfileService
import i2i.AdminServer.User.SecUserConsumer
import i2i.AdminServer.User.SecUserStore

@Transactional
class SecUserService {

	SpringSecurityService springSecurityService
	PatientProfileService patientProfileService
	OrderCollectionService orderCollectionService
	FileAttachmentService fileAttachmentService
	
	def getLoggedInStoreId() {
		def user = springSecurityService.getCurrentUser()
		if(user){
			def userId = user.id
			def userProfile = SecUserStore.findByUserId(userId)
			def storeId = userProfile.storeId
			println "StoreId: "+storeId
			return storeId
		}
		else
			return 0
	}

	def getLoggedInUserId(){
		def user = springSecurityService.getCurrentUser()
		if(user){
			def userId = user.id
			return userId
		}
		else
			return 0
	}
	
	def getLoggedInUserProfile(){
		def user = springSecurityService.getCurrentUser()		
		//def user = SecUser.findById(userId)
		return user
	}
	
	def getLoggedInUserPatientDetailsList() {
		def userId = getLoggedInUserId()
		List patientProfileList = new ArrayList<PatientProfile>()
		
		if(userId){
			//def userId = user.id
			List patientIdList = SecUserConsumer.findAllByUserId(userId)
			patientIdList.each {
				PatientProfile patientProfile = patientProfileService.getPatientProfileDataFromPatientProfileId(it.patientId)
				patientProfileList.add(patientProfile)
			}
		}

		return patientProfileList
	}

	def getLoggedInUserOrderDetailsList() {
		def userId = getLoggedInUserId()
		List orderCollIdList = new ArrayList<Long>()		
		if(userId){
			//def userId = user.id
			List patientIdList = SecUserConsumer.findAllByUserId(userId)
			patientIdList.each {
				List orderCollIds = orderCollectionService.getListOfOrderCollectionIdsFromPatientId(it.patientId)
				orderCollIds.each { ocId->
					if(ocId && !orderCollIdList.contains(ocId))
						orderCollIdList.add(ocId)
				}	
			}
		}
		println "OrderCollectionIdsize : "+ orderCollIdList.size()
		List orderDetailsList = orderCollectionService.getOrderCollectionCommandListFromOrderCollectionIdList(orderCollIdList)
		
		return orderDetailsList
	}
	
	def getLoggedInUserPrescriptionList() {
		def userId = getLoggedInUserId()
		List attachmentIdList = new ArrayList<String>()
		if(userId){
			//def userId = user.id
			List patientIdList = SecUserConsumer.findAllByUserId(userId)
			patientIdList.each {
				List attachmentIds = orderCollectionService.getListOfAttachmentIdsFromPatientId(it.patientId)
				attachmentIds.each { attachmentId->
					if(attachmentId && !attachmentIdList.contains(attachmentId))
						attachmentIdList.add(attachmentId)
				}
			}
		}
		println "AttachmentIdsize : "+ attachmentIdList.size()
		List attachmentLinkList = new ArrayList<String>()
		attachmentIdList.each { attachmentId->
			println "attachmentId "+ attachmentId
			if(attachmentId){
				String attachmentLink = fileAttachmentService.getAttachmentLinkFromAttachmentId(attachmentId)
				attachmentLinkList.add(attachmentLink)
			}
		}		

		return attachmentLinkList
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
