<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

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

		