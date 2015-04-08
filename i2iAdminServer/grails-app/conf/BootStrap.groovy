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
		println "in bs"


		if(grailsApplication.config.turnOnBootStrapCode) {
		def adminRole = SecRole.findByAuthority('ROLE_CHEMIST_ADMIN') ?: new SecRole(authority: 'ROLE_CHEMIST_ADMIN').save(failOnError: true)

		def adminUser = SecUser.findByUsername('kottivakkampharmaadmin') ?: new SecUser(
				username: 'kottivakkampharmaadmin',
				password: 'kottivakkampharmaadmin').save(flush: true)

		if (!adminUser.authorities.contains(adminRole)) {
			SecUserSecRole.create adminUser, adminRole
		}

//		Random random = new Random();
//		int cnt = alphaArr.length
		int storeCount = Store.count()
		int availabilityCount = Availability.count()
		
		String demoStoreId = '2'

//		for(int i=0; i<10; i++) {

//			def str = (i+1).toString();
//			def city = cityArr[random.nextInt(cityArr.length)]
//			def circle = circleArr[random.nextInt(circleArr.length)]
//			def state = stateArr[random.nextInt(stateArr.length)]
//
//			String name = alphaArr[random.nextInt(cnt)]+alphaArr[random.nextInt(cnt)]+alphaArr[random.nextInt(cnt)]
//			println "NAME: "+name
			//Init stores
			if(storeCount == 1) {
				Store store = new Store(
						storeId : demoStoreId,
						storeName : 'Demo Kottivakkam Pharmacy',
						addressLine1 : "A4- 2nd Main Road",
						addressLine2 : "KK Road",
						circle : "Kottivakkam",
						city : "Chennai",
						phoneNumber: '8801736544',
						emailId: 'gchandu27@gmail.com',
						state : 'Tamil Nadu',
						latitude : "",
						longitude : "")

				if(! store.save(flush:true)) {
					store.errors.each { println "error in saving store: "+it }
				}
//			}
//				if(availabilityCount == 0) {
//				def inventoryCount = Inventory.count()
//				List inventoryList = Inventory.list()
				
				def brandDataCount = BrandDatabase.count()
//				List inventoryList = Inventory.list()
								
				println "saving availability info"
				for(int j=1; j<=brandDataCount; j++) {
					Availability availability = new Availability(
							storeId : demoStoreId,
							brandId : (j+0).toString(),
							availabilityIndex : 2)

					if(! availability.save(flush:true)) {
						availability.errors.each { println "error in saving availability: "+it }
					}
				}
				
				println "done saving availability info"
			}
			//			}
//		}
		
		if(UserProfile.count() <= 1) {
		def storeId = demoStoreId
		def userId = adminUser.id
		new UserProfile(storeId:storeId, userId: userId).save(flush:true)
		}
		
		}
		println "end of bs"
		
	}
		def destroy = {
		}
	
}
