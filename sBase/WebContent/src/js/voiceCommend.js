/**
 * 코디추천, 구매하기, 모바일로 보내기, 상품결과정렬, 실시간채널보기, 피팅영상보기 
 */


// 코디추천
function codiRecommend(){
	
	window.GenieShopping.sendTTS("해당기능은 현재 페이지에서 사용할 수 없습니다.");
}

// 구매하기
function goPurchase(){
	
	if($("#purchaseBtn").length > 0 ){
		//alert("test");
		var productId = $("#productId").val();
		var productName = $("#purchaseBtn").parent().prev().find("dt").find("span:nth-child(2)").text();
		
		console.log(productId + " , " + productName);
		GenieShopping.buy(productId,productName);
	}else{
		window.GenieShopping.sendTTS("해당기능은 현재 페이지에서 사용할 수 없습니다.");
	}
}


// 모바일로 보내기
function goSendMobile(){
	
	if($("#toMobileBtn").length > 0){
		var productId = $("#productId").val();
		GenieShopping.sendMobile(productId);
	}else{
		window.GenieShopping.sendTTS("해당기능은 현재 페이지에서 사용할 수 없습니다.");
	}
	
}


// 상품결과정렬
function goProdSort(){
	window.GenieShopping.sendTTS("해당기능은 현재 페이지에서 사용할 수 없습니다.");
}


// 실시간채널보기
function goOnAir(){
	
	if($("#btn-onair").length > 0){
		var channelNo = $("#btn-onair").attr("channel");
		GenieShopping.watchTV(channelNo);
		
	}else{
		window.GenieShopping.sendTTS("해당기능은 현재 페이지에서 사용할 수 없습니다.");
	}
	
}


// 피팅영상보기
function goFittingVideo(){
	
	
	window.GenieShopping.openApp();
}

