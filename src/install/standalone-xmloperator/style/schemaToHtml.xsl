<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:sch="http://www.xmloperator.net/namespace/schema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:output method="html"/><xsl:param name="stylesheet"/><xsl:param name="homeURL"/><xsl:param name="homeLabel"/><xsl:param name="copyright"/><xsl:template match="sch:schema"><html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head><title><xsl:value-of disable-output-escaping="no" select="@productName"/> - object oriented schema</title><link href="{$stylesheet}" rel="stylesheet" type="text/css"/></head><body><h1><xsl:value-of disable-output-escaping="no" select="@productName"/><xsl:text disable-output-escaping="no"> </xsl:text><xsl:value-of disable-output-escaping="no" select="@productVersion"/> - object oriented schema</h1><p><a href="{$homeURL}" shape="rect"><xsl:value-of disable-output-escaping="no" select="$homeLabel"/></a></p><xsl:call-template name="description"/><xsl:call-template name="index"><xsl:with-param name="elements" select="sch:package"/><xsl:with-param name="minCount" select="2"/><xsl:with-param name="title" select="&quot;Package list&quot;"/></xsl:call-template><xsl:for-each select="sch:package"><xsl:call-template name="package"/></xsl:for-each><hr/><table border="0" cellpadding="0" width="100%"><tr><td colspan="1" rowspan="1">Last update : <xsl:value-of disable-output-escaping="no" select="@lastUpdate"/></td><td colspan="1" rowspan="1"><small><xsl:value-of disable-output-escaping="no" select="$copyright"/></small></td></tr></table></body></html></xsl:template><xsl:template name="description"><xsl:if test="description"><p><xsl:apply-templates select="description[1]"/></p></xsl:if></xsl:template><xsl:template match="sch:br"><br/></xsl:template><xsl:template match="sch:reference"><a href="#{@reference}" shape="rect"><xsl:value-of disable-output-escaping="no" select="id(@reference)/@name"/></a></xsl:template><xsl:template name="index"><xsl:param name="elements"/><xsl:param name="minCount" select="1"/><xsl:param name="title"/><xsl:if test="count($elements) >= $minCount"><xsl:if test="$title"><p><b><xsl:value-of disable-output-escaping="no" select="$title"/></b></p></xsl:if><ul><xsl:for-each select="$elements"><li><a href="#{@id}" shape="rect"><xsl:value-of disable-output-escaping="no" select="@name"/></a></li></xsl:for-each></ul></xsl:if></xsl:template><xsl:template name="package"><h2><small>Package </small><xsl:text disable-output-escaping="no"> </xsl:text><xsl:call-template name="stack"/></h2><xsl:call-template name="description"/><xsl:call-template name="index"><xsl:with-param name="elements" select="sch:package"/><xsl:with-param name="minCount" select="1"/><xsl:with-param name="title" select="&quot;Package list&quot;"/></xsl:call-template><xsl:call-template name="index"><xsl:with-param name="elements" select="sch:class"/><xsl:with-param name="minCount" select="1"/><xsl:with-param name="title" select="&quot;Class list&quot;"/></xsl:call-template><xsl:for-each select="sch:package"><xsl:call-template name="package"/></xsl:for-each><xsl:for-each select="sch:class"><xsl:call-template name="class"/></xsl:for-each></xsl:template><xsl:template name="stack"><small>/ <xsl:if test="name(..) = &quot;package&quot;"><xsl:call-template name="stackString"><xsl:with-param name="top" select=".."/></xsl:call-template> / </xsl:if></small><a id="{@id}" name="{@id}" shape="rect"><xsl:value-of disable-output-escaping="no" select="@name"/></a></xsl:template><xsl:template name="stackString"><xsl:param name="top"/><xsl:variable name="parent" select="$top/.."/><xsl:if test="name($parent) = &quot;package&quot;"><xsl:call-template name="stackString"><xsl:with-param name="top" select="$parent"/></xsl:call-template> / </xsl:if><a href="#{$top/@id}" shape="rect"><xsl:value-of disable-output-escaping="no" select="$top/@name"/></a></xsl:template><xsl:template name="class"><h3><small>Class<xsl:if test="@type != &quot;standard&quot;">(<xsl:value-of disable-output-escaping="no" select="@type"/>)</xsl:if></small><xsl:text disable-output-escaping="no"> </xsl:text><xsl:call-template name="stack"/></h3><xsl:if test="@generalisation"><p>Extends or implements <xsl:call-template name="linksString"><xsl:with-param name="links" select="@generalisation"/></xsl:call-template></p></xsl:if><xsl:call-template name="description"/><xsl:call-template name="instances"/><xsl:if test="sch:instance and sch:property"><p/></xsl:if><xsl:call-template name="properties"/><xsl:if test="(sch:instance or sch:property) and sch:method"><p/></xsl:if><xsl:call-template name="methods"/></xsl:template><xsl:template name="linksString"><xsl:param name="links"/><xsl:choose><xsl:when test="contains($links, &quot; &quot;)"><xsl:call-template name="link"><xsl:with-param name="id" select="substring-before($links, &quot; &quot;)"/></xsl:call-template>, <xsl:call-template name="linksString"><xsl:with-param name="links" select="substring-after($links, &quot; &quot;)"/></xsl:call-template></xsl:when><xsl:otherwise><xsl:call-template name="link"><xsl:with-param name="id" select="$links"/></xsl:call-template></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="link"><xsl:param name="id"/><a href="#{$id}" shape="rect"><xsl:value-of disable-output-escaping="no" select="id($id)/@name"/></a></xsl:template><xsl:template name="instances"><xsl:if test="sch:instance"><table border="2" cellspacing="4"><thead><tr><th align="center" colspan="2" rowspan="1"><small><xsl:value-of disable-output-escaping="no" select="@name"/></small> instances</th></tr><tr><th colspan="1" rowspan="1">name</th><th colspan="1" rowspan="1">description</th></tr></thead><tbody><xsl:for-each select="sch:instance"><tr><td colspan="1" rowspan="1"><a id="{@id}" name="{@id}" shape="rect"><xsl:value-of disable-output-escaping="no" select="@name"/></a></td><td colspan="1" rowspan="1"><xsl:call-template name="description"/></td></tr></xsl:for-each></tbody></table></xsl:if></xsl:template><xsl:template name="properties"><xsl:if test="sch:property"><table border="2" cellspacing="4"><thead><tr><th align="center" colspan="7" rowspan="1"><small><xsl:value-of disable-output-escaping="no" select="@name"/></small> properties</th></tr><tr><th colspan="1" rowspan="1">name</th><th colspan="1" rowspan="1">kind</th><th colspan="1" rowspan="1">mult.</th><th colspan="1" rowspan="1">type</th><th colspan="1" rowspan="1">over</th><th colspan="1" rowspan="1">init</th><th colspan="1" rowspan="1">description</th></tr></thead><tbody><xsl:for-each select="sch:property"><tr><td colspan="1" rowspan="1"><a id="{@id}" name="{@id}" shape="rect"><xsl:value-of disable-output-escaping="no" select="@name"/></a></td><td colspan="1" rowspan="1"><xsl:if test="@type != &quot;standard&quot;"><xsl:value-of disable-output-escaping="no" select="@type"/></xsl:if></td><td colspan="1" rowspan="1"><xsl:call-template name="multiplicity"><xsl:with-param name="multiplicity" select="@multiplicity"/></xsl:call-template></td><td colspan="1" rowspan="1"><xsl:call-template name="link"><xsl:with-param name="id" select="@reference"/></xsl:call-template></td><td colspan="1" rowspan="1"><xsl:call-template name="linksString"><xsl:with-param name="links" select="@generalisation"/></xsl:call-template></td><td colspan="1" rowspan="1"><xsl:if test="@init"><xsl:call-template name="link"><xsl:with-param name="id" select="@init"/></xsl:call-template></xsl:if></td><td colspan="1" rowspan="1"><xsl:call-template name="description"/></td></tr></xsl:for-each></tbody></table></xsl:if></xsl:template><xsl:template name="multiplicity"><xsl:param name="multiplicity"/><xsl:choose><xsl:when test="$multiplicity = &quot;zeroOrOne&quot;">0,1</xsl:when><xsl:when test="$multiplicity = &quot;one&quot;">1</xsl:when><xsl:when test="$multiplicity = &quot;zeroOrMore&quot;">0,n</xsl:when><xsl:when test="$multiplicity = &quot;oneOrMore&quot;">1,n</xsl:when></xsl:choose></xsl:template><xsl:template name="methods"><xsl:if test="sch:method"><table border="2" cellspacing="4"><xsl:variable name="descriptionColspan" select="3"/><xsl:variable name="argumentColspan" select="5"/><thead><tr><th align="center" colspan="{1 + $descriptionColspan + $argumentColspan}" rowspan="1"><small><xsl:value-of disable-output-escaping="no" select="@name"/></small> methods</th></tr><tr><th colspan="1" rowspan="2">name</th><th colspan="1" rowspan="1">kind</th><th colspan="1" rowspan="1">returns</th><th colspan="1" rowspan="1">over</th><th colspan="{$argumentColspan}" rowspan="1">arguments</th></tr><tr><th colspan="{$descriptionColspan}" rowspan="1">description</th><th colspan="1" rowspan="1">name</th><th colspan="1" rowspan="1">kind</th><th colspan="1" rowspan="1">mult.</th><th colspan="1" rowspan="1">type</th><th colspan="1" rowspan="1">desc.</th></tr></thead><tbody><xsl:for-each select="sch:method"><xsl:variable name="descriptionRowspan" select="count(sch:argument) - 1"/><tr><td colspan="1" rowspan="2"><xsl:if test="$descriptionRowspan > 1"><xsl:attribute name="rowspan"><xsl:value-of disable-output-escaping="no" select="1 + $descriptionRowspan"/></xsl:attribute></xsl:if><a id="{@id}" name="{@id}" shape="rect"><xsl:value-of disable-output-escaping="no" select="@name"/></a></td><td colspan="1" rowspan="1"><xsl:if test="@type != &quot;standard&quot;"><xsl:value-of disable-output-escaping="no" select="@type"/></xsl:if></td><td colspan="1" rowspan="1"><xsl:call-template name="link"><xsl:with-param name="id" select="@reference"/></xsl:call-template></td><td colspan="1" rowspan="1"><xsl:call-template name="linksString"><xsl:with-param name="links" select="@generalisation"/></xsl:call-template></td><xsl:choose><xsl:when test="sch:argument"><xsl:for-each select="sch:argument[1]"><xsl:call-template name="argument"/></xsl:for-each></xsl:when><xsl:otherwise><td colspan="{$argumentColspan}" rowspan="2"/></xsl:otherwise></xsl:choose></tr><tr><td colspan="{$descriptionColspan}" rowspan="1"><xsl:if test="$descriptionRowspan > 1"><xsl:attribute name="rowspan"><xsl:value-of disable-output-escaping="no" select="$descriptionRowspan"/></xsl:attribute></xsl:if><xsl:call-template name="description"/></td><xsl:choose><xsl:when test="count(sch:argument) >= 2"><xsl:for-each select="sch:argument[2]"><xsl:call-template name="argument"/></xsl:for-each></xsl:when></xsl:choose></tr><xsl:for-each select="sch:argument[position() > 2]"><tr><xsl:call-template name="argument"/></tr></xsl:for-each></xsl:for-each></tbody></table></xsl:if></xsl:template><xsl:template name="argument"><td colspan="1" rowspan="1"><a id="{@id}" name="{@id}" shape="rect"><xsl:value-of disable-output-escaping="no" select="@name"/></a></td><td colspan="1" rowspan="1"><xsl:if test="@type != &quot;standart&quot;"><xsl:value-of disable-output-escaping="no" select="@type"/></xsl:if></td><td colspan="1" rowspan="1"><xsl:call-template name="multiplicity"><xsl:with-param name="multiplicity" select="@multiplicity"/></xsl:call-template></td><td colspan="1" rowspan="1"><xsl:call-template name="link"><xsl:with-param name="id" select="@reference"/></xsl:call-template></td></xsl:template></xsl:stylesheet>