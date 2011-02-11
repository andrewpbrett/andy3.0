var located = false;
var geolat;
var geolong;

function success(position){
	located = true;
	geolat = position.coords.latitude;
	geolong = position.coords.longitude;
	set_location_on_update();	
	add_twitter_places();
}

function error(msg) {
	located = false;
}

function get_location(){
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(success, error);
	}
	else {
		error('not supported');
	}
}

function set_location_on_update(){
	$('#update_geolat').val(geolat);
	$('#update_geolong').val(geolong);
	$('#visible_lat').html(geolat);
	$('#visible_long').html(geolong);
}

function add_twitter_places() {
var req = $.ajax({ url: "/tgeo.json",
				 					 data: "lat=" + geolat + "&long=" + geolong,
									 success: function(data) {
											$('#update_twitterplace_id').append($("<option></option").attr("value","").text("----------"));
											$.each(data["result"]["places"], function(key, value)
											{   
											     $('#update_twitterplace_id').
											          append($("<option></option>").
											          attr("value",value["id"]).
											          text(value["name"])); 
											});
									 }
					});
}

window.onload = function(){
	get_location();
}