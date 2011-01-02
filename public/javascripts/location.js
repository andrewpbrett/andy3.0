var located = false;
var geolat;
var geolong;

function success(position){
	located = true;
	geolat = position.coords.latitude;
	geolong = position.coords.longitude;
	set_location_on_update();	
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
}

window.onload = function(){
	get_location();
}