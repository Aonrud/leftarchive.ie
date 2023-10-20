$(document).ready(function(){
	var rv = Cookies.get('visited');
	var message = '<div class="alert alert-info alert-dismissable" role="alert"> <button type="button" class="close" data-dismiss="alert" aria-label="close"><span aria-hidden="true">&times;</span></button>This website uses cookies. Visit our <a href="/information/privacy/" class="alert-link">privacy page</a> for more information. &emsp;<a href="#" data-dismiss="alert">Dismiss this message</a>.</div>';
	var page = window.location.pathname;
	if (rv == null) {
		switch (page) {
			case "/page/timeline-of-the-irish-left/":
				$("#info h3").after(message);
				break;
			default:
				$("nav.navbar").after(message);
		};
		Cookies.set('visited','yes',{expires: 36500});
	};	
});
