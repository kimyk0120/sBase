<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>상품상세 - Genie Shopping</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<link rel="stylesheet" href="/src/css/style.css" type="text/css" />
<script type="text/javascript" src="/src/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/src/js/font-load.js"></script>
<script type="text/javascript" src="/src/js/voiceCommend.js"></script>
</head>

<body>
<input type="hidden" value="${productDetail.productId}" id="productId">
<input type="hidden" value="${userKey}" id="userKey">
<input type="hidden" value="${deviceType}" id="deviceType">
<input type="hidden" value="${selId}" id="selId">
<input type="hidden" value="${deviceId}" id="deviceId">
<input type="hidden" value="${reCommendType }" id="reCommendType">
<input type="hidden" value="${reCommendVer }" id="reCommendVer">
<input type="hidden" value="${pageReqNum }" id="pageReqNum">

<div id="wrap">
	<div id="wrap-detail">

		<div class="head-block">

			<h1><img src="/src/images/logo.png" alt="Genie Shopping"></h1>

			<p class="t-exp">&quot;최저가 순으로 보여줘&quot;, &quot;내가 입은 모습 보여줘&quot; 라고 해보세요.</p>

		</div><!-- // head-block -->

		<div class="p-detail-block clearfix">

			<div class="exp-block">

				<h2>
					<span><img src="${productDetail.logoUrl}" ></span>
					<span>${productDetail.channelName}</span><!-- 채널명 -->
				</h2>

				<dl>
					<dt>
						<span>${productDetail.brand }</span>
						<span>${productDetail.productName }</span><!-- 0607 한글기준 42자 이상일 때 점점점(...) 으로 처리 -->
					</dt>
					<!-- 0607삭제 <dd>SPOAY 251619087</dd> -->
					<dd>${productDetail.productMake }</dd>
					<dd>
						<c:set value="${fn:replace(productDetail.productCost , ',', '')}" var="productCost" />
						<fmt:formatNumber value="${productCost }" pattern="#,###" />
					</dd>
				</dl>

				<div class="btn-block">
					<button type="button" id="purchaseBtn" >구매하기</button>
					<button type="button" id="toMobileBtn">모바일로 전송</button>
				</div>

				<div class="btn-block-top">
					
					<c:choose>
						
						<c:when test="${ productDetail.airReadyYn eq 'N'}">
							<a href="#" class="btn-onair" id="btn-onair" channel='${productDetail.channelNo}'><span class="t-hidden">방송중 : 생방송 바로보기</span></a>
						</c:when>
						
					</c:choose>
					
					
					<c:if test="${productDetail.videoUrl ne null and productDetail.videoUrl ne ''}">
						<a href="#" class="btn-vod" id="btn-vod" url="${ productDetail.videoUrl}"><span>VOD</span></a>
					</c:if>
					
					<!-- Test -->
					<!-- <a href="#" class="btn-vod" id="testVod" url="http://220.85.93.81:8080/data/video/12532760.mp4"><span>Test Vod</span></a> -->
					
				</div>

			</div><!-- // exp-block -->

			<div class="img-block">
				<div class="d-block">
					<img src="${productDetail.imgUrl }" style="width: auto; height: 100%;"> 
 				</div>
			</div><!-- // img-block -->

		</div><!-- // p-detail-block -->

		<div class="search-block clearfix">

			<div class="title-block">
			
			
				<h3><span>‘${searchStr}’</span> 검색 결과입니다.</h3>
				<p>원하는 번호를 ‘1번’ 이라고 말하거나 리모컨으로 선택해주세요.</p>
				
				
			</div><!-- // title -->

			<div class="clearfix">

				<div class="search">
					<dl>
						<dt>검색 결과</dt>
						<dd id="searchLength">&nbsp;</dd>
					</dl>
					<button type="button" id="srchResultMoreBtn">검색결과 더보기</button>
					
				</div><!-- // search -->

				<div class="p-list-block">
					<ul class="clearfix" id="listUl">
					
						<!-- ex -->
						<!-- <li>
							<dl>
								<dt>
									<span class="t-num">1</span>
								</dt>
								<dd class="thumb"><img src="/src/images/temp_img182.png" alt="NS홈쇼핑 [톰앤래빗][오가게/톰앤래빗]허그OPS/심플 원피스"></dd>
								<dd class="ico"><span class="t-hidden">방송중<span></dd>
							</dl>
							<a href="#" class="btn-blank"></a>상품상세 링크(이하 동일)
						</li> -->
						<!--  -->
					</ul>

				</div>

			</div><!-- // p-list-block -->

		</div><!-- // search-block -->

	</div><!--// wrap-detail -->

</div><!--// wrap -->

<!-- <div id="pop" style="display: none;">
	<div class="content-block">
		<video width="920" height="518" id="Video1">
			<source src="http://220.85.93.81:8080/data/video/12532760.mp4" type="video/mp4">
		</video>
		<button type="button" id="popCloseBtn">닫기</button>
	</div>
</div>// pop -->


<script type="text/javascript">
	
	// test
	//goPurchase();
	
	// TV시청 선택시
	$(document).on("click","#btn-onair",function(){
		var channelNo = $(this).attr("channel");
		//console.log("channelNo : " + channelNo);
		GenieShopping.watchTV(channelNo);
		//GenieShopping.watchTV(20);
	})
	
	// vod 선택시
	$(document).on("click","#btn-vod",function(){
		var url = $(this).attr("url");
		GenieShopping.watchVOD(url);
	})
	
	// 구매하기 선택시  // productName 추가
	$(document).on("click","#purchaseBtn",function(){
		var productId = $("#productId").val();
		var productName = $(this).parent().prev().find("dt").find("span:nth-child(2)").text();
		//console.log("productName : " + productName);
		GenieShopping.buy(productId,productName);
	})
	
	// 모바일로 전송 선택시
	$(document).on("click","#toMobileBtn",function(){
		var productId = $("#productId").val();
		GenieShopping.sendMobile(productId);
	})
	
	// Test vod 테스트 선택시
	$("#testVod").on("click",function(){
		var url = $(this).attr("url");
		GenieShopping.watchVOD(url);
	})
	
	// 검색결과 더보기 선택시 
	$("#srchResultMoreBtn").on("click",function(){
		nextPage();
	})
	
	
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
	    plL += ']';       */
	    //console.log(plL);
	    
		var pl = $.parseJSON(plL);
	    
		listLength = pl.length; 
		$("#searchLength").html(listLength);
		totalPage = Math.ceil(listLength / endPn);
		
		if(listLength < 6 ){
			endPn = listLength;
		}
		
		//console.log(pl);
		//console.log("totalPage : " + totalPage); 
		//console.log("listLength : " + listLength); 
		makePage(pl);
		
		var pageReqNum = $("#pageReqNum").val();
		if(pageReqNum  != null && pageReqNum != "" && pageReqNum > 1){
			for(var i = 1; i < pageReqNum ; i++){
				nextPage();
			}
		}
		
	}else{
		window.GenieShopping.sendTTS("검색결과가 없습니다.");
		history.back();
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
			
				
			str	+=	"<li id="+pl[i].productId+" class='curPageNum"+pageNum+"' data-index='"+( tNumOneToSix(i) )+"'>";
			str	+=		"<dl>";
			str	+=			"<dt>";
			str	+=				"<span class='t-num'>"+( tNumOneToSix(i) )+"</span>"
			str	+=			"</dt>";
			str	+=			"<dd class='thumb'><img src='"+pl[i].imgUrl+"' style='height:100%;'></dd>";
			
			if(pl[i].airReadyYn == 'N'){
				str	+=			"<dd class='ico'><span class='t-hidden'>방송중<span></dd>";
			}
			
			str	+=		"</dl>";
			str	+=		"<a  class='btn-blank' tabindex="+i+"></a>";
			str	+=	"</li>";
			
			
		}// endFor
		
		$("#listUl").html(str);
		
	}//endMakePage
	
	
	// 상품선택시 - 리모콘 선택시
	$(document).on("click","#wrap-detail .p-list-block li",function(){
		var prodId = $(this).attr("id");
		var userKey = $("#userKey").val();
		var deviceType = $("#deviceType").val();
		var deviceId = $("#deviceId").val();
		var selId = $("#selId").val();
		var pathNm =  $(location).attr("pathname");
		var reCommendType = $("#reCommendType").val();
		var reCommendVer = $("#reCommendVer").val();
		
		/* console.log("reCommendVer :" +  reCommendVer);
		console.log("userKey :" +  userKey); */
		
		if(pathNm == '/web/visualShoppingResult.do'){
			var data = { 
				  "prodId":prodId,
				  "userKey":userKey,
				  "deviceType":deviceType,
				  "selId":selId,
				  "deviceId":deviceId
			  };
			var url = "visualShoppingResultAjax.do";
			
			makeDetailToAjax(url,data);
			//location.href = pathNm +"?prodId="+prodId+"&userKey="+userKey+"&deviceType="+deviceType+"&selId="+selId+"&deviceId="+deviceId;
			
		}else{
			var data =  { 
				  "prodId":prodId,
				  "userKey":userKey,
				  "deviceType":deviceType,
				  "selId":selId,
				  "deviceId":deviceId,
				  "reCommendType":reCommendType,
				  "reCommendVer":reCommendVer
			  };
			var url = "recommendDetailAjax.do";
			makeDetailToAjax(url,data);		
			//location.href = "recommendDetail.do?prodId="+prodId+"&userKey="+userKey+"&deviceType="+deviceType+"&selId="+selId+"&deviceId="+deviceId+"&reCommendType="+reCommendType+"&reCommendVer="+reCommendVer;
		} 
	})
	
	/* goDetail(3); */
	
	// 상품선택시 - 보이스 선택시
	function goDetail(tapindex){
		
		var selectObj = $(".curPageNum"+pageNum);
		var deviceType = $("#deviceType").val();
		var deviceId = $("#deviceId").val();
		var userKey = $("#userKey").val();
		var selId = $("#selId").val();
		var prodId;
		var selectObjLength = selectObj.length;
		var reCommendType = $("#reCommendType").val();
		var reCommendVer = $("#reCommendVer").val();
		
		
		if(tapindex > selectObjLength || tapindex == 0){
			
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
		
		var pathNm =  $(location).attr("pathname");
		//console.log("pathNm :" +  pathNm);
		
		if(pathNm == '/web/visualShoppingResult.do'){
			var data = { 
					  "prodId":prodId,
					  "userKey":userKey,
					  "deviceType":deviceType,
					  "selId":selId,
					  "deviceId":deviceId
				  };
			var url = "visualShoppingResultAjax.do";
			
			makeDetailToAjax(url,data);
			//location.href = pathNm +"?prodId="+prodId+"&userKey="+userKey+"&deviceType="+deviceType+"&selId="+selId+"&deviceId="+deviceId;
		}else{
			
			var data =  { 
					  "prodId":prodId,
					  "userKey":userKey,
					  "deviceType":deviceType,
					  /* "selId":selId, */
					  "deviceId":deviceId,
					  "reCommendType":reCommendType,
					  "reCommendVer":reCommendVer
				  };
			var url = "recommendDetailAjax.do";
			makeDetailToAjax(url,data);			
			//location.href = "recommendDetail.do?prodId="+prodId+"&userKey="+userKey+"&deviceType="+deviceType+"&selId="+selId+"&deviceId="+deviceId+"&reCommendType="+reCommendType+"&reCommendVer="+reCommendVer;
		}  
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
	
	function makeDetailToAjax(url,data){
		
		$.ajax({
			  method: "POST",
			  url: url,
			  data: data
		}).done(function(resultHtml){
			$(".p-detail-block").html(resultHtml);
		});	
	};
	
	
//TTS 실행
//GenieShopping.sendTTS(String message)
</script>

</body>
</html>