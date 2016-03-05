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
	$('.comment-field').bind('input propertychange',function(){
		// $('.post-comment-btn').attr("disabled",true);
		$(this).closest('.comment-edit').find('.post-comment-btn').attr("disabled",true);
		if(this.value.length){
			$(this).closest('.comment-edit').find('.post-comment-btn').attr("disabled",false);
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

	//follow and unfollow
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
			if($(window).scrollTop() + $(window).height() == $(document).height() && !$('.post-container').hasClass("loading")) {
				var last = $('.post').last().attr('data-id');
				$('#home-preloader').show();
				console.log("######################"+last);
				$('.post-container').addClass("loading");
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
		            	$('.post-container').removeClass("loading");
		            }
		        });

			}
		});
	}


	//add comment
	// $('.comment-btn').on('click',);
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
	// $('.reply').on('click',function(){
	// 	if($(this).closest(".row").next().is(":visible")){
	// 		$(this).closest(".row").next().hide();
	// 	}
	// 	else{
	// 		$(this).closest(".row").next().show();
	// 		console.log($(this).closest(".row").next().find(".reply-field"));
	// 		$(this).closest(".row").next().find(".reply-field").focus();
	// 	}

	
	// });
	
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
comment_onClick = function(){
		if($(this).closest(".post").hasClass("unfoldered"))
		{	
			$(this).closest(".post").next().empty();
			$(this).closest(".post").removeClass("unfoldered");
		}	
		else{
			// $(this).closest(".post").addClass("unfoldered");
			// var last = $(this).closest(".post").next().find(".comment").last().attr('data-id');

			// console.log($(this).closest(".post").next().find(".comment-field"));
			$(this).closest(".post").next().next().show();
			var post = $(this).closest(".post").attr('data-id');
			$.ajax({
				type: "GET",
				url: '/comments',
				data: {
					// id: last
					post_id: post
				},
				dataType: "script",
				

			});
		}
	};
load_comment = function(){
 
			var last = $(this).closest(".comment").prev().find(".comment").last().attr('data-id');
			var post = $(this).closest(".comment-container").prev().attr('data-id');
			// console.log(last);
			// console.log(post);
			$.ajax({
				type: "GET",
				url: '/comments',
				data: {
					id: last,
					post_id: post
				},
				dataType: "script",

			});
	
};
reply_submit = function(){
	$(this).closest(".comment-container").prev().removeClass("unfoldered");
	// console.log($(this).closest(".comment-container").prev());
	$(this).closest(".comment-container").prev().next().empty();
}
comment_submit = function(){
	// console.log("wtf");
	$(this).closest(".comment-container").prev().removeClass("unfoldered");
	// console.log($(this).closest(".comment-container").prev());
	$(this).closest(".comment-container").prev().next().empty();
	// console.log($(this).closest(".comment-container").prev().next());
};
reply = function(){
	// console.log('fuc');
	if($(this).closest('.row').next().is(':visible')){
		$(this).closest('.row').next().hide();
	}
	else{
		$(this).closest('.row').next().show();
		$(this).closest(".row").next().find(".reply-field").focus();
	}
};
$(document).ready(ready);
$(document).on('page:load',ready);
$(document).on('click','.comment-btn',comment_onClick);
$(document).on('click','.load-comment',load_comment);
$(document).on('submit','.form-for-comment',comment_submit);
$(document).on('submit','.form-for-reply',reply_submit);
$(document).on('click','.reply',reply);
