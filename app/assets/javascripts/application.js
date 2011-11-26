//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .
$(document).ready(function(){
	$("a.gallery_image").fancybox();
	var e = document.getElementById('update_body'),
	    f = document.getElementById('counter');

	if(e){
		e.onkeyup = function() {
	  		f.innerHTML = (140 - e.value.length);
		}	
	}
});
function shorten(url) {
var req = $.ajax({ url: "/short.json",
				 					 data: "url=" + url,
									 success: function(data) {
										$("#update_body").val($("#update_body").val() + data["id"]);
									 }
					});
}