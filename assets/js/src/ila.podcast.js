var episode = $(".page-header h1 span").text();

$('audio').mediaelementplayer({
	pluginPath: "/workspace/assets/plugins/"
}).on('playing', function() {
	console.log("Audio playing");
	_paq.push(['trackEvent', 'Podcast', "Play", "Episode " + episode]);
}).on('pause', function() {
	console.log("Audio paused");
	_paq.push(['trackEvent', 'Podcast', "Paused", "Episode " + episode]);
}).on('ended', function() {
	console.log("Audio ended");
	_paq.push(['trackEvent', 'Podcast', "Ended", "Episode " + episode]);
});

//Dynamic pagination
var $list = $(".podcast-list");
var button = '<div class="text-center"><a id="podPg" class="btn btn-default btn-lg" href="">Show More Episodes</a></div>';
var page = 2;
var totalPages = $list.data("pages");

$list.after(button);
$("a#podPg").on('click', function(e) {
	e.preventDefault();
	$.get( "/dynamic/podcast/?p="+page, function( data ) {
		$list.append(data);
		console.log("Loaded page "+page);
		page += 1;
		if (page > totalPages) {
			console.log("Max pages reached.");
			$list.next("div").children("a#podPg").addClass("disabled");
		};
	});
	return false;
});
