<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="matomo">

        <script type="text/javascript">
        <xsl:text disable-output-escaping="yes">
            <![CDATA[ var _paq = window._paq || []; ]]>
        </xsl:text>
        
        <!--Error page-->
        <xsl:if test="$current-page-id = '14'">
            <xsl:text disable-output-escaping="yes">
                <![CDATA[_paq.push(['setDocumentTitle',  '404/URL = ' +  encodeURIComponent(document.location.pathname+document.location.search) + '/From = ' + encodeURIComponent(document.referrer)]);]]>
            </xsl:text>
        </xsl:if>
        
        <!--Search-->
        <xsl:if test="$current-page-id = '6' and /data/params/url-keywords">
            <xsl:variable name="search-count">
                <xsl:value-of select="/data/search/pagination/@total-entries" />
            </xsl:variable>
            <xsl:text disable-output-escaping="yes" >
                <![CDATA[var searchCount = ]]>
            </xsl:text>
            <xsl:value-of select="$search-count" />;
            <xsl:text disable-output-escaping="yes" >
                <![CDATA[_paq.push(['setCustomUrl', document.URL + '&search_count=' + searchCount]);]]>
            </xsl:text>
        </xsl:if>

        <!--Comments-->
        <xsl:if test="/data/events/submit-comment/@result = 'success'">
            <xsl:text disable-output-escaping="yes" >
            <![CDATA[_paq.push(['trackEvent', 'Comments', 'Comment Added', 'Comment: '+document.title ]);]]>
            </xsl:text>
        </xsl:if>

        <!--Contact-->
        <xsl:if test="/data/events/submit/@result = 'success'">
            <xsl:text disable-output-escaping="yes" >
            <![CDATA[_paq.push(['trackEvent', 'Contact', 'Contact Message']);]]>
            </xsl:text>
        </xsl:if>
        
        <!--Personal account submit-->
        <xsl:if test="/data/events/story/@result = 'success'">
            <xsl:text disable-output-escaping="yes" >
            <![CDATA[_paq.push(['trackEvent', 'Contact', 'Personal Account']);]]>
            </xsl:text>
        </xsl:if>

        <xsl:text disable-output-escaping="yes">
        <![CDATA[
            _paq.push(['trackPageView']);
            _paq.push(['enableLinkTracking']);
            _paq.push(['enableHeartBeatTimer']);
            (function() {
                var u="//data.leftarchive.ie/";
                _paq.push(['setTrackerUrl', u+'matomo.php']);
                _paq.push(['setSiteId', '1']);
                var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
                g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
            })();
        ]]>
        </xsl:text>
        </script>
        <noscript><p><img src="//data.leftarchive.ie/matomo.php?idsite=1&amp;rec=1" style="border:0;" alt="" /></p></noscript>
    </xsl:template>

</xsl:stylesheet>
