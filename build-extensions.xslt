<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:func="http://exslt.org/functions"
	xmlns:get="http://xmlns.greystate.dk/2014/functions"
	exclude-result-prefixes="get"
	extension-element-prefixes="func"
>

	<xsl:output method="xml" indent="yes" omit-xml-declaration="no" />

	<xsl:template match="doc">
		<docset name="Umbraco Library Quick Reference" version="0.2.0">
			<functions>
				<xsl:apply-templates select="members/member" />
			</functions>
		</docset>
	</xsl:template>
	
	<xsl:template match="member[starts-with(@name, 'M:')]">
		<xsl:variable name="name" select="get:function-name(@name)" />
		<function name="{$name}">
			<description>
				<xsl:apply-templates select="summary" />
				<xsl:apply-templates select="returns[normalize-space()]" />
			</description>
			<xsl:apply-templates select="param" />
		</function>
	</xsl:template>
	
	<xsl:template match="returns">
		<p>Returns: <xsl:value-of select="." /></p>
	</xsl:template>
	
	<xsl:template match="summary">
		<p><xsl:apply-templates /></p>
	</xsl:template>
	
	<xsl:template match="param">
		<argument name="{@name}" required="yes" />
	</xsl:template>
	
	<xsl:template match="member[not(starts-with(@name, 'M:'))] | member[contains(@name, '#ctor')]">
		<!-- We don't want output from these -->
	</xsl:template>
	
	<func:function name="get:function-name">
		<xsl:param name="fname" />
		<xsl:variable name="name" select="substring-before(substring-after($fname, 'umbraco.library.'), '(')" />
		<xsl:if test="normalize-space($name)">
			<func:result select="normalize-space($name)" />
		</xsl:if>
		<xsl:if test="not(normalize-space($name))">
			<func:result select="substring-after($fname, 'umbraco.library.')" />
		</xsl:if>
	</func:function>

</xsl:stylesheet>