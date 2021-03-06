class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
		
		"/login/$action?"(controller: "login")
		"/logout/$action?"(controller: "logout")

//		"/searchList"(controller: "search", action:"search")
		
//		"/deliveryDetails"(controller: "patientProfile", action:"deliveryDetails")
		
//		"/orderStatus"(controller: "orders", action:"showOrderStatus")

//		"/ordersList"(controller: "orders", action:"showOrderDetailsList")
		
		"/storeProfile"(controller: "store", action:"showStoreProfile")
		
		"/inventoryList"(controller: "availability", action:"showInventoryDetails")
		
		"/feedback"(controller: "feedback", action:"feedback")
		
		"/sendFeedback"(controller: "feedback", action:"sendFeedback")
		
//		"/trackOrder"(controller: "orders", action:"trackOrderStatus")

//		"/showOrderDetails"(controller: "orders", action:"showTrackedOrderDetails")
		
		//Home page
        "/"(controller: "search", action:"index")
//		"/*"(view:'/errors/maintenanceError')
		
		//NEW
		"/searchResult"(controller: "search", action:"search")
		"/addItemToCart"(controller: "shoppingCart", action:"addItemToCart")
		"/cartItems"(controller: "shoppingCart", action:"showCartItems")
		"/uploadPrescription"(controller: "fileAttachment", action:"index")
		"/deliveryDetails"(controller: "patientProfile", action:"showDeliveryDetails")
		"/ordersList"(controller: "orderCollection", action:"showOrderDetailsList")
		"/ordersStatus"(controller: "orderCollection", action:"showOrderCollectionDetails")
		"/showOrderDetails"(controller: "orderCollection", action:"showTrackedOrderDetails")
		"/trackOrder"(controller: "orderCollection", action:"trackOrderCollectionDetails")
		//NEW
		//Errors
        "500"(view:'/errors/serverError')
		"404"(view:'/errors/pageNotFound')
		"503"(view:'/errors/maintenanceError')
		
		"/privacyPolicy"(view:'/policies/privacyPolicy')
		"/termsConditions"(view:'/policies/termsConditions')
	}
}
