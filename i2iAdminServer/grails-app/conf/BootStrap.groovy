import i2i.AdminServer.Availability
import i2i.AdminServer.BrandDatabase
import i2i.AdminServer.Store
import i2i.AdminServer.User.UserProfile
import i2i.AdminServer.User.Sec.SecRole
import i2i.AdminServer.User.Sec.SecUser
import i2i.AdminServer.User.Sec.SecUserSecRole

class BootStrap {
	def springSecurityService
	def grailsApplication

	def init = { servletContext ->
		println "in bs: turn on bootstrap code: "+grailsApplication.config.turnOnBootStrapCode


		if(grailsApplication.config.turnOnBootStrapCode) {
			
			if(Availability.count() <2159) {
			Availability availability
			for (int i=2159; i<10876;i++) {
				availability = new Availability()
				availability.availabilityId = i
				availability.storeId = '2'
				availability.availabilityIndex = 2
				availability.inventoryId = i.toString()
				if(!availability.save(flush:true)){
					availability.errors.each {
						println "ERROR: "+it
					}
				}
			}
			}
			
//			def adminRole = SecRole.findByAuthority('ROLE_CHEMIST_ADMIN') ?: new SecRole(authority: 'ROLE_CHEMIST_ADMIN').save(failOnError: true)
//
//			def adminUser = SecUser.findByUsername('shobikaecr@gmail.com') ?: new SecUser(
//					username: 'shobikaecr@gmail.com',
//					password: 'shobikaecradmin').save(flush: true)
//
//			if (!adminUser.authorities.contains(adminRole)) {
//				SecUserSecRole.create adminUser, adminRole
//
//				def consumerRole = SecRole.findByAuthority('ROLE_CONSUMER') ?: new SecRole(authority: 'ROLE_CONSUMER').save(failOnError: true)

//				def consumerUser = SecUser.findByUsername('gchandu27@gmail.com') ?: new SecUser(
//						username: 'gchandu27@gmail.com',
//						password: 'chandu123').save(flush: true)
//
//				if (!consumerUser.authorities.contains(consumerRole)) {
//					SecUserSecRole.create consumerUser, consumerRole
//				}
//			}
//
//				int storeCount = Store.count()
//				int availabilityCount = Availability.count()
//
//				String demoStoreId = '2'
//
//				//Init stores
//				if(storeCount == 1) {
//					Store store = new Store(
//							storeId : demoStoreId,
//							storeName : 'Shobika Pharmacy',
//							addressLine1 : "Shop no. 4&5, Mosque Complex",
//							addressLine2 : "Old no.58, New no. 80, Srinivasapuram, ECR (Thiruvanmiyur)",
//							circle : "Kottivakkam",
//							city : "Chennai",
//							phoneNumber: '04442721155',
//							emailId: 'shobikaecr@gmail.com',
//							state : 'Tamil Nadu',
//							latitude : "",
//							longitude : "")
//
//					if(! store.save(flush:true)) {
//						store.errors.each { println "error in saving store: "+it }
//					}
//
//					def brandDataCount = 0//BrandDatabase.count()
//
//					println "saving availability info for branddb count: "+brandDataCount
//					for(int j=1; j<=brandDataCount; j++) {
//						Availability availability = new Availability(
//								storeId : demoStoreId,
//								brandId : (j+0).toString(),
//								availabilityIndex : 2)
//
//						println "saving availability for brand: "+j
//						if(! availability.save(flush:true)) {
//							availability.errors.each { println "error in saving availability: "+it }
//						}
//					}
//
//					println "done saving availability info"
//				}
//
//				if(UserProfile.count() <= 1) {
//					def storeId = demoStoreId
//					def userId = adminUser.id
//					new UserProfile(storeId:storeId, userId: userId).save(flush:true)
//				}

			}
			println "end of bs"

		}
		def destroy = {
		}

	}
