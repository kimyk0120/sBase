<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>트렌드 코디 추천 - Genie Shopping</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<link rel="stylesheet" href="/src/css/style.css" type="text/css" />
<script type="text/javascript" src="/src/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/src/js/font-load.js"></script>
<script type="text/javascript" src="/src/js/voiceCommend.js"></script>
<style type="text/css">
	img{height: 100%;}
</style>
</head>
<body>
<input type="hidden" value="${userKey }" id="userKey">
<input type="hidden" value="${deviceId }" id="deviceId">
<input type="hidden" value="${deviceType }" id="deviceType">
<input type="hidden" value="${reCommendType }" id="reCommendType">
<input type="hidden" value="${reCommendVer }" id="reCommendVer">
<div id="wrap">

	<div id="wrap-detail" class="pick5">

		<div class="head-block">

			<h1><img src="/src/images/logo.png" alt="Genie Shopping"></h1>

			<p class="t-exp">번호를 말하거나(1번) 리모콘으로 생각하는 스타일을 선택해 주세요.</p>

		</div><!-- // head-block -->

		<div class="p-list-block thumb-m">

			<ul class="clearfix">
				<li>
					<dl>
						<!-- <dt>
							<span class="t-num">1</span>
						</dt> -->
						<dd class="thumb"><img src="${productList[0].imgUrl }"></dd>
					</dl>
					<!-- <a href="#" class="btn-blank"></a>상품상세 링크(이하 동일) -->
				</li>
				<li>
					<dl>
						<!-- <dt>
							<span class="t-num">2</span>
						</dt> -->
						<dd class="thumb"><img src="${productList[1].imgUrl }" ></dd>
					</dl>
					<!-- <a href="#" class="btn-blank"></a> -->
				</li>
				<li>
					<dl>
						<!-- <dt>
							<span class="t-num">3</span>
						</dt> -->
						<dd class="thumb"><img src="${productList[2].imgUrl }" ></dd>
					</dl>
					<!-- <a href="#" class="btn-blank"></a> -->
				</li>
				<li>
					<dl>
						<dt>
							<span class="t-num">1</span>
						</dt>
						<dd class="thumb"><img src="${productList[3].imgUrl }" ></dd>
					</dl>
					<a class="btn-blank" data-index="1" tabindex="0" id="${productList[3].productId }"></a>
				</li>
				<li>
					<dl>
						<dt>
							<span class="t-num">2</span>
						</dt>
						<dd class="thumb"><img src="${productList[4].imgUrl }"></dd>
					</dl>
					<a class="btn-blank" data-index="2" tabindex="1"  id="${productList[4].productId }"></a>
				</li>
			</ul>

		</div><!-- // p-list-block -->


	</div><!--// wrap-detail -->
</div><!--// wrap -->
<script type="text/javascript">

		
	//상품선택시 - 리모콘 선택시
	$(document).on("click","#wrap-detail .p-list-block li a",function(){
		
		var prodId = $(this).attr("id");
		var deviceId = $("#deviceId").val();
		var userKey = $("#userKey").val();
		var reCommendVer = $("#reCommendVer").val();
		var reCommendType = $("#reCommendType").val();
		var deviceType = $("#deviceType").val();
		
		location.href = "recommendDetail.do?prodId="+prodId+"&deviceId="+deviceId+"&userKey="+userKey+"&reCommendVer="+reCommendVer+"&reCommendType="+reCommendType+"&deviceType="+deviceType;
	})
		
	
	// 상품선택시 - 보이스 선택시
	function goDetail(tapindex){
		
		var selectObj = $("a");
		var prodId;
		var selectObjLength = selectObj.length;
		var deviceId = $("#deviceId").val();
		var userKey = $("#userKey").val();
		var reCommendVer = $("#reCommendVer").val();
		var reCommendType = $("#reCommendType").val();
		var deviceType = $("#deviceType").val();
		
		//console.log(selectObjLength);
		
		if(tapindex > selectObjLength){
			
			window.GenieShopping.sendTTS("해당하는 번호가 없습니다. 번호를 다시 말씀해 주세요.");
			return false;
		}
		
		$(selectObj).each(function(index){
			var selDindex = $(this).attr("data-index");
			if(selDindex == tapindex){
				prodId = $(this).attr("id");
			}
		})
		//console.log("prodId : " + prodId)
		location.href = "recommendDetail.do?prodId="+prodId+"&deviceId="+deviceId+"&userKey="+userKey+"&reCommendVer="+reCommendVer+"&reCommendType="+reCommendType+"&deviceType="+deviceType;
	};
	

</script>
</body>
</html>