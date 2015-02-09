package i2i.AdminServer



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AvailabilityController {

	StoreService storeService
	AvailabilityService availabilityService
	
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Availability.list(params), model:[availabilityInstanceCount: Availability.count()]
    }

    def show(Availability availabilityInstance) {
        respond availabilityInstance
    }
	
	
	
	def showInventoryDetails(InventoryAvailabilityCommand inventoryAvailabilityCommand) {
		String storeId = storeService.getLoggedInStoreId()
		
		//TODO
		if(storeId == '0')
			render "error. Not logged in "
			
		println "showInventoryAvailability params: "+params
		
		List brandId = availabilityService.getBrandIdListFromStoreId(storeId)
		brandId.each {
			println "bid: "+brandId
		}
		//BrandDatabase brand = brandDatabaseService.getBrandDataFromBrandId(brandId)
		//inventoryAvailabilityCommand = ordersService.populateBrandToBeApproved(brand)
		render "success"
		//render(view:"showInventoryAvailability", model: [inventoryAvailabilityInstance: inventoryAvailabilityCommand])
	}

    def create() {
        respond new Availability(params)
    }

    @Transactional
    def save(Availability availabilityInstance) {
        if (availabilityInstance == null) {
            notFound()
            return
        }

        if (availabilityInstance.hasErrors()) {
            respond availabilityInstance.errors, view:'create'
            return
        }

        availabilityInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'availability.label', default: 'Availability'), availabilityInstance.id])
                redirect availabilityInstance
            }
            '*' { respond availabilityInstance, [status: CREATED] }
        }
    }

    def edit(Availability availabilityInstance) {
        respond availabilityInstance
    }

    @Transactional
    def update(Availability availabilityInstance) {
        if (availabilityInstance == null) {
            notFound()
            return
        }

        if (availabilityInstance.hasErrors()) {
            respond availabilityInstance.errors, view:'edit'
            return
        }

        availabilityInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Availability.label', default: 'Availability'), availabilityInstance.id])
                redirect availabilityInstance
            }
            '*'{ respond availabilityInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Availability availabilityInstance) {

        if (availabilityInstance == null) {
            notFound()
            return
        }

        availabilityInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Availability.label', default: 'Availability'), availabilityInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'availability.label', default: 'Availability'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
