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
		$("#nav_bar").css("top", "0px");
		$("#nav_bar").css("margin-top", "0px");
	}
	else{
		height = 222 - window.pageYOffset;
		$("#nav_bar").css("top", height + "px");
		$("#nav_bar").css("margin-top", "-40px");
	}
}

function selectPhotosNav(){
	$("#photos").addClass('selected');	
}

function alignImages(){
	var wrappers = $(".image_wrapper.thumbnail");
	for (var i = 0; i < wrappers.length - 1; i++) {
		$(wrappers[i]).css("width", $(wrappers[i].children[0]).css("width"));
		var heightString = $(wrappers[i]).css("height");
		var height = heightString.substring(0, heightString.length - 2) - 0;
		var marginTop = (150 - height)/2;
		$(wrappers[i]).css("margin-top", marginTop + "px");
		var widthString = $(wrappers[i]).css("width");
		var width = widthString.substring(0, widthString.length - 2) - 0;
		var marginLeft = (150 - width)/2;
		$(wrappers[i]).css("margin-left", marginLeft + "px");
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