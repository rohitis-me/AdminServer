import i2i.AdminServer.Availability
import i2i.AdminServer.Store
import i2i.AdminServer.ClientSync.Inventory
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
			def availabilityCount = Availability.count()
			def inventoryCount = Inventory.count()
//			if(Availability.count() == 0) {
//			Availability availability
//			Inventory inventory
//			println "populating availability table"
//			for (int i=1; i<= 10;i++) {
//				availability = new Availability()
//				inventory = Inventory.findByInventoryId(i.toString())
//				availability.availabilityId = i
//				availability.storeId = inventory.storeId
//				availability.availabilityIndex = 2
//				availability.inventoryId = inventory.inventoryId
//				if(!availability.save(flush:true)){
//					availability.errors.each {
//						println "ERROR: "+it
//					}
//				}
//				else 
//				println "availability: "+availability.availabilityId
//			}
//			}
			
			def adminRole = SecRole.findByAuthority('ROLE_CHEMIST_ADMIN') ?: new SecRole(authority: 'ROLE_CHEMIST_ADMIN').save(failOnError: true)

			
			
			def adminUser = SecUser.findByUsername('hariom.medical8686@gmail.com') ?: new SecUser(
					username: 'hariom.medical8686@gmail.com',
					email: 'hariom.medical8686@gmail.com',
					password: 'hariommedicaladmin').save(flush: true)
			
					

					println "adminUser: "+adminUser
			if (!adminUser.authorities.contains(adminRole)) 
				SecUserSecRole.create adminUser, adminRole

				String demoStoreId = '3'
				if(!Store.findByStoreId(demoStoreId)) {
				Store store = new Store(storeId : '3',
					storeName : 'Hari Om pharmacy ',
					addressLine1 : "Shop No. 5, Marble Arch Building, ",
					addressLine2 : "Central Avenue Road, Santacruz (W), Mumbai 400054",
					circle : "SantaCruz (West)",
					city : "Mumbai",
					phoneNumber: '02226488624',
					emailId: 'hariom.medical8686@gmail.com',
					state : 'Maharastra',
					latitude : "",
					longitude : "")

			if(! store.save(flush:true)) {
				store.errors.each { println "error in saving store: "+it }
			}
				}
				if(!Store.findByStoreId('4')) {
										Store store1 = new Store(storeId : '4',
											storeName : 'Metro Medical',
											addressLine1 : "9A, Rizvi Mahal, Water Field Road, Opp. Bhabha hopsital",
											addressLine2 : "Bandra (W), Mumbai 400050",
											circle : "Bandra (West)",
											city : "Mumbai",
											phoneNumber: '02226430460',
											emailId: 'metromedical101@gmail.com',
											state : 'Maharastra',
											latitude : "",
											longitude : "")
						
									if(! store1.save(flush:true)) {
										store.errors.each { println "error in saving store: "+it }
									}
				}
				if(UserProfile.count() <= 2) {
					def storeId = demoStoreId
					def userId = adminUser.id
					
					if(!UserProfile.findByUserId(userId))
					new UserProfile(storeId:storeId, userId: userId).save(flush:true)
				}	
				
				
				demoStoreId = '4'

				def storeId = demoStoreId
				
				adminUser = SecUser.findByUsername('metromedical101@gmail.com') ?: new SecUser(
					username: 'metromedical101@gmail.com',
					email: 'metromedical101@gmail.com',
					password: 'metromedicaladmin').save(flush: true)
					
					if (!adminUser.authorities.contains(adminRole))
					SecUserSecRole.create adminUser, adminRole
					
					def userId = adminUser.id
					
					if(!UserProfile.findByUserId(userId))
					new UserProfile(storeId:storeId, userId: userId).save(flush:true)
		
				
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
				

			}
			println "end of bs"

		}
		def destroy = {
		}

	}
