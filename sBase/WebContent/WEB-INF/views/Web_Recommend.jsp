<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<!-- 추천 상품별 클래스 구분
			우리집				home
			지니쇼핑 베스트		best
		    나에게 딱		    mine
			자주 구매 상품		favorite
		    카테고리			category -->	
<c:choose>
	<c:when test="${reCommendType eq 'TVSTB'}">
		<c:set var="titleBlockNm" value="home"></c:set>
	</c:when>
	<c:when test="${reCommendType eq 'TVPOP'}">
		<c:set var="titleBlockNm" value="best"></c:set>
	</c:when>
	<c:when test="${reCommendType eq 'TVUSR'}">
		<c:set var="titleBlockNm" value="mine"></c:set>
	</c:when>
	<c:when test="${reCommendType eq 'TVHIGH'}">
		<c:set var="titleBlockNm" value="favorite"></c:set>
	</c:when>
</c:choose>

<!DOCTYPE html>
<html lang="ko">

<head>
<title>상품추천 - Genie Shopping</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<link rel="stylesheet" href="/src/css/style.css" type="text/css" />
<script type="text/javascript" src="/src/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/src/js/font-load.js"></script>
<script type="text/javascript" src="/src/js/voiceCommend.js"></script>

</head>

<body>
<input type="hidden" value="${userKey }" id="userKey">
<input type="hidden" value="${deviceId }" id="deviceId">
<input type="hidden" value="${reCommendType }" id="reCommendType">
<input type="hidden" value="${reCommendVer }" id="reCommendVer">

<div id="wrap">

	<div id="wrap-rec" class="clearfix">
		
										
		<div class="title-block ${titleBlockNm}">
		
			<c:choose>
				<c:when test="${reCommendType eq 'TVSTB'}">
					<h1>
						<p>우리집</p>
						<p>추천상품</p>
					</h1>
			
					<p class="t-exp1">우리가족 구성원의<br>맞춤 상품 추천입니다.</p>
					<p class="t-exp2">추천상품을 더 보고 싶으시면 ‘다음’<br>이라고 말씀해 주세요.</p>
					
				</c:when>
				<c:when test="${reCommendType eq 'TVPOP'}">
					<h1>
						<p>지니쇼핑<br>베스트</p>
						<p>인기상품</p>
					</h1>
		
					<p class="t-exp1">지니쇼핑 베스트<br>인기상품 추천입니다.</p>
					<p class="t-exp2">추천상품을 더 보고 싶으시면 ‘다음’<br>이라고 말씀해 주세요.</p>
		
				</c:when>
				<c:when test="${reCommendType eq 'TVUSR'}">
					<h1>
						<p>나에게 딱</p>
						<p>추천상품</p>
					</h1>
		
					<p class="t-exp1">나에게 딱<br>맞춤 상품 추천입니다.</p>
					<p class="t-exp2">추천상품을 더 보고 싶으시면 ‘다음’<br>이라고 말씀해 주세요.</p>
				</c:when>
				<c:when test="${reCommendType eq 'TVHIGH'}">
					<h1>
						<p>자주 구매<br>상품</p>
						<p>저관여상품</p>
					</h1>
		
					<p class="t-exp1">자주 구매<br>상품 추천입니다.</p>
					<p class="t-exp2">추천상품을 더 보고 싶으시면 ‘다음’<br>이라고 말씀해 주세요.</p>
		
					<!-- <a href="#" class="btn-blank"></a>focus가 필요 없으면 삭제해 주세요. -->
				</c:when>
			</c:choose>
			
		</div><!-- // list-block -->
		
		

		<div class="p-list-block">

			<ul class="clearfix" id="listUl">
			
			<!-- 
				<li>
					<dl>
						<dt>
							<span class="t-num">1</span>
							<span>NS홈쇼핑</span>
							<span>[톰앤래빗][오가게/톰앤래빗]허그OPS/심플 원피스 일립시스 적용 중입니다. 아야어여오요</span>
						</dt>
						<dd>방송중</dd>
						<dd>6,900 원</dd>
						<dd class="thumb"><img src="/src/images/temp_img182.png" alt="NS홈쇼핑 [톰앤래빗][오가게/톰앤래빗]허그OPS/심플 원피스"></dd>
					</dl>
					<a href="#" class="btn-blank"></a>상품상세 링크(이하 동일)
				</li> -->
			</ul>
			
			<!-- 테스트버튼  -->
			 <!-- <button onclick="prevPage();">테스트버튼 이전 </button>
			<button onclick="nextPage();">테스트버튼 다음 </button>    -->
			
		</div><!-- // product-block -->
	</div><!--// wrap-rec -->
</div><!--// wrap -->

<script type="text/javascript">
	
		
	// init
	var startPn = 0; // 상품 시작값
	var endPn = 6; // 상품 끝값, 카운트 리스트
	var listLength = 0; // 리스트 카운트
	var pageNum = 1; // 현재 페이지 번호
	var totalPage = 0; 
	
	if(!!'${productList}'){
		
	    var plL =  '${productList}';
	    
	    // paging test
	   /*  plL = '[';
	    plL	+=	'{"productType":"3  ","productId":"00070018364803","imgUrl":"http://image.gsshop.com/image/18/36/18364803_L1.jpg","productName":"[CJ] 가쓰오 우동 4인분 x 2개(총 8인분)","productCost":"12900","channelName":"GSSHOP","brand":"씨제이","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070024184241","imgUrl":"http://image.gsshop.com/image/24/18/24184241_L1.jpg","productName":"프레 목장 블루베리요구르트 1000ml x 3병","productCost":"27000","channelName":"GSSHOP","brand":"자연다옴","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070021833565","imgUrl":"http://image.gsshop.com/image/21/83/21833565_L1.jpg","productName":"[삼양]삼양라면컵 6입X2개","productCost":"10400","channelName":"GSSHOP","brand":"삼양라면","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070023885755","imgUrl":"http://image.gsshop.com/image/23/88/23885755_L1.jpg","productName":"메이준뉴트리 유기농 퓨어 엑스트라버진 코코넛오일 10병","productCost":"109800","channelName":"GSSHOP","brand":"메이준 뉴트리","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070018364803","imgUrl":"http://image.gsshop.com/image/18/36/18364803_L1.jpg","productName":"[CJ] 가쓰오 우동 4인분 x 2개(총 8인분)","productCost":"12900","channelName":"GSSHOP","brand":"씨제이","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070024184241","imgUrl":"http://image.gsshop.com/image/24/18/24184241_L1.jpg","productName":"프레 목장 블루베리요구르트 1000ml x 3병","productCost":"27000","channelName":"GSSHOP","brand":"자연다옴","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070021833565","imgUrl":"http://image.gsshop.com/image/21/83/21833565_L1.jpg","productName":"[삼양]삼양라면컵 6입X2개","productCost":"10400","channelName":"GSSHOP","brand":"삼양라면","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070023885755","imgUrl":"http://image.gsshop.com/image/23/88/23885755_L1.jpg","productName":"메이준뉴트리 유기농 퓨어 엑스트라버진 코코넛오일 10병","productCost":"109800","channelName":"GSSHOP","brand":"메이준 뉴트리","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"}';
	    plL	+=	',{"productType":"3  ","productId":"00070018364803","imgUrl":"http://image.gsshop.com/image/18/36/18364803_L1.jpg","productName":"[CJ] 가쓰오 우동 4인분 x 2개(총 8인분)","productCost":"12900","channelName":"GSSHOP","brand":"씨제이","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070024184241","imgUrl":"http://image.gsshop.com/image/24/18/24184241_L1.jpg","productName":"프레 목장 블루베리요구르트 1000ml x 3병","productCost":"27000","channelName":"GSSHOP","brand":"자연다옴","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070021833565","imgUrl":"http://image.gsshop.com/image/21/83/21833565_L1.jpg","productName":"[삼양]삼양라면컵 6입X2개","productCost":"10400","channelName":"GSSHOP","brand":"삼양라면","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070023885755","imgUrl":"http://image.gsshop.com/image/23/88/23885755_L1.jpg","productName":"메이준뉴트리 유기농 퓨어 엑스트라버진 코코넛오일 10병","productCost":"109800","channelName":"GSSHOP","brand":"메이준 뉴트리","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070018364803","imgUrl":"http://image.gsshop.com/image/18/36/18364803_L1.jpg","productName":"[CJ] 가쓰오 우동 4인분 x 2개(총 8인분)","productCost":"12900","channelName":"GSSHOP","brand":"씨제이","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070024184241","imgUrl":"http://image.gsshop.com/image/24/18/24184241_L1.jpg","productName":"프레 목장 블루베리요구르트 1000ml x 3병","productCost":"27000","channelName":"GSSHOP","brand":"자연다옴","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070021833565","imgUrl":"http://image.gsshop.com/image/21/83/21833565_L1.jpg","productName":"[삼양]삼양라면컵 6입X2개","productCost":"10400","channelName":"GSSHOP","brand":"삼양라면","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070023885755","imgUrl":"http://image.gsshop.com/image/23/88/23885755_L1.jpg","productName":"메이준뉴트리 유기농 퓨어 엑스트라버진 코코넛오일 10병","productCost":"109800","channelName":"GSSHOP","brand":"메이준 뉴트리","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"}';
	    plL	+=	',{"productType":"3  ","productId":"00070018364803","imgUrl":"http://image.gsshop.com/image/18/36/18364803_L1.jpg","productName":"[CJ] 가쓰오 우동 4인분 x 2개(총 8인분)","productCost":"12900","channelName":"GSSHOP","brand":"씨제이","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070024184241","imgUrl":"http://image.gsshop.com/image/24/18/24184241_L1.jpg","productName":"프레 목장 블루베리요구르트 1000ml x 3병","productCost":"27000","channelName":"GSSHOP","brand":"자연다옴","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070021833565","imgUrl":"http://image.gsshop.com/image/21/83/21833565_L1.jpg","productName":"[삼양]삼양라면컵 6입X2개","productCost":"10400","channelName":"GSSHOP","brand":"삼양라면","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070023885755","imgUrl":"http://image.gsshop.com/image/23/88/23885755_L1.jpg","productName":"메이준뉴트리 유기농 퓨어 엑스트라버진 코코넛오일 10병","productCost":"109800","channelName":"GSSHOP","brand":"메이준 뉴트리","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070018364803","imgUrl":"http://image.gsshop.com/image/18/36/18364803_L1.jpg","productName":"[CJ] 가쓰오 우동 4인분 x 2개(총 8인분)","productCost":"12900","channelName":"GSSHOP","brand":"씨제이","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070024184241","imgUrl":"http://image.gsshop.com/image/24/18/24184241_L1.jpg","productName":"프레 목장 블루베리요구르트 1000ml x 3병","productCost":"27000","channelName":"GSSHOP","brand":"자연다옴","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070021833565","imgUrl":"http://image.gsshop.com/image/21/83/21833565_L1.jpg","productName":"[삼양]삼양라면컵 6입X2개","productCost":"10400","channelName":"GSSHOP","brand":"삼양라면","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070023885755","imgUrl":"http://image.gsshop.com/image/23/88/23885755_L1.jpg","productName":"메이준뉴트리 유기농 퓨어 엑스트라버진 코코넛오일 10병","productCost":"109800","channelName":"GSSHOP","brand":"메이준 뉴트리","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"}';
	    plL	+=	',{"productType":"3  ","productId":"00070018364803","imgUrl":"http://image.gsshop.com/image/18/36/18364803_L1.jpg","productName":"[CJ] 가쓰오 우동 4인분 x 2개(총 8인분)","productCost":"12900","channelName":"GSSHOP","brand":"씨제이","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070024184241","imgUrl":"http://image.gsshop.com/image/24/18/24184241_L1.jpg","productName":"프레 목장 블루베리요구르트 1000ml x 3병","productCost":"27000","channelName":"GSSHOP","brand":"자연다옴","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070021833565","imgUrl":"http://image.gsshop.com/image/21/83/21833565_L1.jpg","productName":"[삼양]삼양라면컵 6입X2개","productCost":"10400","channelName":"GSSHOP","brand":"삼양라면","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070023885755","imgUrl":"http://image.gsshop.com/image/23/88/23885755_L1.jpg","productName":"메이준뉴트리 유기농 퓨어 엑스트라버진 코코넛오일 10병","productCost":"109800","channelName":"GSSHOP","brand":"메이준 뉴트리","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070018364803","imgUrl":"http://image.gsshop.com/image/18/36/18364803_L1.jpg","productName":"[CJ] 가쓰오 우동 4인분 x 2개(총 8인분)","productCost":"12900","channelName":"GSSHOP","brand":"씨제이","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070024184241","imgUrl":"http://image.gsshop.com/image/24/18/24184241_L1.jpg","productName":"프레 목장 블루베리요구르트 1000ml x 3병","productCost":"27000","channelName":"GSSHOP","brand":"자연다옴","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070021833565","imgUrl":"http://image.gsshop.com/image/21/83/21833565_L1.jpg","productName":"[삼양]삼양라면컵 6입X2개","productCost":"10400","channelName":"GSSHOP","brand":"삼양라면","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070023885755","imgUrl":"http://image.gsshop.com/image/23/88/23885755_L1.jpg","productName":"메이준뉴트리 유기농 퓨어 엑스트라버진 코코넛오일 10병","productCost":"109800","channelName":"GSSHOP","brand":"메이준 뉴트리","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"}';
	    plL	+=	',{"productType":"3  ","productId":"00070018364803","imgUrl":"http://image.gsshop.com/image/18/36/18364803_L1.jpg","productName":"[CJ] 가쓰오 우동 4인분 x 2개(총 8인분)","productCost":"12900","channelName":"GSSHOP","brand":"씨제이","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070024184241","imgUrl":"http://image.gsshop.com/image/24/18/24184241_L1.jpg","productName":"프레 목장 블루베리요구르트 1000ml x 3병","productCost":"27000","channelName":"GSSHOP","brand":"자연다옴","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070021833565","imgUrl":"http://image.gsshop.com/image/21/83/21833565_L1.jpg","productName":"[삼양]삼양라면컵 6입X2개","productCost":"10400","channelName":"GSSHOP","brand":"삼양라면","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070023885755","imgUrl":"http://image.gsshop.com/image/23/88/23885755_L1.jpg","productName":"메이준뉴트리 유기농 퓨어 엑스트라버진 코코넛오일 10병","productCost":"109800","channelName":"GSSHOP","brand":"메이준 뉴트리","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070018364803","imgUrl":"http://image.gsshop.com/image/18/36/18364803_L1.jpg","productName":"[CJ] 가쓰오 우동 4인분 x 2개(총 8인분)","productCost":"12900","channelName":"GSSHOP","brand":"씨제이","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070024184241","imgUrl":"http://image.gsshop.com/image/24/18/24184241_L1.jpg","productName":"프레 목장 블루베리요구르트 1000ml x 3병","productCost":"27000","channelName":"GSSHOP","brand":"자연다옴","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070021833565","imgUrl":"http://image.gsshop.com/image/21/83/21833565_L1.jpg","productName":"[삼양]삼양라면컵 6입X2개","productCost":"10400","channelName":"GSSHOP","brand":"삼양라면","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"},{"productType":"3  ","productId":"00070023885755","imgUrl":"http://image.gsshop.com/image/23/88/23885755_L1.jpg","productName":"메이준뉴트리 유기농 퓨어 엑스트라버진 코코넛오일 10병","productCost":"109800","channelName":"GSSHOP","brand":"메이준 뉴트리","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"}';
	    plL	+= ',{"productType":"3  ","productId":"00070018364803","imgUrl":"http://image.gsshop.com/image/18/36/18364803_L1.jpg","productName":"[CJ] 가쓰오 우동 4인분 x 2개(총 8인분)","productCost":"12900","channelName":"GSSHOP","brand":"씨제이","logoUrl":"http://121.135.146.180:8080/data/images/logo_GSshop.png","productMake":"","airStartTime":"","airEndTime":"","detailUrl":"","videoUrl":"","favoriteYn":"","channelNo":"","airReadyYn":"N"}';
	    plL += ']';    */
	    //console.log(plL);
	    
		var pl = $.parseJSON(plL);
	    
		listLength = pl.length; 
		totalPage = Math.ceil(listLength / endPn);
		
		if(listLength < 6 ){
			endPn = listLength;
		}
		
		//console.log(pl);
		//console.log("totalPage : " + totalPage); 
		//console.log("listLength : " + listLength); 
		makePage(pl);
		
	}else{
		window.GenieShopping.sendTTS("검색결과가 없습니다.");
	} 		
		
	
	// 다음 페이지
	function nextPage(){
		
		if(listLength <=6  || endPn == listLength){
			window.GenieShopping.sendTTS("다음 페이지가 없습니다.");
			//window.GenieShopping.sendTTS("인생은 아름다워 둠치탁치 둠치탁치 나는 래퍼 ");
			return false;
		}else{
			pageNum++;
			startPn += 6;
			if(pageNum == totalPage){
				endPn = listLength;
			}else{
				endPn += 6;
			}
			makePage(pl);
		}
		//console.log("현재 페이지 : " + pageNum);
	}

	// 이전 페이지
	function prevPage(){

		if(pageNum > 1){
			
			startPn -= 6;
			
			if(pageNum == totalPage && endPn == listLength){
				
				var div = endPn % 6;
				//console.log("div : " + div);
				
				if(div != 0){
					endPn = listLength - div;
				}else{
					endPn -= 6;
				}
			}else{
				endPn -= 6;
			}
			pageNum--;
			makePage(pl);
		}else{
			window.GenieShopping.sendTTS("이전 페이지가 없습니다.");
			return false;
		}
		//console.log("현재 페이지 : " + pageNum);
	}
	
	// 페이지 처리 출력
	function makePage(pl){
		
		var str ="";

		for(var i = startPn ; i < endPn ; i++){
			
			str +=		"<li id="+pl[i].productId+" class='curPageNum"+pageNum+"' data-index='"+( tNumOneToSix(i) )+"'>";
			str	+=			"<dl>";
			str	+=				"<dt>";
			str += 						"<span class='t-num'>"+( tNumOneToSix(i) )+"</span>";  // 엥 여기 번호 ?? 다시 1부터??
			str +=						"<span>"+pl[i].channelName+"</span>"
			str +=						"<span>"+pl[i].productName+"</span>";
			str +=					"</dt>";
		    str +=				"<dd>";							

		    if(pl[i].airReadyYn == 'Y'){
		    	
		    	var startTm = pl[i].airStartTime.substring(11,16); 
		    	var endTm = pl[i].airEndTime.substring(11,16);
		    	str += "방송예정 ("+ startTm +" ~ " + endTm + ")";
		    	
		    }else if(pl[i].airReadyYn == 'W'){
		    	str += "";
		    }
		    else{
		    	str += "방송중";
		    }
		    
			str	+=				"</dd>";
			str	+=				"<dd>"+numberWithCommas(pl[i].productCost)+" 원</dd>";
			str	+=				"<dd class='thumb'>";
			str	+=					"<img src="+pl[i].imgUrl+" style='height: 99%;'>";
			str +=				"</dd>";
			str	+=			"</dl>";							
			str	+=			"<a class='btn-blank' tabindex="+i+"></a>"; 
			str +=			"</li>";						
		}// endFor
		
		$("#listUl").html(str);
		
	}//endMakePage
	
	
	// 상품선택시 - 리모콘 선택시
	$(document).on("click","#wrap-rec .p-list-block li",function(){
		var prodId = $(this).attr("id");
		var deviceId = $("#deviceId").val();
		var userKey = $("#userKey").val();
		var reCommendVer = $("#reCommendVer").val();
		var reCommendType = $("#reCommendType").val();
		
		
		location.href = "recommendDetail.do?prodId="+prodId+"&deviceId="+deviceId+"&userKey="+userKey+"&reCommendVer="+reCommendVer+"&reCommendType="+reCommendType;
	})
	
	// 상품선택시 - 보이스 선택시
	function goDetail(tapindex){
		
		var selectObj = $(".curPageNum"+pageNum);
		var prodId;
		var selectObjLength = selectObj.length;
		var deviceId = $("#deviceId").val();
		var userKey = $("#userKey").val();
		var reCommendVer = $("#reCommendVer").val();
		var reCommendType = $("#reCommendType").val();
		
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
		location.href = "recommendDetail.do?prodId="+prodId+"&deviceId="+deviceId+"&userKey="+userKey+"&reCommendVer="+reCommendVer+"&reCommendType="+reCommendType;
	};
	
		
	function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function tNumOneToSix(i){
		//console.log("i : " + i);
		var result = i+1;
		if(pageNum > 1){
			var div = (i+1) % 6;
			//console.log("div : " +  div);
			if(div > 0){
				result = div;				
			}else if(div == 0 ){
				result = 6;
			}
		} 
		return result;
	}

</script>

</body>
</html>