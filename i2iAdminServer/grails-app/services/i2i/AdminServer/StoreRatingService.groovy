package i2i.AdminServer

import grails.transaction.Transactional

@Transactional
class StoreRatingService {

    def serviceMethod() {

    }
	
	def saveRating(String storeId, int rating) {
		StoreRating storeRating = new StoreRating(storeId:storeId, rating:rating)
		
		if(storeRating.save(flush:true)) {
			return true
		}
		else {
			storeRating.errors.each{
			println "Error in StoreRatingService saveRating: "+it
			}
			return false
		}
	}
	
	def getAverageRatingForStoreFromStoreId(String storeId) {
		List storeRatingList = StoreRating.findByStoreId(storeId)
		int avgRating = 0
		storeRating.each { rating->
			if(avgRating == 0)
			avgRating = rating
			else
			avgRating = (rating+avgRating)/2
		}
		return avgRating
	}
}
