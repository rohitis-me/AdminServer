package i2i.AdminServer

import grails.transaction.Transactional

@Transactional
class OrdersService {

    def serviceMethod() {

    }
	
	def populateOrderDetailsCommand(Store storeData, BrandDatabase brandData) {
		OrderDetailsCommand orderDetails = new OrderDetailsCommand()
		orderDetails.brandId = brandData.brandId
		orderDetails.brandName = brandData.brandName
		orderDetails.storeId = storeData.storeId
		orderDetails.storeName = storeData.storeName
		return orderDetails
	}
}
