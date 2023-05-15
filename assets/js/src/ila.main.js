$(document).ready(function(){
	
	var acOptions = {
		adjustWidth: false,
		url: function(phrase) {
			return "/dynamic/keywords/?sort=frequency&keywords=" + phrase;
		},
		listLocation: "results",
		matchResponseProperty: "input",
		list: {
			maxNumberOfElements: 10
		}
	};
	
	$( "#keywords" ).easyAutocomplete(acOptions);
	
	//There must be a more sensible way to do this than repeat it...
	acOptions.list.onChooseEvent = function() {
		$( "#nav-keywords" ).closest("form").submit();
	}
	
	$( "#nav-keywords" ).easyAutocomplete(acOptions);
	
	acOptions.list.onChooseEvent = function() {
		$( "#s2-keywords" ).closest("form").submit();
	}
	
	$( "#s2-keywords" ).easyAutocomplete(acOptions);
	
	/* Checkbox toggles */
	$("#selectAll").click(function() {
		$("fieldset#checkboxes :checkbox").prop('checked', true);
		this.blur();
	});
	
	$("#selectNone").click(function() {
		$("fieldset#checkboxes :checkbox").prop('checked', false);
		this.blur();
	});
	
	//Get initial values (if already set - e.g. on search results page, otherwise default to min and max).
	var currentYear = (new Date()).getFullYear(), y1, y2;
	if ($( "#year1" ).val()) { y1 = parseInt($( "#year1" ).val()); } else { y1 = 1900; }
	if ($( "#year2" ).val()) { y2 = parseInt($( "#year2" ).val()); } else { y2 = currentYear; } 
	
	var setYearsLabel = function(y1,y2) {
		$("#years").text(y1 + "–" + y2);
	}
	
	setYearsLabel(y1,y2);
	
	$("#slider-fallback").hide();
	
	var yearSlider = $("#year-slider").slider({
		range: true,
		min: 1900,
		max: currentYear,
		value: [y1, y2]
	}).on("slide", function() {
		var v = yearSlider.slider("getValue");
		$("#year1").val(v[0]);
		$("#year2").val(v[1]);
		setYearsLabel(v[0],v[1]);
	});

	//Search tips
	$('#search-tips').popover({
		html: "true",
	title: function() {
		return $("#tips-head").html();
	},
		content:  function() {
		return $("#tips-content").html();
	}
	});
   
/* Comments form */

  $( ".reply-link" ).click(function() {
    var commentid = $(this).data( "comment-id" ),
	commentname = $(this).data( "comment-name" ),
	commenttitle = "Re: " + $(this).closest("div.media-body").children("h4").text();
    $( "#comment-parent" ).val( commentid );
    $( "input#f-title" ).val( commenttitle);
    $( "input#f-title" ).focus();
    $( "#comment-form" ).get(0).scrollIntoView();
    $( "input#f-title" ).addClass("with-reply");
    $( "#reply-status" ).addClass("alert alert-info");
    $( "#reply-status" ).html( 'You are replying to ' + commentname + ". <a href=\"javascript:;\" class=\"reply-remove alert-link\">Remove</a>" );
    
  });

  $( "#reply-status" ).on("click", ".reply-remove",function() {
    $( "#reply-status" ).empty();
    $( "#reply-status" ).removeClass("alert alert-info");
    $( "input#f-title" ).removeClass("with-reply");
    $( "#comment-parent" ).val(null);
  });
  
/* Comments - Markdown editor */  
    var commentArea = $( "#f-comment" ),
	btnMarkup = '<div id="editor-buttons" class="btn-toolbar" role="toolbar"><div class="btn-group"><button type="button" class="btn btn-default" id="btn-b"><span class="fas fa-bold fa-fw"></span></button><button type="button" class="btn btn-default" id="btn-i"><span class="fas fa-italic fa-fw"></span></button><button type="button" class="btn btn-default" id="btn-q"><span class="fas fa-quote-right fa-fw"></span></button></div> <div class="btn-group"><button type="button" class="btn btn-default" id="btn-ol"><span class="fas fa-list-ol fa-fw"></span></button> <button type="button" class="btn btn-default" id="btn-ul"><span class="fas fa-list-ul fa-fw"></span></button></div> <button type="button" class="btn btn-default" id="btn-a"><span class="fas fa-link fa-fw"></span></button> </div>';

    commentArea.before( btnMarkup );
    $( "#editor-buttons button" ).attr('tabindex', "-1");
       
    //Button actions
    $( "#btn-b" ).click(function() { commentArea.mdBold(); commentArea.focus(); });
    $( "#btn-i" ).click(function() { commentArea.mdItalic(); commentArea.focus(); });
    $( "#btn-a" ).click(function() { commentArea.mdLink(); commentArea.focus(); });
    $( "#btn-q" ).click(function() { commentArea.mdQuote(); commentArea.focus(); });
    $( "#btn-ol" ).click(function() { commentArea.mdNumberedList(); commentArea.focus(); });
    $( "#btn-ul" ).click(function() { commentArea.mdBulletList(); commentArea.focus(); });

/* Comment formatting help popover */  
  $('#comment-help').popover({
     html: "true",
    title: function() {
      return $("#comments-help-head").html();
    },
     content:  function() {
      return $("#comments-help-content").html();
    }
   });
  
  //Trigger tooltips
  $('a[data-toggle="tooltip"]').tooltip().click(function() { return false; });

  //Enable the overlay
  if (document.body.classList.contains("t-image-overlay")) {
	  const iv = new ila.ImageViewer({
		  showDownload: true,
		  panzoom: true,
		  texts: {
			  cue: "",
			  hide: "",
			  download: "",
			  prev: "",
			  next: "",
			  link: "",
			  zoom: "",
			  zoomActive: "",
		  },
		  icons: {
			  cue: "fas fa-plus-circle",
			  hide: "fas fa-fw fa-times-circle",
			  download: "fas fa-fw fa-download",
			  prev: "fas fa-fw fa-chevron-circle-left",
			  next: "fa fa-fw fa-chevron-circle-right",
			  link: "fas fa-fw fa-file-pdf",
			  zoom: "fas fa-fw fa-search-plus",
			  zoomActive: "fas fa-fw fa-search-minus",
		  },
		  titles: {
			  link: "View in source PDF document"
		  }
	  });
	  iv.create();
  }

});
