//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .
$(document).ready(function(){
	adjustNav();
	$("a.gallery_image").fancybox();
	$(window).scroll(function (){
		adjustNav();
	});
	var e = document.getElementById('update_body'),
	    f = document.getElementById('counter');

	if(e){
		e.onkeyup = function() {
	  		f.innerHTML = (140 - e.value.length);
		}	
	}
});

function adjustNav(){
	if(window.pageYOffset > 185){
		$("#nav_container").css("top", "0px");
		$("#nav_container").css("margin-top", "0px");
	}
	else{
		height = 222 - window.pageYOffset;
		$("#nav_container").css("top", height + "px");
		$("#nav_container").css("margin-top", "-40px");
	}
}

function shorten(url) {
var req = $.ajax({ url: "/short.json",
				 					 data: "url=" + url,
									 success: function(data) {
										$("#update_body").val($("#update_body").val() + data["id"]);
									 }
					});
}