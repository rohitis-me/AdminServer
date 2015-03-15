package i2i.AdminServer



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Transactional
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
	
	
	@Secured(['ROLE_CHEMIST_ADMIN'])
	def showInventoryDetails(InventoryAvailabilityCommand inventoryAvailabilityCommand) {
		String storeId = storeService.getLoggedInStoreId()
		
		//FIXME
		if(storeId == '0')
			render "error. Not logged in "
			
		println "showInventoryAvailability param max: "+params.max +"param offset "+params.offset
		int max = params.max ? params.int('max') : 10
		int offset = params.offset ? params.int('offset') : 0
		List inventoryAvailabilityList = availabilityService.populateInventoryAvailabilityListFromStoreId(storeId, max, offset)
		render(view:"showInventoryDetails", model: [inventoryAvailabilityList: inventoryAvailabilityList])
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
	
	def onClickAvailable()
	{
		Long availabilityId = params.availabilityId.toLong()
		println "availabilityId: "+availabilityId
		Byte availableflag = Constants.AVAILABILITY_MEDIUM 
		
		def status = availabilityService.changeAndSaveAvailabilityIndex(availabilityId,availableflag)
		
		if(status == 0)
		render "error"
		
		else
		redirect (controller: 'Availability', action: 'showInventoryDetails')
	}
	
	def onClickUnavailable()
	{
		println "params: "+params
		Long availabilityId = params.availabilityId.toLong()
		println "availabilityId: "+availabilityId
		Byte availableflag = Constants.UNAVAILABLE
		
		def status = availabilityService.changeAndSaveAvailabilityIndex(availabilityId,availableflag)
		
		if(status != 0)
		render "error"
		
		else
		redirect (controller: 'Availability', action: 'showInventoryDetails')
	}
}
