$(function(){



			$('#textAr').on('keyup', function() {

				if($(this).val().length > 200) {

					alert("글자수는 200자 이내로 제한됩니다.");
					$(this).val($(this).val().substring(0, 200));

				}

			});

			$('.textAr').on('keyup', function() {

				if($(this).val().length > 200) {

					alert("글자수는 200자 이내로 제한됩니다.");
					$(this).val($(this).val().substring(0, 200));

				}

			});


			$('#textArVideo').on('keyup', function() {

				if($(this).val().length > 200) {

					alert("글자수는 200자 이내로 제한됩니다.");
					$(this).val($(this).val().substring(0, 200));

				}

			});

			$('.textArVideo').on('keyup', function() {

				if($(this).val().length > 200) {

					alert("글자수는 200자 이내로 제한됩니다.");
					$(this).val($(this).val().substring(0, 200));

				}

			});

			$('#textArVideo').change(function(){
				var textArVideo = $(this).val().trim();
				if (textArVideo == '' || textArVideo == null) {
					alert('영상내용을 입력해주세요.');
					$(this).val("");

				}
			});

			$('.textArVideo').change(function(){
				var textArVideo = $(this).val().trim();
				if (textArVideo == '' || textArVideo == null) {
					alert('영상내용을 입력해주세요.');
					$(this).val("");

				}
			});

			$(".modiFiles").click(function(){

				alert("파일 업로드 시 기존 파일은 삭제됩니다.");

			});



});