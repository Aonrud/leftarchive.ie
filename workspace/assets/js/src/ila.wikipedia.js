//Usage:  Include a #wiki id with the target title in data-title attribute and optional lang attribute
$(document).ready(function(){
    if ( $("#wiki").length ) {        
        var title = $("#wiki").data("title");
        var wpLang = ($("#wiki").attr("lang").length ? $("#wiki").attr("lang") : "en");
        
        var sentences = 3;
        
        $.ajax({
            type: "GET",
            url: 'https://' + wpLang + '.wikipedia.org/w/api.php?format=json&action=query&prop=extracts|info&inprop=url&exintro&explaintext&exsentences='+sentences+'&redirects=1&callback=?&titles=' + title,
            dataType: "json",
            success: function (data) {
                var check = title;
                if (typeof data.query.normalized !== undefined) {
                    check = data.query.normalized[0].to;
                }
                var pages = Object.keys(data.query.pages);
                var page = data["query"]["pages"][pages[0]];
                
                //Not sure if this is necessary.  Can the 'titles' query return more than 1 value if only one requested? Possibly with disambiguation pages?
                if (pages.length > 1) {
                    for (var p in pages) {
                        if (p.title = check) {
                            page = p;
                        }
                    }
                }
                var c = '<blockquote lang="' + wpLang + '"><p>'+page.extract+'</p><cite><small><a href="'+page.canonicalurl+'" class="external">Wikipedia <span class="fas fa-external-link-alt"></span></a></small></cite></blockquote>';
                $("#wiki").html(c);
            },
            error: function (errorMessage) {
            }
        })
   }    
});
