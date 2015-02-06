$(document).ready(function() {
    $.ajax({
        type: "GET",
        url: "/search/listOfBrandNameStartingWith/",
        success : function(response) {

            $("#search_textField").autocomplete({
                source: response
            });
        }
    });

}); 