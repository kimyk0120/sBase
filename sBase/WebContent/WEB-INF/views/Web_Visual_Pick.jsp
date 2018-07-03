<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<c:choose>
	<c:when test="${depthNo eq 1 }"> <c:set value="4" var="listNo"></c:set> </c:when>
	<c:when test="${depthNo eq 2 }"> <c:set value="6" var="listNo"></c:set> </c:when>
</c:choose>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>비주얼 쇼핑 Pick 4 - Genie Shopping</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<link rel="stylesheet" href="/src/css/style.css" type="text/css" />
<script type="text/javascript" src="/src/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/src/js/font-load.js"></script>
<script type="text/javascript" src="/src/js/voiceCommend.js"></script>
</head>
<body>
<input type="hidden" value="${depthNo}" id="depthNo">
<input type="hidden" value="${userKey}" id="userKey">
<input type="hidden" value="${deviceType}" id="deviceType">
<div id="wrap">
	<div id="wrap-detail" class="pick${listNo}">

		<div class="head-block">
			<h1><img src="/src/images/logo.png" alt="Genie Shopping"></h1>
			<p class="t-exp">번호를 말하거나(1번) 리모콘으로 생각하는 스타일을 선택해 주세요.</p>
		</div><!-- // head-block -->

		<div class="p-list-block thumb-m">
			<ul class="clearfix">
				
				<c:forEach items="${visualList}" var="vl" begin="0" varStatus="status" end="${listNo-1}" >
					<li id="${vl.visualId}" data-index="${status.count}">
						<dl>
							<dt>
								<span class="t-num">${status.count}</span>
							</dt>
							<dd class="thumb"><img src="${vl.visualImgUrl}" style="width: auto; height: 100%;"></dd>
						</dl>
						<a class="btn-blank" tabindex="${status.count}"></a><!-- 상품상세 링크(이하 동일) -->
					</li>
				</c:forEach>
			</ul>
		</div><!-- // p-list-block -->
		
	</div><!--// wrap-detail -->
</div><!--// wrap -->
<script type="text/javascript">
	var userKey = $("#userKey").val();
	var deviceType = $("#deviceType").val();
	
	//TODO 음성선택시 플로우
	
	// 리스트 선택시
	$("#wrap-detail .p-list-block.thumb-m li").on("click",function(){
		var depthNo = parseInt($("#depthNo").val());
		var selId = $(this).attr("id");
		
		if(depthNo == 1){

			depthNo += 1;
			
			/* console.log("depthNo : " + depthNo);
			console.log("selId : " + selId); */ 
			
			location.href = "visualShoppingStep.do?userKey="+userKey+"&deviceType="+deviceType+"&depthNo="+depthNo+"&selId="+selId;
			
		}else if(depthNo == 2){
			
			location.href = "visualShoppingResult.do?userKey="+userKey+"&deviceType="+deviceType+"&depthNo="+depthNo+"&selId="+selId;
		}
	})
	
	
	// 리스트 음성선택시
	function goDetail(tapindex){
		
		var depthNo = parseInt($("#depthNo").val());
		var selectObj = $("#wrap-detail .p-list-block.thumb-m li");
		var selId;
		var selectObjLength = selectObj.length;
		
		//console.log(selectObjLength);
		
		if(tapindex > selectObjLength){
			
			window.GenieShopping.sendTTS("해당하는 번호가 없습니다. 번호를 다시 말씀해 주세요.");
			return false;
		}
		
		$(selectObj).each(function(index){
			var selDindex = $(this).attr("data-index");
			if(selDindex == tapindex){
				selId = $(this).attr("id");
			}
		})
		
		console.log("selId : "+  selId);
		if(depthNo == 1){

			depthNo += 1;
			
			location.href = "visualShoppingStep.do?userKey="+userKey+"&deviceType="+deviceType+"&depthNo="+depthNo+"&selId="+selId;
			
		}else if(depthNo == 2){
			
			location.href = "visualShoppingResult.do?userKey="+userKey+"&deviceType="+deviceType+"&depthNo="+depthNo+"&selId="+selId;
		} 
	};
	
</script>

</body>
</html>