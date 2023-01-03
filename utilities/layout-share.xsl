<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="str exsl"
	exclude-result-prefixes="str exsl">
	
<xsl:template name="share-table-row">
	<xsl:param name="title" />
	
	<tr>
		<th scope="row"><span class="fas fa-share-alt fa-fw"></span> Share:</th>
		<td>
			<xsl:call-template name="share-links">
				<xsl:with-param name="title"><xsl:value-of select="$title" /></xsl:with-param>
			</xsl:call-template>
		</td>
	</tr>
</xsl:template>

<xsl:template name="share-links">
	<xsl:param name="title" />
	<xsl:param name="alignment" />
	<xsl:param name="via" select="$ila-activitypub-handle" />
	<xsl:param name="hashtag" select="'#IrishLeftArchive'" />
	
	<xsl:variable name="short-title">
		<xsl:choose>
			<xsl:when test="string-length($title) > 97">
				<xsl:value-of select="substring($title, 1, 94)" /><xsl:text>…</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$title" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="encoded-title">
		<xsl:value-of select="str:encode-uri($title,true())" />
	</xsl:variable>
	
	<xsl:variable name="short-encoded-title">
		<xsl:value-of select="str:encode-uri($short-title,true())" />
	</xsl:variable>
	
	<xsl:variable name="url"><xsl:value-of select="/data/params/current-url" />/</xsl:variable>
	
	<xsl:variable name="encoded-url">
		<xsl:value-of select="str:encode-uri($url,true())" />
	</xsl:variable>

	<ul class="share list-inline">
		<xsl:if test="$alignment = 'right'"><xsl:attribute name="class">share list-inline text-right</xsl:attribute></xsl:if>
		<li><a href="https://toot.kytta.dev/?text={$encoded-title}%20{$encoded-url}%0A%0Avia%20{str:encode-uri($ila-activitypub-handle, true())}%20{str:encode-uri($hashtag,true())}" target="_blank" title="Share on Mastodon" data-medium="Mastodon" data-item="{$short-title}"><span class="fab fa-mastodon fa-fw"></span><span class="sr-only">Share on Mastodon</span></a></li>
		<li><a href="https://www.facebook.com/sharer/sharer.php?u={$encoded-url}" target="_blank" title="Share on Facebook" data-medium="Facebook" data-item="{$short-title}"><span class="fab fa-facebook-f fa-fw"></span><span class="sr-only">Share on Facebook</span></a></li>
		<li><a href="https://twitter.com/intent/tweet?text={$short-encoded-title}&amp;url={$encoded-url}&amp;original_referer={$encoded-url}" target="_blank" title="Share on Twitter" data-medium="Twitter" data-item="{$short-title}"><span class="fab fa-twitter fa-fw"></span><span class="sr-only">Share on Twitter</span></a></li>
		<li class="hidden-md hidden-lg"><a href="whatsapp://send?text={$encoded-title}%20{$encoded-url}" data-action="share/whatsapp/share" title="Share on Whatsapp" data-medium="Whatsapp" data-item="{$short-title}"><span class="fab fa-whatsapp fa-fw"></span><span class="sr-only">Share on Whatsapp</span></a></li>
		<li><a href="mailto:?subject={$title}&amp;body={$url}" title="Send by email" data-medium="Email" data-item="{$short-title}"><span class="fas fa-envelope fa-fw"></span><span class="sr-only">Send by email</span></a></li>
	</ul>
	
</xsl:template>

</xsl:stylesheet>
