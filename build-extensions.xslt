<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:output method="xml" indent="yes" omit-xml-declaration="no" />

	<xsl:template match="doc">
		<docset name="Umbraco Library Quick Reference" version="0.1.1">
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
	
	<xsl:template match="member[not(starts-with(@name, 'M:'))] | member[contains(@name, '#ctor')]">
		<!-- We don't want output from these -->
	</xsl:template>

</xsl:stylesheet>