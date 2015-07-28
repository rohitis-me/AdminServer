package i2i.AdminServer.User

import java.util.List;

import grails.transaction.Transactional
import i2i.AdminServer.Constants
import i2i.AdminServer.OrderCollectionCommand
import i2i.AdminServer.OrderDetailsCommand
import i2i.AdminServer.Store

@Transactional
class EmailService {

	def mailService
	def grailsApplication

	def serviceMethod() {
	}

	def sendEMail(String toAdd, String mailSubject, String msg){

		if(!(grailsApplication.config.env == Constants.env_PROD))
			mailSubject = grailsApplication.config.env+' '+mailSubject

		try {
			mailService.sendMail {
				async true
				to toAdd
				from "i2i Support  <support@i2itech.co.in>"
				subject mailSubject
				body msg
			}
		}
		catch(Exception exp) {
			println "Exception: "+exp.getRootCause()+"\n"+exp.getStackTrace()
		}
		println "SENT MAIL"
	}

	def sendOrderMail(String toAdd, String mailSubject, OrderDetailsCommand orderDetails, OrderCollectionCommand orderCollCommand){
		println "In send order Mail: "+orderDetails.properties

		if(!(grailsApplication.config.env == Constants.env_PROD))
			mailSubject = grailsApplication.config.env+' '+mailSubject

		try {

			if(toAdd) {
				mailService.sendMail {
					async true
					to toAdd
					from "i2i Support  <support@i2itech.co.in>"
					if(grailsApplication.config.env == Constants.env_PROD)
					bcc Constants.adminEmail
					subject mailSubject
					body( view:"/mail/orderMail",
					model:[orderCollCommand: orderCollCommand, orderDetails:orderDetails])
				}
			}
			else {
				mailService.sendMail {
					to Constants.adminEmail
					from "i2i Support  <support@i2itech.co.in>"
					subject mailSubject
					body( view:"/mail/orderMail",
					model:[orderCollCommand:orderCollCommand, orderDetails:orderDetails])
				}
			}
			println "SENT MAIL"
		}
		catch(Exception exp) {
			println "Exception: "+exp
			println "MAIL NOT SENT"
		}
	}

	def sendOrderMail(String toAdd, String mailSubject, OrderCollectionCommand orderCollCommand, List orderDetailsList){
		println "In send order Mail: "+orderCollCommand.properties

		if(!(grailsApplication.config.env == Constants.env_PROD))
			mailSubject = grailsApplication.config.env+' '+mailSubject

		try {

			if(toAdd) {
				mailService.sendMail {
					async true
					to toAdd
					from "i2i Support  <support@i2itech.co.in>"
					if(grailsApplication.config.env == Constants.env_PROD)
					bcc Constants.adminEmail
					subject mailSubject
					body( view:"/mail/orderDetailsMail", model:[orderDetails:orderCollCommand, orderDetailsList:orderDetailsList])
				}
			}
			else {
				mailService.sendMail {
					to Constants.adminEmail
					from "i2i Support  <support@i2itech.co.in>"
					subject mailSubject
					body( view:"/mail/orderDetailsMail", model:[orderDetails:orderCollCommand, orderDetailsList:orderDetailsList])
				}
			}
			println "SENT MAIL"
		}
		catch(Exception exp) {
			println "Exception: "+exp
			println "MAIL NOT SENT"
		}
	}
	
	def sendTrackingIdToCustomer(String mailSubject, OrderCollectionCommand orderCollCommand, List orderDetailsList, Store store){
		println "In sendTrackingIdToCustomer: "+orderCollCommand.properties

		if(!(grailsApplication.config.env == Constants.env_PROD))
			mailSubject = grailsApplication.config.env+' '+mailSubject

		String toAdd = orderCollCommand.emailID
		try {

			if(toAdd) {
				mailService.sendMail {
					async true
					to toAdd
					from "i2i Support  <support@i2itech.co.in>"
					if(grailsApplication.config.env == Constants.env_PROD)
					bcc Constants.adminEmail
					subject mailSubject
					body( view:"/mail/trackOrderDetailsMail",
						model:[orderDetails:orderCollCommand,orderDetailsList:orderDetailsList, storeInstance: store])
				}
				println "SENT MAIL"
			}
			
			else {
				mailSubject = "AdminOnly "+mailSubject
				
				mailService.sendMail {
					async true
					to Constants.adminEmail
					from "i2i Support  <support@i2itech.co.in>"
					subject mailSubject
					body( view:"/mail/trackOrderDetailsMail",
					model:[orderDetails:orderCollCommand, orderDetailsList:orderDetailsList, storeInstance: store])
				}
			}
			
		}
		catch(Exception exp) {
			println "Exception: "+exp
			println "MAIL NOT SENT"
		}
	}
	
	def sendTrackingIdToCustomer(String mailSubject, OrderDetailsCommand orderDetails, OrderCollectionCommand orderCollCommand){
		println "In sendTrackingIdToCustomer: "+orderDetails.properties

		if(!(grailsApplication.config.env == Constants.env_PROD))
			mailSubject = grailsApplication.config.env+' '+mailSubject

		String toAdd = orderCollCommand.emailID
		try {

			if(toAdd) {
				mailService.sendMail {
					async true
					to toAdd
					from "i2i Support  <support@i2itech.co.in>"
					if(grailsApplication.config.env == Constants.env_PROD)
					bcc Constants.adminEmail
					subject mailSubject
					body( view:"/mail/trackOrderMail",
					model:[orderDetails:orderDetails, orderCollCommand:orderCollCommand])
				}
				println "SENT MAIL"
			}
			
			else {
				mailSubject = "AdminOnly "+mailSubject
				
				mailService.sendMail {
					async true
					to Constants.adminEmail
					from "i2i Support  <support@i2itech.co.in>"
					subject mailSubject
					body( view:"/mail/trackOrderMail",
					model:[orderDetails:orderDetails, orderCollCommand:orderCollCommand])
				}
			}
			
		}
		catch(Exception exp) {
			println "Exception: "+exp
			println "MAIL NOT SENT"
		}
	}
}
