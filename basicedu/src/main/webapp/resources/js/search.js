$(function(){

    $('.search_keword').keydown(function(e) {
	    if (e.keyCode == 13) {
	        $('#searchFrm').submit();
	    }
	});

});