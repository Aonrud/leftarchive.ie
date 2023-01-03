<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/general-datetime.xsl" />
<xsl:import href="../utilities/section-podcast.xsl" />

<xsl:output method="html" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />

<xsl:template match="/">
	<xsl:apply-templates select="/data/podcast-list/entry" />
</xsl:template>

</xsl:stylesheet>
