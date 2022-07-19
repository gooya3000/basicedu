$(function(){

  $('.review_regi').click(function(){
    $(this).parent().prev().prev('.review_modal').css('display','block');
  });

  $('.reCancle').click(function(){
    $(this).parent().parent().parent('.review_modal').css('display','none');
  });


  $('.golist_a').click(function(){
    $(this).parent().parent().parent().parent().prev('.review_modal').css('display','block');
  });

  $('.detail_review_regi').click(function(){
	  $(this).parent().next('.review_modal').css('display','block');

  });

  $('.reCan').click(function(){
	  $(this).parent().parent().parent('.review_modal').css('display','none');

  });

  $('.detail_btn_').click(function(){
	  $(this).parent().next().next('.review_modal2').css('display','block');

  });

  $('.close').click(function(){
	  $(this).parent().parent().parent().parent().parent('.review_modal2').css('display','none');

  });


});
