<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--# Contains various useful string processing named templates.
    #
    # string-replace-all:  Replace all instances of 'replace' with 'by' in 'text'
    # vowel-start: Checks if a string begins with a vowel
    # strip-fadas: Replaces all fada/accented vowels with unaccented.
    # strip-newlines: Remove newlines from string
    # lowercase: Translate string to lowercase
    # uppercase: Translate string to uppercase
    # initial: Capitalise the first character of a string
    # substring-after-last: Returns the part of the string after the last occurence of 'delimiter'
    # word-truncate: Truncates a string to 'length' characters, plus the rest of the final word (i.e. won't cut mid-word)
    # force-number: Returns the string if it's can be cast as a number, otherwise returns 0 (used to avoid passing NaN where number expected)
-->
    

<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyzáéíóú'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÚ'" />
<xsl:variable name="fadas" select="'ÁÉÍÓÚáéíóú'" />
<xsl:variable name="vowels" select="'AEIOUaeiou'" />
	
<xsl:template name="string-replace-all">
  <xsl:param name="text" />
  <xsl:param name="replace" />
  <xsl:param name="by" />
  <xsl:choose>
    <xsl:when test="contains($text, $replace)">
      <xsl:value-of select="substring-before($text,$replace)" />
      <xsl:value-of select="$by" />
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text"
        select="substring-after($text,$replace)" />
        <xsl:with-param name="replace" select="$replace" />
        <xsl:with-param name="by" select="$by" />
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$text" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--#
	#Checks if a string starts with a vowel and returns 'Yes' or 'No' (these are the same string values used by Symphony for boolean values).
	#
-->
<xsl:template name="vowel-start">
	<xsl:param name="string" />
	<xsl:choose>
		<xsl:when test="contains($vowels,substring($string,1,1))">Yes</xsl:when>
		<xsl:otherwise>No</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="strip-fadas">
    <xsl:param name="string" />
    <xsl:value-of select="translate($string, $fadas, $vowels)" />
</xsl:template>

<xsl:template name="strip-newlines">
	<xsl:param name="string" />
	<xsl:value-of select="translate($string,'&#x0d;&#x0a;', '')" />
</xsl:template>

<xsl:template name="lowercase">
    <xsl:param name="string" />
    <xsl:value-of select="translate($string, $uppercase, $lowercase)" />
</xsl:template>

<xsl:template name="uppercase">
    <xsl:param name="string" />
    <xsl:value-of select="translate($string, $lowercase, $uppercase)" />
</xsl:template>

<xsl:template name="initial">
    <xsl:param name="string" />
    <xsl:value-of select="translate(substring($string,1,1), $lowercase, $uppercase)" /><xsl:value-of select="substring($string,2)" />
</xsl:template>

<!--Found here: https://stackoverflow.com/questions/9078779/getting-a-substring-after-the-last-occurrence-of-a-character-in-xslt-->
<xsl:template name="substring-after-last">
    <xsl:param name="string" />
    <xsl:param name="delimiter" />
    
    <xsl:choose>
        <xsl:when test="contains($string, $delimiter)">
            <xsl:call-template name="substring-after-last">
                <xsl:with-param name="string" select="substring-after($string, $delimiter)" />
                <xsl:with-param name="delimiter" select="$delimiter" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$string" /></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="word-truncate">
    <xsl:param name="string" />
    <xsl:param name="length" select="'60'" />
    <xsl:param name="word-separator" select="' '" />
    <xsl:param name="ellipses" select="'No'" />
    
	<xsl:value-of select="substring($string, 1, $length + string-length(substring-before(substring($string, $length + 1),$word-separator)))" />
    <xsl:if test="string-length($string) &gt; $length and $ellipses = 'Yes'">&#8230;</xsl:if>
</xsl:template>

<xsl:template name="force-number">
    <xsl:param name="string" />
    <xsl:param name="default" select="'0'" />
    
    <xsl:choose>
        <xsl:when test="number($string) = $string"><xsl:value-of select="$string" /></xsl:when>
        <xsl:otherwise><xsl:value-of select="$default" /></xsl:otherwise>
    </xsl:choose>
</xsl:template>


<!-- Makes a sentence-formatted list from a space-separated list of words.
     Adds commas between each, and 'and' before the final one.
     TODO: This is crude – it doesn't handle multiple consecutive spaces or trailing spaces.
-->
<xsl:template name="make-list">
    <xsl:param name="string" />
    <xsl:param name="delimiter" select="' '" />
    
    <xsl:variable name="separator">
        <xsl:choose>
            <!--Ignore leading space-->
            <xsl:when test="string-length(substring-before($string, $delimiter)) = 0"></xsl:when>
            <xsl:when test="contains(substring-after($string, $delimiter), $delimiter)">
                <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> and </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:choose>
        <xsl:when test="contains($string, $delimiter)">
            <xsl:value-of select="substring-before($string, $delimiter)" />
            <xsl:value-of select="$separator" />
            <xsl:call-template name="make-list">
                <xsl:with-param name="string" select="substring-after($string, $delimiter)" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$string" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
