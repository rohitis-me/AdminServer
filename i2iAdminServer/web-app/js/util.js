$(document).ready(function() {
    
    $('#search_textField').autocomplete({

          source: '/i2iAdminServer/search/listOfBrandNameStartingWith' 
       
    });

});