$(function(){

	$('#imgFile').change(function(){
		var ext = $('#imgFile').val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
		     alert('등록 할수 없는 파일입니다.');
		     $("#imgFile").val(""); // input file 파일명을 다시 지워준다.
		     return;
		  }
	});

	$('#videoFile').change(function(){
		var ext = $('#videoFile').val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['mp4']) == -1) {
		     alert('등록 할수 없는 파일입니다.');
		     $("#videoFile").val(""); // input file 파일명을 다시 지워준다.
		     return;
		  }
	});

	$('.videoFile').change(function(){
		var ext = $('.videoFile').val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['mp4']) == -1) {
		     alert('등록 할수 없는 파일입니다.');
		     $(".videoFile").val(""); // input file 파일명을 다시 지워준다.
		     return;
		  }
	});

	$('input[name=price]').change(function(){
		var price = $(this).val();
		if (price > 9999999) {
			alert('입력할 수 없는 값입니다.');
		    $(this).val("");
		}
	});

	$('input[name=onlineLectureName]').change(function(){
		var onlineLectureName = $(this).val().trim();
		if (onlineLectureName == '' || onlineLectureName == null) {
			alert('클래스명을 입력해주세요.');
			$(this).val("");
			$(this).focus();
		}
	});

	$('input[name=videoName]').change(function(){
		var videoName = $(this).val().trim();
		if (videoName == '' || videoName == null) {
			alert('영상제목을 입력해주세요.');
			$(this).val("");
			$(this).focus();
		}
	});

	$('input[type=file]').change(function(){
		var fileName = $(this).val();
		if (fileName != "") {
			$(this).next('.uploadCancle').css('display','inline');
		}
	});

	$('.uploadCancle').click(function(){
		$(this).prev('input[type=file]').val('');
		$(this).css('display','none');
	});





});