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
	$('.side-page').on('scroll',function(){
		if($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight && !$('.side-post-container').hasClass("loading")) {
			var last = $(this).find('.post').last().attr('data-id');
			$('#side-page-preloader').show();
			$('.side-post-container').addClass("loading");
			$.ajax({
			            // make a get request to the server
			            type: "GET",
			            // get the url from the href attribute of our link
			            url: "/users/"+$(this).find('.user-profile').attr('id'),
			            // send the last id to our rails app
			            data: {
			            	last: last
			            },
			            // the response will be a script
			            dataType: "script",

			            // upon success 
			            success: function () {
			            	$('.side-post-container').removeClass("loading");
			            	$('#side-page-preloader').hide();
			            }
			        });

		}
	});
	$('#menu-switch').on('click',function(){
		if(!$('#menu').hasClass('unfoldered')){
			$('#menu').show();
			$('#menu').addClass('unfoldered')
		}
		else{
			$('#menu').hide();
			$('#menu').removeClass('unfoldered')
		}

	});
	$(document).click(function(e){
		// $('#menu').hide();
		if(e.target.id == 'menu-switch') return;
		if($('#menu').hasClass('unfoldered')){
			$('#menu').hide();
			$('#menu').removeClass('unfoldered');
		}
	});

	$('#image_upload').change(function(){
		var size_in_megabytes = this.files[0].size/1024/1024;
		if (size_in_megabytes > 5) {
			alert('Maximum file size is 5MB. Please choose a smaller file.');
		}
		else{
		readURL(this);
			$('#preview-box').css({display:"block"});
			$('#post-btn').attr("disabled",false);
		}
	});

	$('#remove-image').on('click',function(){
		$('#image_upload').val('');
		$('#preview-box').css({display:"none"});
		if(!$('#post-text-area').val()){
			$('#post-btn').attr("disabled",true);
		}

	});

	$('#post-text-area').bind('input propertychange', function() {
		$('.character-number').html('<p style="font-family: Papyrus,fantasy">' + (140 - $(this).val().length) + '</p>');
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
		// console.log("change pressed!");
		$('#change-password-tag').addClass("active");
		$('#edit-profile-tag').removeClass("active");
		$('#change-password').css({display:"block"});
		$('#edit-profile').css({display:"none"});

	});
	$('#edit-profile-btn').on('click',function(){
		// console.log("edit pressed!");
		$('#edit-profile-tag').addClass("active");
		$('#change-password-tag').removeClass("active");
		$('#change-password').css({display:"none"});
		$('#edit-profile').css({display:"block"});

	});
	$('#form-for-follow').submit(function(){
		// console.log("get hide!");
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
		$('#side-user-profile').hide('slide',{direction:"right"},function(){
			$('#profile-content').empty();
			$('#profile-preloader').show();
		});
		$('#side-user-profile').removeClass('opened');
		$('#shadow-layer').hide();
		$('body').css("overflow","auto");
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
	$(window).on('scroll',function(){
		if(window.location.pathname === "/" || $('.likes-page').length){
			if($(window).scrollTop() + $(window).height() == $(document).height() && !$('.post-container').hasClass("loading")) {
				var last = $('.post').last().attr('data-id');
				$('#home-preloader').show();
					// console.log("######################"+last);
					$('.post-container').addClass("loading");
					$.ajax({
			            // make a get request to the server
			            type: "GET",
			            // get the url from the href attribute of our link
			            url: window.location.href,
			            // send the last id to our rails app
			            data: {
			            	last: last
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
			}
	});
	// $(window).scroll(function(e) {

	// 	// console.log(window.location.pathname);

	// 	if(window.location.pathname === "/" || $('.likes-page').length){
	// 		if($(window).scrollTop() + $(window).height() == $(document).height() && !$('.post-container').hasClass("loading")) {
	// 			var last = $('.post').last().attr('data-id');
	// 			$('#home-preloader').show();
	// 				console.log("######################"+last);
	// 				$('.post-container').addClass("loading");
	// 				$.ajax({
	// 		            // make a get request to the server
	// 		            type: "GET",
	// 		            // get the url from the href attribute of our link
	// 		            url: window.location.href,
	// 		            // send the last id to our rails app
	// 		            data: {
	// 		            	last: last
	// 		            },
	// 		            // the response will be a script
	// 		            dataType: "script",

	// 		            // upon success 
	// 		            success: function () {
	// 		            	$('#home-preloader').hide();
	// 		            	$('.post-container').removeClass("loading");
	// 		            }
	// 		        });

	// 			}
	// 		}
	// 	});

	
	//add comment
	// $('.comment-btn').on('click',);
	// $('#avatar-upload-field').change(function(){
	// 	console.log("aa!");
	// 	var size_in_megabytes = this.files[0].size/1024/1024;
	// 	if (size_in_megabytes > 5) {
	// 		alert('Maximum file size is 5MB. Please choose a smaller file.');
	// 	}
	// 	else{
	// 		console.log("submit!");
	// 		$(this).submit();
	// 	}

	// });
	// $('#following-btn').on('click',function(){
	// 	$('#following-tag').addClass("active");
	// 	$('#follower-tag').removeClass("active");
	// 	$('#following-container').css({display:"block"});
	// 	$('#follower-container').css({display:"none"});

	// });
	// $('#follower-btn').on('click',function(){
	// 	$('#follower-tag').addClass("active");
	// 	$('#following-tag').removeClass("active");
	// 	$('#following-container').css({display:"none"});
	// 	$('#follower-container').css({display:"block"});

	// });

};


$(window).load(function(){
	// console.log("fadein!");
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
		$(this).closest(".post").next().hide();
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
};
delete_comment_submit = function(){
	$(this).closest(".comment-container").prev().removeClass("unfoldered");
	// console.log($(this).closest(".comment-container").prev());
	$(this).closest(".comment-container").prev().next().empty();
};
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
//like btn
like_onClick=function(){
	// $(this).find(".like-form").submit();
	// console.log("wtf");
	$(this).prev().submit();
};
//dislike btn
dislike_onClick = function(){
	// $(this)
	$(this).prev().submit();
};

//jump to user page
jump_to_user_page = function(){

	// $(this).closest('.post').find('.overview').fadeOut();
	//show in order
	
	$('body').css("overflow","hidden");
	$('#shadow-layer').show();
	$('#side-user-profile').show('slide',{direction:"right"});
};
result_click = function(){
	// console.log("click !");
	$('#results-list').hide();
	$.ajax({
			            // make a get request to the server
			            type: "GET",
			            // get the url from the href attribute of our link
			            url: "/users/"+$(this).attr('id'),			      
			            // the response will be a script
			            dataType: "script",


			        });
}
avatar_change = function(){
	var size_in_megabytes = this.files[0].size/1024/1024;
	if (size_in_megabytes > 5) {
		alert('Maximum file size is 5MB. Please choose a smaller file.');
	}
	else{
		if (this.files && this.files[0]) {
			var reader = new FileReader();

			reader.onload = function (e) {
				$('#profile-avatar').attr('src', e.target.result);
			}

			reader.readAsDataURL(this.files[0]);
		}
	}

};
header_change = function(){
	var size_in_megabytes = this.files[0].size/1024/1024;
	if (size_in_megabytes > 5) {
		alert('Maximum file size is 5MB. Please choose a smaller file.');
	}
	else{
		if (this.files && this.files[0]) {
			var reader = new FileReader();
			reader.onload = function (e) {
				$('#profile-header').css('background-image', 'url('+e.target.result+")");
			}

			reader.readAsDataURL(this.files[0]);
		}
	}

};

follow = function(){
	// $(this).closest('li').find('form').submit();
	// console.log($(this).closest('ul').find('li').last().attr('id'));
	$.ajax({
				type: "POST",
				url: '/relationships',
				data: {
					radar:true,
					following_id:$(this).closest('li').attr('id').substring(12),
					last:$(this).closest('ul').find('li').last().attr('id')
				},
				dataType: "script",
				

			});
};
$(document).ready(ready);
$(document).on('page:load',ready);
$(document).on('click','.like-btn',like_onClick);
$(document).on('click','.dislike-btn',dislike_onClick);
$(document).on('click','.comment-btn',comment_onClick);
$(document).on('click','.load-comment',load_comment);
$(document).on('submit','.form-for-comment',comment_submit);
$(document).on('submit','.form-for-reply',reply_submit);
$(document).on('click','.link-for-delete',delete_comment_submit);
$(document).on('click','.reply',reply);
$(document).on('click','.user-link',jump_to_user_page);
$(document).on('click','.result-got',result_click);
$(document).on('change','#avatar-upload-field',avatar_change);
$(document).on('change','#header-upload-field',header_change);
$(document).on("click",'.follow-plus',follow);

// $(document).on('scroll','.side-page',side_page_scroll);

