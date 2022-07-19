$(function(){
  $('.onlec_select').change(function(){

    var qty = this.value;
    var mtQty = parseInt(qty)+1;
    var max = 5;

    // 선택한 옵션 만큼 슬라이드 다운 & required 추가
    for (var i = 2; i <= qty ; i++) {
    	$('.box'+i).slideDown(500);
    	$('.video_input'+i).attr('required',true);
    	$('.textArVideo'+i).attr('required',true);
      	$('.videoFile'+i).attr('required',true);

	}

    // 선택한 옵션보다 큰 것은 슬라이드 업 & required 삭제
    for (var i = mtQty; i <= max; i++) {
    	$('.box'+i).slideUp(300);
    	$('.video_input'+i).attr('required',false);
    	$('.textArVideo'+i).attr('required',false);
      	$('.videoFile'+i).attr('required',false);
	}



  });





});


