$(document).ready(function(){

	
	var acOpt = {
		adjustWidth: false,
		url: function(phrase) {
			return "/dynamic/subjects/?keywords=" + phrase;
		},
		list: {
			maxNumberOfElements: 10
		}
	};
	
    $( "#suggestion" ).easyAutocomplete(acOpt);
    
    /* Dynamic form submit */
    $ssform = $("#subject-suggestion-form");
    $ssbtn = $ssform.find("button");
    
    $ssform.on("submit", function(e) {
        var form_data = $ssform.serializeArray();
        form_data.push({ name: $ssbtn.attr("name"), value: ""});
        
        $.ajax({
            type: "POST",
            url: "/dynamic/subject-suggestion/",
            data: form_data,
            success: function(response) {
                console.log(response);
                $ssbtn.removeClass("btn-primary");
                
                if (response.result === 'success') {
                    _paq.push(['trackEvent', 'Subject Suggestion', response.suggestion]);
                    umami.track('Subject Suggestion', { value: response.suggestion });
                    var message = '<p class="alert alert-success"><span class="fas fa-check"></span> Thanks! Your suggestion has been sent for review.</p>';
                    var form = $('#subject-suggestion').html();
                    
                    $('#subject-suggestion').animate({'opacity': 0}, 400, function(){
                        $(this).html(message).animate({'opacity': 1}, 400);    
                    });
                } else {
                    _paq.push(['trackEvent', 'Subject Suggestion', "Form Failure"]);
                    $ssbtn.addClass("btn-error");
                    $ssbtn.attr("disabled","disabled");
                }
            },
            error: function(response) {
                    console.log("Ajax submit error.");
            }
        });
        e.preventDefault();
    });
});
