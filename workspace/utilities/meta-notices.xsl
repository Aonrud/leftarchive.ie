<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template name="copyright">
	<xsl:param name="project" select="'The Irish Left Archive'" />
<xsl:value-of select="$project" /> is provided as a non-commercial historical resource, open to all, and has reproduced this document as an accessible digital reference. Copyright remains with its original authors. If used on other sites, we would appreciate a link back and reference to <xsl:value-of select="$project" />, in addition to the original creators. For re-publication, commercial, or other uses, please contact the original owners. If documents provided to <xsl:value-of select="$project" /> have been created for or added to other online archives, please inform us so sources can be credited.
</xsl:template>


</xsl:stylesheet>
