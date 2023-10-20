function typeIcon(entryType) {
  var icon = '';
  switch (entryType) {
    case "Organisations":
      icon = 'fa-users';
      break;
    case "International":
      icon = 'fa-globe-europe';
      break;
    case "Publications":
      icon = 'fa-newspaper';
      break;
    case "Subjects":
      icon = 'fa-bookmark';
      break;
  }
  return '<span class="fas fa-fw ' + icon + '"></span>&#160;';
}

$( "#complete-list" ).easyAutocomplete({
	adjustWidth: false,
	url: function(phrase) {
		return "/dynamic/?keywords=" + phrase;
	},
	dataType: "xml",
	xmlElementName: "entry",
	getValue: function(element) {
	  return $(element).find("name").text();
	},
	list: {
	  match: {
	    enabled: true
	  },
	  onChooseEvent: function() {
	    var entry = $("#complete-list").getSelectedItemData();
	    $("#complete-list").val("");
	    var entryID = $(entry).find("id").text();
	    var listItem = '<li class="list-group-item" data-entry-id="' + entryID + '">'
	                    + '<button type="button" class="close pull-right" aria-label="Remove"><span aria-hidden="true">&times;</span></button>'
	                    + typeIcon($(entry).find("type").text())
	                    + $(entry).find("name").text()
	                    + '</li>';
      var formOption = '<option value="' + entryID + '" selected="selected"></option>';
      $("ul.associations-list").append(listItem);
      $("select[name='fields[associations][]']").append(formOption);
      $("ul.associations-list").find("button.close").on("click", function() {
        $(this).parent("li").remove();
        $("option[value='" + $(this).parent("li").data("entry-id") + "']").remove();
      });
	  }
	},
	template: {
	  type: "custom",
	  method: function(value, item) {
	    return typeIcon($(item).find("type").text()) + value;
	  }
	}
});

$("#story-form").on("submit", function() {
  var assocIDs = $.map($("#related-list [data-id]"), function(el) {
    return $(el).data("id");
  });
  console.log(assocIDs);
  return true;
});

//Hide topic suggestions unless 'Other' is selected. Hide on load, then look for change.
$("input#new-topic").hide();

$("#story-form select").on("change", function() {
    if ($("option#suggest-other").is(":selected")) {
        $("input#new-topic").show();
        console.log("show input");
    } else {
        $("input#new-topic").hide();
        console.log("hide input");
    };
});

