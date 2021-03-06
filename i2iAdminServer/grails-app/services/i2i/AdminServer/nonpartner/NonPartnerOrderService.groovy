package i2i.AdminServer.nonpartner

import grails.transaction.Transactional
import i2i.AdminServer.BrandDatabaseService
import i2i.AdminServer.Constants
import i2i.AdminServer.webservice.OrderDetail
import i2i.AdminServer.webservice.OrderItemInfo

@Transactional
class NonPartnerOrderService {

	BrandDatabaseService brandDatabaseService
	
    def serviceMethod() {

    }
	
	def getOrderDetailListFromOrderList(List ordersList) {
		List orderDetailsList = new ArrayList<OrderDetail>()
		OrderDetail orderDetail = null
		OrderItemInfo orderItemInfo = new OrderItemInfo()
		
		def tmpOrderCollId = 0
		
		ordersList.each { order->
			
			if(order.collectionId == tmpOrderCollId) {
				orderItemInfo = populateOrderItemInfo(order)
				orderDetail.orderItemInfo.add(orderItemInfo)
			}
			else {
				if(orderDetail) {
					orderDetailsList.add(orderDetail)
				}
				orderDetail = new OrderDetail()
				orderItemInfo = populateOrderItemInfo(order)
				orderDetail.orderItemInfo.add(orderItemInfo)
				orderDetail.availabilityIndex = order.availabilityIndex
				orderDetail.collectionId = order.collectionId
				
			}
			tmpOrderCollId = order.collectionId
		}
		if(orderDetail) {
			orderDetailsList.add(orderDetail)
		}
		return orderDetailsList
		 
	}
	
	private OrderItemInfo populateOrderItemInfo(NonPartnerOrder order) {
		OrderItemInfo orderItemInfo = new OrderItemInfo()
		orderItemInfo.brandId = order.brandId
		orderItemInfo.brandName = brandDatabaseService.getBrandNameFromBrandId(order.brandId)
		orderItemInfo.quantity = order.quantity
		return orderItemInfo
	}
	
	def getAllOrdersForStoreId(String storeId) {
		//TODO
		return NonPartnerOrder.findAllByStoreIdAndAvailabilityIndex(storeId, Constants.AVAILABILITY_PENDING)
	}
	
	public Long getMaxCollectionId() {
		Long maxId = NonPartnerOrder.createCriteria().get {
			projections {
				max "collectionId"
			}
		} as Long

		if(maxId == null)
		{
		  maxId=0
		}

		return maxId
	}
	
	public long insertNonPartnerOrders(List brandIdList , List storeIdList) {
		NonPartnerOrder nonPartnerOrder
		
		long collId = getMaxCollectionId()+1
		
		storeIdList.each { storeId->
			brandIdList.each { brandId->
				nonPartnerOrder = new NonPartnerOrder()
				nonPartnerOrder.availabilityIndex = Constants.AVAILABILITY_PENDING
				nonPartnerOrder.storeId = storeId
				nonPartnerOrder.brandId = brandId
				nonPartnerOrder.collectionId = collId
				nonPartnerOrder.quantity = 1 //FIXME

				if(!nonPartnerOrder.save(flush:true)) {
					nonPartnerOrder.errors.each {
						println "error in insertNonPartnerOrders: "+it
					}
				}
			}
		}
		return collId
	}
	
	def updateNonPartnerAvailability(def collId, def storeId, def orderItems, def deliveryType) {
		List nonPartnerOrderList = NonPartnerOrder.findAllByCollectionIdAndStoreId(collId, storeId)
		
		nonPartnerOrderList.each { nonPartnerOrder->
			def brandId = nonPartnerOrder.brandId
			nonPartnerOrder.availabilityIndex = orderItems[brandId]
			if(!nonPartnerOrder.save(flush:true)) {
				nonPartnerOrder.errors.each {
					println "error in nonpartnerorderservice updateNonPartnerAvailability: "+it
				}
			}
		}
		return 1

		
	}
	
	def getAllConfirmedOrdersForCollectionId(def collId) {
		List nonPartnerConfirmedList = NonPartnerOrder.findAllByCollectionIdAndAvailabilityIndex(collId, Constants.AVAILABILITY_AVAILABLE)
		return nonPartnerConfirmedList
	}
	
	def getStoresListFromOrdersList(def ordersList) {
		List storeList = []
		ordersList.each { order->
			storeList.add(order.storeId)
		}
		return storeList
	}
	
}
