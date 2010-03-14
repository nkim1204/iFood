/*
	This file contains the necessary code to get Colorbox rockin'!
	(C) 2009 Nicholas Young, All Rights Reserved
	Based on the Colorbox Lightbox for jQuery 1.3 by Jack Moore (http://colorpowered.com/colorbox).
	Please don't use without attribution - that isn't cool... Open-source is about giving!
*/

$(document).ready(function() {
	$(".iframe").colorbox({width:"80%", height:"80%", iframe:true});
	$(".colorbox").colorbox();
});