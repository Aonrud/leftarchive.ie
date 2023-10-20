<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="personal-account-topics-list/entry" mode="select">
    <option value="{@id}">
        <xsl:if test="/data/params/url-topic = @id">
            <xsl:attribute name="selected">selected</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="topic" />
    </option>
</xsl:template>

</xsl:stylesheet>
