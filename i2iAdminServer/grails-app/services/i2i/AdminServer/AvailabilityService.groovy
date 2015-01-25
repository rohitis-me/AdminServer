package i2i.AdminServer

import grails.transaction.Transactional

@Transactional
class AvailabilityService {

    def serviceMethod() {

    }
	
	def getStoreIdsFromBrandId(String brandId) {
		
//		Availability availability = Availability.first()
		List storeIdList = Availability.findAllByBrandIdAndAvailabilityIndexGreaterThan(brandId, 0)*.storeId
		println "availability service: "+storeIdList.count//+"\n* availability: "+availability.properties
		for(int i=0;i<storeIdList.size();i++)
		{
			for(int j=i+1;j<storeIdList.size();j++)
			{
				if(storeIdList[i] ==storeIdList[j] )
				{
					storeIdList.remove(j);
					j--;
				}
			}
		}
		return storeIdList
	}
	
}
