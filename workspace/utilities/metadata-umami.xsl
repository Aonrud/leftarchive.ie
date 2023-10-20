<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="umami">
	<!--Comments-->
	<xsl:if test="/data/events/submit-comment/@result = 'success'">
		<script type="text/javascript">
			<xsl:text disable-output-escaping="yes" >
			<![CDATA[umami.track('Comment', { page: document.title });]]>
			</xsl:text>
		</script>
	</xsl:if>

	<!--Contact-->
	<xsl:if test="/data/events/submit/@result = 'success'">
		<script type="text/javascript">
			<xsl:text disable-output-escaping="yes" >
			<![CDATA[umami.track('Contact');]]>
			</xsl:text>
		</script>
	</xsl:if>
	
	<!--Personal account submit-->
	<xsl:if test="/data/events/story/@result = 'success'">
		<script type="text/javascript">
			<xsl:text disable-output-escaping="yes" >
			<![CDATA[umami.track('Personal Account');]]>
			</xsl:text>
		</script>
	</xsl:if> 
</xsl:template>

</xsl:stylesheet>
