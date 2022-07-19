$(function(){

  // $('.chap_title').click(function(){
  //   $(this).next().slideDown(300);
  //   $(this).children('.arrow').css('display','none');
  //   $(this).children('.arrow_up').css('display','block');
  // });
  $('.chap_title').click(function(){
    $(this).next().toggleClass('open');
    $(this).children('.arrow').toggleClass('open');
  $(this).children('.arrow_up').toggleClass('open');
  });

});
