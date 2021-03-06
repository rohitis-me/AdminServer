package i2i.AdminServer



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Transactional(readOnly = true)
class StoreController {

	StoreService storeService

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	//    def index(Integer max) {
	//        params.max = Math.min(max ?: 10, 100)
	//        respond Store.list(params), model:[storeInstanceCount: Store.count()]
	//    }
	//
	//    def show(Store storeInstance) {
	//        respond storeInstance
	//    }
	//
	//    def create() {
	//        respond new Store(params)
	//    }

	@Secured(['ROLE_CHEMIST_ADMIN'])
	def showStoreProfile() {
		def storeId = storeService.getLoggedInStoreId()

		if(storeId) {
			Store store = storeService.getStoreDataFromStoreId(storeId)
			render(view:'storeProfile', model: [storeInstance : store])
		}
		else{
			println "storeId not found"
			render "error"
		}

	}

	@Transactional
	def saveStoreProfile(StoreCommand store) {
		Store storeInstance = storeService.populateStoreFromStoreCommand(store)
		println "STORE: "+storeInstance+" \nPARAMS: "+params
		if (storeInstance == null) {
			notFound()
			return
		}

		if (storeInstance.hasErrors()) {
			respond storeInstance.errors, view:'storeProfile'
			return
		}

		//		Store store = storeService.populateStoreFromStoreCommand(storeInstance)
		storeInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'store.updated.message', default: 'Updated!')
				//redirect storeInstance
			}
		}
		render(view:'storeProfile', model: [storeInstance : storeInstance])

	}

	@Transactional
	def save(Store storeInstance) {
		if (storeInstance == null) {
			notFound()
			return
		}

		if (storeInstance.hasErrors()) {
			respond storeInstance.errors, view:'create'
			return
		}

		storeInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [
					message(code: 'store.label', default: 'Store'),
					storeInstance.id
				])
				redirect storeInstance
			}
			'*' { respond storeInstance, [status: CREATED] }
		}
	}

	//    def edit(Store storeInstance) {
	//        respond storeInstance
	//    }

	//    @Transactional
	//    def update(Store storeInstance) {
	//        if (storeInstance == null) {
	//            notFound()
	//            return
	//        }
	//
	//        if (storeInstance.hasErrors()) {
	//            respond storeInstance.errors, view:'edit'
	//            return
	//        }
	//
	//        storeInstance.save flush:true
	//
	//        request.withFormat {
	//            form multipartForm {
	//                flash.message = message(code: 'default.updated.message', args: [message(code: 'Store.label', default: 'Store'), storeInstance.id])
	//                redirect storeInstance
	//            }
	//            '*'{ respond storeInstance, [status: OK] }
	//        }
	//    }
	//
	//    @Transactional
	//    def delete(Store storeInstance) {
	//
	//        if (storeInstance == null) {
	//            notFound()
	//            return
	//        }
	//
	//        storeInstance.delete flush:true
	//
	//        request.withFormat {
	//            form multipartForm {
	//                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Store.label', default: 'Store'), storeInstance.id])
	//                redirect action:"index", method:"GET"
	//            }
	//            '*'{ render status: NO_CONTENT }
	//        }
	//    }
	//
	//    protected void notFound() {
	//        request.withFormat {
	//            form multipartForm {
	//                flash.message = message(code: 'default.not.found.message', args: [message(code: 'store.label', default: 'Store'), params.id])
	//                redirect action: "index", method: "GET"
	//            }
	//            '*'{ render status: NOT_FOUND }
	//        }
	//    }
}
