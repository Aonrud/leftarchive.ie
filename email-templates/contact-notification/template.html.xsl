<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text"
	omit-xml-declaration="no"
	encoding="UTF-8"
	indent="no"/>

<xsl:template match="/">
	<xsl:copy-of select="/data/submission/entry/user-message[@mode = 'formatted']" />
</xsl:template>

</xsl:stylesheet>
