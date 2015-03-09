package i2i.AdminServer.User

import i2i.AdminServer.BrandDatabaseService
import i2i.AdminServer.OrderDetailsCommand
import i2i.AdminServer.OrdersService
import i2i.AdminServer.StoreService
import i2i.AdminServer.ClientSync.InventoryService

class PatientProfileController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	BrandDatabaseService brandDatabaseService
	StoreService storeService
	OrdersService ordersService
	InventoryService inventoryService	
	
    def index = {
        redirect(action: "list", params: params)
    }

	def deliveryDetails(OrderDetailsCommand orderDetailsCommand) {
		println "BrandID: "+orderDetailsCommand.brandId+"InventoryID: "+orderDetailsCommand.inventoryId+" storeId: "+orderDetailsCommand.storeId+" circle: "+orderDetailsCommand.circle
		//println "PARAMS: "+orderDetailsCommand.properties
		
		if(orderDetailsCommand.brandId){
			def brandData = brandDatabaseService.getBrandDataFromBrandId(orderDetailsCommand.brandId)
			def storeData = storeService.getStoreDataFromStoreId(orderDetailsCommand.storeId)
			println "Branddata: "+brandData.brandId+" storedata: "+storeData.storeId
			OrderDetailsCommand orderDetails = ordersService.populateOrderDetailsFromStoreAndBrandData(storeData, brandData)
			println "success"
		
			//FIXME
			orderDetails.circle = orderDetailsCommand.circle
			orderDetails.city = 'Chennai'
			orderDetails.state = 'Tamil Nadu'
			orderDetails.country = 'India'
			orderDetails.age = 20
			orderDetails.quantity = 1
			
	        render(view:'deliveryDetails', model: [orderDetails : orderDetails, brandData:brandData, storeName:storeData?.storeName, isEmergencyDeliveryAvailable:storeData?.isEmergencyDeliveryAvailable])
		}
		else if(orderDetailsCommand.inventoryId){
			def brandData = inventoryService.getBrandDataFromInventoryId(orderDetailsCommand.inventoryId)
			def storeData = storeService.getStoreDataFromStoreId(orderDetailsCommand.storeId)
			println "Branddata: "+brandData.brandName+" storedata: "+storeData.storeId
			OrderDetailsCommand orderDetails = ordersService.populateOrderDetailsFromStoreAndBrandData(storeData, brandData)
			orderDetails.inventoryId = orderDetailsCommand.inventoryId
			println "success"
		
			//FIXME
			orderDetails.circle = orderDetailsCommand.circle
			orderDetails.city = 'Chennai'
			orderDetails.state = 'Tamil Nadu'
			orderDetails.country = 'India'
			orderDetails.age = 20
			orderDetails.quantity = 1
			
	        render(view:'deliveryDetails', model: [orderDetails : orderDetails, brandData:brandData, storeName:storeData?.storeName, isEmergencyDeliveryAvailable:storeData?.isEmergencyDeliveryAvailable])
		}
	}
	
	
	
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [patientProfileInstanceList: PatientProfile.list(params), patientProfileInstanceTotal: PatientProfile.count()]
    }

    def create = {
        def patientProfileInstance = new PatientProfile()
        patientProfileInstance.properties = params
        return [patientProfileInstance: patientProfileInstance]
    }

    def save = {
        def patientProfileInstance = new PatientProfile(params)
        if (patientProfileInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'patientProfile.label', default: 'PatientProfile'), patientProfileInstance.id])}"
            redirect(action: "show", id: patientProfileInstance.id)
        }
        else {
            render(view: "create", model: [patientProfileInstance: patientProfileInstance])
        }
    }

    def show = {
        def patientProfileInstance = PatientProfile.get(params.id)
        if (!patientProfileInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patientProfile.label', default: 'PatientProfile'), params.id])}"
            redirect(action: "list")
        }
        else {
            [patientProfileInstance: patientProfileInstance]
        }
    }

    def edit = {
        def patientProfileInstance = PatientProfile.get(params.id)
        if (!patientProfileInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patientProfile.label', default: 'PatientProfile'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [patientProfileInstance: patientProfileInstance]
        }
    }

    def update = {
        def patientProfileInstance = PatientProfile.get(params.id)
        if (patientProfileInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (patientProfileInstance.version > version) {
                    
                    patientProfileInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'patientProfile.label', default: 'PatientProfile')] as Object[], "Another user has updated this PatientProfile while you were editing")
                    render(view: "edit", model: [patientProfileInstance: patientProfileInstance])
                    return
                }
            }
            patientProfileInstance.properties = params
            if (!patientProfileInstance.hasErrors() && patientProfileInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'patientProfile.label', default: 'PatientProfile'), patientProfileInstance.id])}"
                redirect(action: "show", id: patientProfileInstance.id)
            }
            else {
                render(view: "edit", model: [patientProfileInstance: patientProfileInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patientProfile.label', default: 'PatientProfile'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def patientProfileInstance = PatientProfile.get(params.id)
        if (patientProfileInstance) {
            try {
                patientProfileInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'patientProfile.label', default: 'PatientProfile'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'patientProfile.label', default: 'PatientProfile'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patientProfile.label', default: 'PatientProfile'), params.id])}"
            redirect(action: "list")
        }
    }
}
