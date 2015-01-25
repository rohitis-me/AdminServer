import i2i.AdminServer.Availability
import i2i.AdminServer.Store

class BootStrap {

    def init = { servletContext ->
		println "in bs"
//		Random random = new Random();
//		
//		for(int i=0; i<10; i++) {
//			
//			def str = i.toString();
//			
//			//Init stores
//			
//			Store store = new Store(
//				storeId : "store"+str,
//				storeName : "StoreNumber"+str,
//				addressLine1 : "Street number: "+str,
//				addressLine2 : "Road number: "+str,
//				circle : "circle "+str,
//				city : "city "+str,
//				state : "state "+str,
//				latitude : ""+random.nextInt(50),
//				longitude : (10+random.nextInt(4)).toString())
//			
//			if(! store.save(flush:true)) {
//				store.errors.each {
//					println "error in saving store: "+it
//				}
//			}
//			
//			for(int j=0; j<20; j++) {
//				
//				Availability availability = new Availability(
//					storeId : "store"+str,
//					brandId : 1+random.nextInt(100).toString(),
//					availabilityIndex : random.nextInt(4) as byte)
//				
//				if(! availability.save(flush:true)) {
//					availability.errors.each {
//						println "error in saving availability: "+it
//					}
//				}
//			}
			
//		}
    }
    def destroy = {
    }
}
