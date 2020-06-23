// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .
//= require jquery
//= require bootstrap-sprockets
//= require jquery.raty.js

$(function() {
    $('#show-nav').click(function() {
        $('#top-nav-list').fadeIn();
    });
    $('#hide-nav').click(function() {
        $('#top-nav-list').fadeOut()
    })
 });

$(function() {
	$('#show-nav').click(function() {
		$('#nav-list').fadeIn();
	});
	$('#hide-nav').click(function() {
		$('#nav-list').fadeOut()
	})
 });

$(function() {
	$('#show-form').click(function() {
    	$("#review-form").toggle();
	});
});

$(function() {
	$('.form').on('change', '.file', function(event) {
    	var file = event.target.files[0];
        var reader = new FileReader();

    if(file.type.indexOf("image") < 0){
      return false;
    }

    reader.onload = (function(file) {
    	return function(event) {
        $(".preview").empty();

        $(".preview").append($('<img>').attr({
			src: event.target.result,
			width: "200px"
            }));
    	};
    })(file);

    reader.readAsDataURL(file);
	});
});
