import i2i.AdminServer.Availability
import i2i.AdminServer.Store
import i2i.AdminServer.User.Sec.SecRole
import i2i.AdminServer.User.Sec.SecUser
import i2i.AdminServer.User.Sec.SecUserSecRole

class BootStrap {
	def springSecurityService

    def init = { servletContext ->
		println "in bs"
		String[] alphaArr = ['A','B','C','D','F','W','K','S','R','E','T','Y','B','M','N','Z']
		String[] circleArr = ['Mekhri Road', 'Kanagam Street', 'Dobbaspet']
		String[] cityArr = ['Maranagar', 'Kellimandali', 'Sirapur']
		String[] stateArr = ['Galarpet', 'Dakshanagar', 'Ullaspradesh']
		
		def adminRole = SecRole.findByAuthority('ROLE_CHEMIST_ADMIN') ?: new SecRole(authority: 'ROLE_CHEMIST_ADMIN').save(failOnError: true)
		
		def adminUser = SecUser.findByUsername('admin') ?: new SecUser(
				username: 'admin',
				password: 'admin').save(flush: true)

		if (!adminUser.authorities.contains(adminRole)) {
			SecUserSecRole.create adminUser, adminRole
		}
		
		Random random = new Random();
		int cnt = alphaArr.length
		
		for(int i=0; i<10; i++) {
			
			def str = i.toString();
			def city = cityArr[random.nextInt(cityArr.length)]
			def circle = circleArr[random.nextInt(circleArr.length)]
			def state = stateArr[random.nextInt(stateArr.length)]
			
			String name = alphaArr[random.nextInt(cnt)]+alphaArr[random.nextInt(cnt)]+alphaArr[random.nextInt(cnt)]
			//Init stores
			if(Store.count() == 0) {
			Store store = new Store(
				storeId : "store"+str,
				storeName : name+" Stores",
				addressLine1 : "No: "+str+", "+random.nextInt(15)+"th cross",
				addressLine2 : "Road number: "+str,
				circle : circle,
				city : city,
				state : state,
				latitude : ""+random.nextInt(50),
				longitude : (10+random.nextInt(4)).toString())
			
			if(! store.save(flush:true)) {
				store.errors.each {
					println "error in saving store: "+it
				}
			}
			}
			for(int j=0; j<20; j++) {
			if(Availability.count() == 0) {	
				Availability availability = new Availability(
					storeId : "store"+str,
					brandId : 1+random.nextInt(100).toString(),
					availabilityIndex : random.nextInt(4) as byte)
				
				if(! availability.save(flush:true)) {
					availability.errors.each {
						println "error in saving availability: "+it
					}
				}
			}
			}
		}
    }
    def destroy = {
    }
}
