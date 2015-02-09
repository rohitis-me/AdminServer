package i2i.AdminServer



import grails.test.mixin.*
import spock.lang.*

@TestFor(AvailabilityController)
@Mock(Availability)
class AvailabilityControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.availabilityInstanceList
            model.availabilityInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.availabilityInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            def availability = new Availability()
            availability.validate()
            controller.save(availability)

        then:"The create view is rendered again with the correct model"
            model.availabilityInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            availability = new Availability(params)

            controller.save(availability)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/availability/show/1'
            controller.flash.message != null
            Availability.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def availability = new Availability(params)
            controller.show(availability)

        then:"A model is populated containing the domain instance"
            model.availabilityInstance == availability
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def availability = new Availability(params)
            controller.edit(availability)

        then:"A model is populated containing the domain instance"
            model.availabilityInstance == availability
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/availability/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def availability = new Availability()
            availability.validate()
            controller.update(availability)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.availabilityInstance == availability

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            availability = new Availability(params).save(flush: true)
            controller.update(availability)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/availability/show/$availability.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/availability/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def availability = new Availability(params).save(flush: true)

        then:"It exists"
            Availability.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(availability)

        then:"The instance is deleted"
            Availability.count() == 0
            response.redirectedUrl == '/availability/index'
            flash.message != null
    }
}
