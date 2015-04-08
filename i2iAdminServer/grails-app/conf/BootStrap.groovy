import i2i.AdminServer.Availability
import i2i.AdminServer.Store
import i2i.AdminServer.ClientSync.Inventory
import i2i.AdminServer.User.UserProfile
import i2i.AdminServer.User.Sec.SecRole
import i2i.AdminServer.User.Sec.SecUser
import i2i.AdminServer.User.Sec.SecUserSecRole

class BootStrap {
	def springSecurityService

	def init = { servletContext ->
		println "in bs"
//		String[] alphaArr = [
//			'A',
//			'B',
//			'C',
//			'D',
//			'S',
//			'R',
//			'E',
//			'M',
//			'N',
//			'P',
//			'L'
//		]
//		String[] circleArr = [
//			'Adyar',
//			'Perungudi',
//			'Sholinganallur',
//			'Alandur',
//			'Besant Nagar',
//			'Thiruvanmiyur',
//			'Saidapet'
//		]
//		String[] cityArr = ['Chennai']
//		String[] stateArr = ['Tamil Nadu']

		def adminRole = SecRole.findByAuthority('ROLE_CHEMIST_ADMIN') ?: new SecRole(authority: 'ROLE_CHEMIST_ADMIN').save(failOnError: true)

		def adminUser = SecUser.findByUsername('medilinepharmaadmin') ?: new SecUser(
				username: 'medilinepharmaadmin',
				password: 'medilinepharmaadmin').save(flush: true)

		if (!adminUser.authorities.contains(adminRole)) {
			SecUserSecRole.create adminUser, adminRole
		}

		def consumerRole = SecRole.findByAuthority('ROLE_CONSUMER') ?: new SecRole(authority: 'ROLE_CONSUMER').save(failOnError: true)
		
		def consumerUser = SecUser.findByUsername('consumeri2i') ?: new SecUser(
				username: 'consumeri2i',
				password: 'consumeri2i').save(flush: true)

		if (!consumerUser.authorities.contains(consumerRole)) {
			SecUserSecRole.create consumerUser, consumerRole
		}
				
//		Random random = new Random();
//		int cnt = alphaArr.length
		int storeCount = Store.count()
		int availabilityCount = Availability.count()

//		for(int i=0; i<10; i++) {

//			def str = (i+1).toString();
//			def city = cityArr[random.nextInt(cityArr.length)]
//			def circle = circleArr[random.nextInt(circleArr.length)]
//			def state = stateArr[random.nextInt(stateArr.length)]
//
//			String name = alphaArr[random.nextInt(cnt)]+alphaArr[random.nextInt(cnt)]+alphaArr[random.nextInt(cnt)]
//			println "NAME: "+name
			//Init stores
			if(storeCount == 0) {
				Store store = new Store(
						storeId : "1",
						storeName : 'Mediline Pharmacy',
						addressLine1 : "A4- 2nd Main Road",
						addressLine2 : "Thiruvalluvar Nagar",
						circle : "Thiruvanmiyur",
						city : "Chennai",
						phoneNumber: '04442331561',
						emailId: 'mahadevanvolex@gmail.com',
						state : 'Tamil Nadu',
						latitude : "",
						longitude : "")

				if(! store.save(flush:true)) {
					store.errors.each { println "error in saving store: "+it }
				}
			}
				if(availabilityCount == 0) {
				def inventoryCount = Inventory.count()
				List inventoryList = Inventory.list()
				
				for(int j=1; j<=inventoryCount; j++) {
					
					Availability availability = new Availability(
							storeId : "1",
							inventoryId : (j+0).toString(),
							availabilityIndex : 2)

					if(! availability.save(flush:true)) {
						availability.errors.each { println "error in saving availability: "+it }
					}
				}
			}
			//			}
//		}
		
		if(UserProfile.count() == 0) {
		def storeId = Store.first().storeId
		def userId = SecUser.first().id
		new UserProfile(storeId:storeId, userId: userId).save(flush:true)
		}
		
	}
		def destroy = {
		}
	
}
