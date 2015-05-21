package i2i.AdminServer.User

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import i2i.AdminServer.Constants

//@Transactional(readOnly = true)
class AmazonS3Controller {

	def aws

	def index = {
	}

	def uploadWithDefaultProperties = {

		def fileToUpload = "/Users/blanq01/Desktop/grails-aws/cool-1.jpg"
		def uploadedFile = new File(fileToUpload).s3upload { }

		render """${uploadedFile.source.toString()} <br /><br />${uploadedFile.url()}"""
	}

	def uploadFromInputStream = {

		def file = request.getFile('photo')
		def uploadedFile = file.inputStream.s3upload("file-name-${System.currentTimeMillis()}.jpg") { bucket "file-upload-from-inputstream" }

		render uploadedFile.source.toString()
	}

	def deleteUploadedFile = {

		def bucket = params.bucket
		def file = params.file
		def path = params.path

		aws.s3().on(bucket).delete(file, path)

		render "Deleted file ${file} (path '${path}') of bucket ${bucket}"
	}
}