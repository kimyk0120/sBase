<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>트렌드 VOD - Genie Shopping</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<link rel="stylesheet" href="/src/css/style.css" type="text/css" />
<script type="text/javascript" src="/src/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/src/js/font-load.js"></script>
<script type="text/javascript" src="/src/js/voiceCommend.js"></script>
<style type="text/css">
	#wrap-detail.video .p-list-block.thumb-m li{text-align: center;}
	button:last-child{margin-top: 1em;}
</style>
</head>

<body>

<input type="hidden" id="deviceId" value="${deviceId }">
<input type="hidden" id="deviceType" value="${deviceType }">
<input type="hidden" id="userKey" value="${userKey }">
<input type="hidden" id="reCommendType" value="${reCommendType }">
<input type="hidden" id="reCommendVer" value="${reCommendVer }">
<div id="wrap">

	<div id="wrap-detail" class="video">

		<div class="head-block">

			<h1><img src="/src/images/logo.png" alt="Genie Shopping"></h1>

			<p class="t-exp">번호를 말하거나(1번) 리모콘으로 생각하는 스타일을 선택해 주세요.</p>

		</div><!-- // head-block -->

		<div class="p-list-block thumb-m">

			<ul class="clearfix">
				<li>
					<div class="thumb-img">
						<img src="/src/images/screenshot1.png"  style="width: 568px;height: 320px;">
					</div>
					<!-- <div class="video-block">
						<video width="568" height="320">
							<source src="/src/images/temp_mov_bbb.mp4" type="video/mp4">
						</video>
					</div> 비디오 영역-->
					<a class="btn-blank" tabindex="0" url="http://220.85.93.81:8080/data/video/trend_shift_cut.mp4"></a><!-- 상품상세 링크(이하 동일) -->
					<span class="btn-play"><span class="t-hidden">동영상 재생</span></span><!-- 동영상 플레이 이미지 : 필요없으면 삭제 -->
					<button type="button" class="goProdDetailBtn" tabindex="2" id="00000002">상품 보기</button>
				</li>
				<li>
					<div class="thumb-img">
						<img src="/src/images/screenshot2.png" style="width: 568px;height: 320px;">
					</div>
					<!-- <div class="video-block">
						<video width="568" height="320">
							<source src="/src/images/temp_mov_bbb.mp4" type="video/mp4">
						</video>
					</div> 비디오 영역-->
					<a class="btn-blank" tabindex="1" url="http://220.85.93.81:8080/data/video/trend_shirtdress_cut.mp4"></a><!-- 상품상세 링크(이하 동일) -->
					<span class="btn-play"><span class="t-hidden">동영상 재생</span></span><!-- 동영상 플레이 이미지 : 필요없으면 삭제 -->
					<button type="button" class="goProdDetailBtn" tabindex="3" id="00000003">>상품 보기</button>
				</li>
			</ul>

		</div><!-- // p-list-block -->
	</div><!--// wrap-detail -->

</div><!--// wrap -->

<script type="text/javascript">

	// 영상 선택시
	$("#wrap-detail.video .p-list-block.thumb-m li").on("click",function(){
		var url = $(this).find("a").attr("url");
		console.log("url : " + url );
		
		GenieShopping.watchVOD(url);
	});

	// 영상 선택시(음성)
	function goDetail(tapindex){
		
		var selectObj = $("#wrap-detail.video .p-list-block.thumb-m li");
		var selectObjLength = selectObj.length;
		
		
		if(tapindex > selectObjLength || tapindex == 0) {
			window.GenieShopping.sendTTS("해당하는 번호가 없습니다. 번호를 다시 말씀해 주세요.");
			return false;
		}
		
		$(selectObj).each(function(index){
			var selDindex = $(this).find("a").attr("tabindex");
			
			if( (selDindex + 1) == tapindex){
				
				var url = $(this).find("a").attr("url");
				console.log("url : " + url );
				
				GenieShopping.watchVOD(url);
			}
		})
	};
	
	
	// 상품보기 선택시
	$(".goProdDetailBtn").on("click",function(){
		
		var prodId = $(this).attr("id");
		var deviceId = $("#deviceId").val();
		var deviceType = $("#deviceType").val();
		var userKey = $("#userKey").val();
		var reCommendType = $("#reCommendType").val();
		var reCommendVer = $("#reCommendVer").val();
		
		location.href = "recommendDetail.do?prodId="+prodId+"&deviceId="+deviceId+"&deviceType="+deviceType+"&userKey="+userKey+"&reCommendType="+reCommendType+"&reCommendVer="+reCommendVer;
		
	})
	
</script>


<!-- "00000002";"";"변라영";"원피스";"http://220.85.93.81:8080/data/video/trend_shift_cut.mp4"
"00000003";"";"도봉순";"원피스";"http://220.85.93.81:8080/data/video/trend_shirtdress_cut.mp4" -->

</body>
</html>