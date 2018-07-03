WebFontConfig = {
	custom: {
		families: ['Noto Sans KR'],
		urls: ['http://fonts.googleapis.com/earlyaccess/notosanskr.css']		
	},
	active: function() {
		sessionStorage.fonts = true;
	}
};
(function() {
	var wf = document.createElement('script');
	wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
	  ':////ajax.googleapis.com/ajax/libs/webfont/1.5.18/webfont.js';
	wf.type = 'text/javascript';
	wf.async = 'true';
	var s = document.getElementsByTagName('script')[0];
	s.parentNode.insertBefore(wf, s);
})();
