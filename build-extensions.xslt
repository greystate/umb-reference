<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:output method="xml" indent="yes" omit-xml-declaration="no" />

	<xsl:template match="doc">
		<docset name="XSLT 1.0" version="0.9.3.4">
			<functions>
				<xsl:apply-templates select="members/member" />
			</functions>
		</docset>
	</xsl:template>
	
	<xsl:template match="member[starts-with(@name, 'M:')]">
		<xsl:variable name="name" select="substring-after(@name, 'umbraco.library.')" />
		<function name="{$name}">
			<xsl:apply-templates select="summary" />
			<xsl:apply-templates select="param" />
		</function>
	</xsl:template>
	
	<xsl:template match="summary">
		<description>
			<p><xsl:apply-templates /></p>
		</description>
	</xsl:template>
	
	<xsl:template match="param">
		<argument name="{@name}" />
	</xsl:template>
	
	<xsl:template match="member[not(starts-with(@name, 'M:'))]">
		
	</xsl:template>
<!--	<functions>
		<function name="translate">
			<description>
				<p>
					Performs character-replacements in the <var>source</var> string, by replacing every character in the
					<var>find</var> argument found in <var>source</var>, with the character in <var>replace</var> at
					the same index </p>
			</description>
			<argument name="source" type="string" required="yes" />
			<argument name="find" type="string" required="yes" />
			<argument name="replace" type="string" required="yes" />
		</function> -->
	

</xsl:stylesheet>