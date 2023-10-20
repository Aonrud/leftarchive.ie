<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--Template for a meta refresh redirect, which sends to the parent entry. Needs to be passed the redirect URL.
	This should be included in the header via the 'head-insert' template on the calling page.
		(The head-insert template is called in the master template with empty content. When additional header content needs to be added, the local page should provide an override version of this template.)
-->
<xsl:template name="redirect">
	<xsl:param name="url" />
	<meta http-equiv="refresh" content="0; url={$url}" />
</xsl:template>

</xsl:stylesheet>
