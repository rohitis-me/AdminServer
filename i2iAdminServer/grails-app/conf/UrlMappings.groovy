class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
		
		"/login/$action?"(controller: "login")
		"/logout/$action?"(controller: "logout")

		"/searchList"(controller: "search", action:"search")
		
		"/deliveryDetails"(controller: "patientProfile", action:"deliveryDetails")
		
		"/orderStatus"(controller: "orders", action:"showOrderStatus")

		"/ordersList"(controller: "orders", action:"showOrderDetailsList")
		
		"/storeProfile"(controller: "store", action:"showStoreProfile")
		
		"/inventoryList"(controller: "availability", action:"showInventoryDetails")
		
		"/feedback"(controller: "feedback", action:"feedback")
		
		"/sendFeedback"(controller: "feedback", action:"sendFeedback")
		
		//Home page
        "/"(controller: "search", action:"index")
		
		//Errors
        "500"(view:'/errors/serverError')
	}
}
