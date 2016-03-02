// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require turbolinks
//= require_tree .
var ready;

ready = function(){
	$('#signup').click(function(){
		window.location.assign('/signup');
	});
	$('#login').click(function(){
		window.location.assign('/login');
	});
	$('.center-form').hide();
	$('.screen').hide();
	$('#image_upload').change(function(){
		readURL(this);
		$('#preview-box').css({display:"block"});
		$('#post-btn').attr("disabled",false);
	});

	$('textarea').bind('input propertychange', function() {
		$('.character-number').html((140 - $(this).val().length) + ' characters left');
		$('#post-btn').attr("disabled",true);

		if(this.value.length){
			$('#post-btn').attr("disabled",false);
		}
	});

	$('#search-field').bind('input propertychange',function(){
		$('#search-form').submit();
		$('#home-search-preloader').show();
		$('#user-search-preloader').show();
		$('#results-list').hide();
		if($('#search-field').val().length != 0){
			$('#results-list').show();
		}
	});
	$('#search-field').focus(function(){
		if($('#search-field').val().length != 0){
			$('#results-list').show();
		}
	});
	$('#search-field').focusout(function(){
		if($('#results-list .result-got'+':hover').length){
			return;
		}
		$('#results-list').hide();
	});
	$('#change-password-btn').on('click',function(){
		console.log("change pressed!");
		$('#change-password-tag').addClass("active");
		$('#edit-profile-tag').removeClass("active");
		$('#change-password').css({display:"block"});
		$('#edit-profile').css({display:"none"});

	});
	$('#edit-profile-btn').on('click',function(){
		console.log("edit pressed!");
		$('#edit-profile-tag').addClass("active");
		$('#change-password-tag').removeClass("active");
		$('#change-password').css({display:"none"});
		$('#edit-profile').css({display:"block"});

	});
	$('#form-for-follow').submit(function(){
		console.log("get hide!");
		$('#follow-form').hide();
		$('#user-preloader').css({display:"inline-block"});

	});
	$('#form-for-unfollow').submit(function(){
		console.log("get hide!");
		$('#follow-form').hide();
		$('#user-preloader').css({display:"inline-block"});

	});

	//pop up form to edit avatar
	$('#avatar-edit').on('click',function(){
		$('#shadow-layer').show();
	});
	$('#avatar-edit-sm').on('click',function(){
		$('#shadow-layer').show();
	});
	//hide mask layer when click shadow
	$('#shadow-layer').on('click',function(){
		$('#shadow-layer').hide();
	});
	$('#avatar-edit-container').on('click',function(e){
		e.stopPropagation();
	});
	$('#avatar-edit-container-sm').on('click',function(e){
		e.stopPropagation();
	});
	$('.avatar-cancel-btn').on('click',function(){
		$('#shadow-layer').hide();
	});


	$( document ).ajaxComplete(function( event,request, settings ) {
		$('#follow-form').show();
		$('#user-preloader').css({display:"none"});
		$('#form-for-follow').submit(function(){
			console.log("get hide!");
			$('#follow-form').hide();
			$('#user-preloader').css({display:"inline-block"});

		});
		$('#form-for-unfollow').submit(function(){
			console.log("get hide!");
			$('#follow-form').hide();
			$('#user-preloader').css({display:"inline-block"});

		});
	});
	//use to load the post automaticaly when scroll to the bottom
	if(window.location.pathname == "/"){
		$(window).scroll(function() {
			if($(window).scrollTop() + $(window).height() == $(document).height()) {
				var last = $('.post').last().attr('data-id');
				$('#home-preloader').show();
				// console.log("######################"+last);
				$.ajax({
		            // make a get request to the server
		            type: "GET",
		            // get the url from the href attribute of our link
		            url: window.location.href,
		            // send the last id to our rails app
		            data: {
		            	id: last
		            },
		            // the response will be a script
		            dataType: "script",

		            // upon success 
		            success: function () {
		            	$('#home-preloader').hide();
		            }
		        });

			}
		});
	}
	$('#avatar-upload-field').change(function(){
		// var form = $('#avatar-upload-field')[0];
		// var formData = new FormData(form);
		// $.ajax({
		// 	type:"PUT",


		// 	url:$(this).attr('action'),
		// 	data: formData,

		// 	contentType: false,
  //   		processData: false,
		// 	dataType: "script",
		// });
		// $('#avatar-upload-field').submit();
		// $('#avatar-fuck').attr('src','http://www.kidostore.com/images/uploads/P-SAM-rocket-blk.jpg');
		// console.log("hey!");
		// $('#followers').html('10000000');
		$('#shadow-layer').hide();
		$('#avatar-preloader').show();
		$('#avatar-preloader-sm').show();
		$(this).submit();

	});
	$('#avatar-upload-field-sm').change(function(){
		$('#shadow-layer').hide();
		$('#avatar-preloader').show();
		$('#avatar-preloader-sm').show();
		$(this).submit();
	});
	
};
$(window).load(function(){
	$('.screen').hide().fadeIn(1200,function(){
		$('.center-form').fadeIn(500);
	});
	

});
function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();

		reader.onload = function (e) {
			$('#uploaded_image').attr('src', e.target.result);
		}

		reader.readAsDataURL(input.files[0]);
	}
}
$(document).ready(ready);
$(document).on('page:load',ready);
