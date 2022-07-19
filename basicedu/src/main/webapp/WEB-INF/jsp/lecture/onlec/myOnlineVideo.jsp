<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ROOT" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="/resources/css/onlec_mylec.css">
<script src="/resources/js/review.js"></script>
<script src="/resources/js/chap_box.js"></script>
<script src="/resources/js/add_my_on.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/video.js/7.8.1/video.min.js"></script>

<script>

	$(function(){
		$('.reCancle').click(function(){
			$('.video_list').css('display','none');
		});
	});
</script>

<script>
	$(function(){
		var msg = $('#msgId').val();
		if(msg != null && msg !=""){
			alert(msg);
			location.href="/mypage/online/onlecmgList";
		}
	});
</script>


		<input type="hidden" value="${msg }" id="msgId"/>

		<ul class="lecture_ch clearfix">
          <a href="/mypage/offline/offlineMylecture">
          <li class="lecture_ch_li">오프라인</li></a>
          <a href="/mypage/online/myOnlineClass"><li class="lecture_ch_li mg_on">온라인</li></a>
        </ul>

        <div class="onlec_mg_list">

          <h3 class="title">&rtrif;&nbsp;강의 플레이</h3>

          <div class="myClass_list">

            <div class="review_modal video_list">

              <h4 class="review_title">클래스 영상 목록</h4>
              <ol class="ollist">
			  <c:forEach var="result" items="${videos}" varStatus="status">
                <li style="background-color:#000;margin-bottom: 5px;">
                <a href="/mypage/online/myOnlineVideo?onlineLectureNo=${result.onlineLectureNo}&videoNo=${result.videoNo}&nowVideo=${status.count}&onlineOrderNo=${onlineOrderNo}"
                style="color:#fff;">${status.count }강. ${result.videoName }</a></li>
              </c:forEach>

              </ol>
              <div class="review_btns">
                <input type="button" name="" value="닫기" class="btns_btn reCancle">
              </div>

            </div>

            <table class="chap_table play_table">
              <tr>
                <td class="chap_box">
                  <h3 class="chap_title">${nowVideo }강. ${video.videoName }</h3>
                  <div class="chap_cont_video">

                    <video id="myVideo" width="840px" controls >
                    	<source src="${ROOT}/mypage/online/player/${video.videoFile }" type="video/mp4" preload="auto">
                    </video>

                    <div class="detail_td_div">
                    	<p style="margin-bottom:30px; line-height:1.5;">${video.videoInfo }</p>

                    	<c:if test="${nowVideo >1}">
                    	  <c:set var="prv" value="/mypage/online/myOnlineVideo?onlineLectureNo=${video.onlineLectureNo}&videoNo=${video.videoNo-1}&nowVideo=${nowVideo-1}&onlineOrderNo=${onlineOrderNo}"/>
                    	</c:if>

                    	<c:if test="${nowVideo <= 1}">
                    		<script>
                    			$(function(){
                        			$('#prvBtn').click(function(){
                        				alert("이전 강의가 없습니다.");
                            		});
                        		});

                    		</script>
                    	</c:if>

                    	<c:if test="${nowVideo <  videoQty}">
                    	  <c:set var="nxt" value="/mypage/online/myOnlineVideo?onlineLectureNo=${video.onlineLectureNo}&videoNo=${video.videoNo+1}&nowVideo=${nowVideo+1}&onlineOrderNo=${onlineOrderNo}"/>
                    	</c:if>

                    	<c:if test="${nowVideo >= videoQty}">
                    		<script>
                    		$(function(){
                    			$('#nxtBtn').click(function(){
                    				alert("다음 강의가 없습니다.");
                        		});
                    		});

                    		</script>
                    	</c:if>


                    	<a href="${prv}" id="prvBtn"><input type="button" name="" value="&ltrif; 이전강의" class="detail_btn_"></a>
                      	<a href="${nxt}" id="nxtBtn"><input type="button" name="" value="다음강의 &rtrif;" class="detail_btn"></a>
                    </div>
                  </div>


                </td>
              </tr>
              <tr>
                <td class="golist"><a href="#" class="golist_a">클래스 영상 목록</a></td>
              </tr>

            </table>


          </div>






</div>



<script>

window.onload = function(){

	$(function(){

		var duration;
		var current;
		var player = document.getElementById("myVideo");

		function dur() {
			duration = player.duration;
			console.log(duration);
			return duration;
		}

		function cur() {
			current = player.currentTime;
			console.log(current);
			return current;
		}

		setTimeout(dur, 5000);
		setInterval(cur, 10000);



		var allData = {

				"onlineLectureNo": "${video.onlineLectureNo}",
				"nowVideo": "${video.videoNo}",
				"onlineOrderNo":"${onlineOrderNo}",
				"duration": dur,
				"current": cur
		};

		function goRun(){

			 $.ajax({
			        url:"./runtime",
			        type:'GET',
			        data: allData,
			        dataType: "text",


			      //데이터 전송이 완료되면 출력되는 메시지
			        success:function(data){
				        console.log(data);


			        },

			       //에러가 발생되면 출력되는 메시지

			        error:function(jqXHR, textStatus, errorThrown){
			            console.log("에러 발생~~ \n" + textStatus + " : " + errorThrown);

			        }
			    });

		}

		setInterval(goRun, 11000);


	});


}



</script>


