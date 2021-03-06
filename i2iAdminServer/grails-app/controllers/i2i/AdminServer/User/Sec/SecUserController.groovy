package i2i.AdminServer.User.Sec



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import i2i.AdminServer.Constants
import i2i.AdminServer.OrderCollectionCommand
import i2i.AdminServer.OrderCollectionService
import i2i.AdminServer.OrdersService

import com.metasieve.shoppingcart.SessionUtils


//@Transactional(readOnly = true)
class SecUserController {

	def springSecurityService
	def secUserService
	OrderCollectionService orderCollectionService
	OrdersService ordersService

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

//	def doLogin(){
//		request.headerNames.each{ println "Header: "+ it }
//
//		def source = request.getHeader("Source")
//		println "source: "+ source
//		if(source !=null || source=="IONIC"){
//			def session = SessionUtils.getSession()
//			session.Source = "IONIC"
//			render(text:1)
//			//redirect(controller:'login', action:'auth',  model: [j_username : params.j_username, j_password:params.j_password])
//		}
//		else
//			render(text:-1)
//		//redirect (controller: 'search', action: 'index')
//	}

	def onLoginSuccess(){
		println "received params: "+params

		def authList = springSecurityService.getPrincipal().getAuthorities()
		println "AUTH: "+authList
		String role = authList.getAt(0)
		println "role: "+role
		if(role == Constants.ROLE_CHEMIST_ADMIN)
			redirect (controller: 'orderCollection', action: 'showOrderDetailsList')
		else
		{
			def session = SessionUtils.getSession()
			println "session source: "+session?.Source
			if(session?.Source =="WebApp"){
				redirect (controller: 'search', action: 'index')
			}
			else{
				render(text:1)
			}
		}
	}

	def onLoginFail(){
		//			def source = request.getHeader("Source")
		//			println "source"+ source
		//			if(source !=null || source=="IONIC"){
		def session = SessionUtils.getSession()
		if(session?.Source =="WebApp"){
			redirect(uri: "/login/authfail?login_error=1")
		}
		else
			render(text:-1)
	}
	
	def onLogout(){
		def session = SessionUtils.getSession()
		println "session source: "+session?.Source
//		if(session?.Source =="WebApp"){
			redirect (controller: 'search', action: 'index')
//		}
//		else{
//			render(text:1)
//		}
	}
	
//	@Secured(['ROLE_CONSUMER'])
	def showUserProfile(){
		def user = springSecurityService.getCurrentUser()
		println "logged in User: "+ user?.properties
		render(view:'userProfile', model: [username:user?.username, email:user?.email])
	}

	def showAllOrders(){
		List orderDetailsList = secUserService.getLoggedInUserOrderDetailsList()
		byte orderStatus = -2

		render(view:"orderDetailsList", model: [orderDetailsList: orderDetailsList, orderStatus:orderStatus])
	}
	
	def showOrderDetails() {
		println "showOrderDetails params: "+params
		Long orderCollId = params.orderCollectionId?.toLong()

		OrderCollectionCommand orderCollCommand = orderCollectionService.getOrderCollectionCommandFromOrderCollectionId(orderCollId)
		List orderDetailsCommandList = ordersService.getListOfOrderDetailsCommandFromOrderCollectionId(orderCollId)

//		String attachmentLink = ""
//		if(orderCollCommand?.attachmentId)
//			attachmentLink = fileAttachmentService.getAttachmentLinkFromAttachmentId(orderCollCommand?.attachmentId)
		render(view:"orderDetails", model: [orderDetailsCommandList: orderDetailsCommandList, orderCollCommand:orderCollCommand])//, attachmentLink:attachmentLink])
	}
	
	def showAllSavedAddresses(){
		List patientProfileList = secUserService.getLoggedInUserPatientDetailsList()
		render(view:'savedAddressList', model:['patientProfileList':patientProfileList])
	}
	
	def showUploadedPrescriptions(){
		List attachmentLinkList = secUserService.getLoggedInUserPrescriptionList()
		render(view:'uploadedPrescriptionList', model:['attachmentLinkList':attachmentLinkList])
	}
	//	def registerUser(RegisterCommand registerCommand){
	//		println "received params: "+params
	//		println "RC: "+ registerCommand.properties
	//
	//		if(!registerCommand.validate()) {
	//			registerCommand.errors.each { println it }
	//
	//			redirect (controller: 'login', action: 'auth')
	//		}
	//		else{
	//			secUserService.registerAndSaveNewConsumer(registerCommand.username, registerCommand.password)
	////			redirect (controller: 'login', action: 'auth', model: [j_username : registerCommand.username, j_password:registerCommand.password])
	////			redirect(controller:'login', action:'j_spring_security_check')
	//			springSecurityService.reauthenticate(registerCommand.username);
	//			redirect (controller: 'login', action: 'auth')
	//		}
	//	}

	def index(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		respond SecUser.list(params), model:[secUserInstanceCount: SecUser.count()]
	}

	def show(SecUser secUserInstance) {
		respond secUserInstance
	}

	def create() {
		respond new SecUser(params)
	}

	@Transactional
	def save(SecUser secUserInstance) {
		if (secUserInstance == null) {
			notFound()
			return
		}

		if (secUserInstance.hasErrors()) {
			respond secUserInstance.errors, view:'create'
			return
		}

		secUserInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [
					message(code: 'secUser.label', default: 'SecUser'),
					secUserInstance.id
				])
				redirect secUserInstance
			}
			'*' { respond secUserInstance, [status: CREATED] }
		}
	}

	def edit(SecUser secUserInstance) {
		respond secUserInstance
	}

	@Transactional
	def update(SecUser secUserInstance) {
		if (secUserInstance == null) {
			notFound()
			return
		}

		if (secUserInstance.hasErrors()) {
			respond secUserInstance.errors, view:'edit'
			return
		}

		secUserInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [
					message(code: 'SecUser.label', default: 'SecUser'),
					secUserInstance.id
				])
				redirect secUserInstance
			}
			'*'{ respond secUserInstance, [status: OK] }
		}
	}

	@Transactional
	def delete(SecUser secUserInstance) {

		if (secUserInstance == null) {
			notFound()
			return
		}

		secUserInstance.delete flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.deleted.message', args: [
					message(code: 'SecUser.label', default: 'SecUser'),
					secUserInstance.id
				])
				redirect action:"index", method:"GET"
			}
			'*'{ render status: NO_CONTENT }
		}
	}

	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [
					message(code: 'secUser.label', default: 'SecUser'),
					params.id
				])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
}
