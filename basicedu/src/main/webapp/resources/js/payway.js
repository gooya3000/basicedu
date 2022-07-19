$(function(){


  $('.onlec_apply_name_3').click(function(){
    $(this).toggleClass('choice');
  });

  var nowPoint = $('#nowPoint').val();
  var usePoint = $('#usePoint').val();
  var lecPrice = $('#lecPrice').val();
  var finalPrice = lecPrice.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  console.log(finalPrice);
  var totalPrice;

  $('#finalPrice').text(finalPrice+"원");

  $('.point_btn').click(function(){

	  $('#finalPrice').text(finalPrice+"원");
	  $('#totalPrice').val(lecPrice);

	  usePoint = parseInt($('#usePoint').val());
	  console.log(usePoint);
	  console.log(finalPrice);

	  if (usePoint == 0) {
		  alert('사용할 포인트를 입력해주세요.');
		  $('#totalPrice').val(lecPrice);
		  $('#realUsePoint').val(0);

	  }else if(usePoint>nowPoint){

		  alert('사용 가능한 포인트는 '+nowPoint+"P입니다.");
		  usePoint = 0;
		  $('#usePoint').val(usePoint);
		  $('#finalPrice').text(lecPrice+"원");
		  $('#totalPrice').val(lecPrice);
		  $('#realUsePoint').val(usePoint);

	  }else if(usePoint<=nowPoint){

		  function comma(str) {
			    str = String(str);
			    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			}
		  afterPrice = lecPrice-usePoint;

		  $('#totalPrice').val(lecPrice);

		  afterfinalPrice = comma(afterPrice);

		  $('#finalPrice').text(afterfinalPrice+"원");

		  $('#realUsePoint').val(usePoint);

	  }else{

		  alert('사용할 포인트를 입력해주세요.');
		  $('#totalPrice').val(lecPrice);
		  console.log(lecPrice);

	  }


  });


});
