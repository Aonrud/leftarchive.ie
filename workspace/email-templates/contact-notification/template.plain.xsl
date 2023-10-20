<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="no"/>

<xsl:template match="/">
	<xsl:value-of select="/data/submission/entry/user-message[@mode = 'unformatted']" />
</xsl:template>

</xsl:stylesheet>
