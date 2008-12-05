<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:dep="http://www.xmloperator.net/namespace/depend" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:output method="html"/><xsl:param name="stylesheet"/><xsl:param name="homeURL"/><xsl:param name="homeLabel"/><xsl:param name="copyright"/><xsl:template match="dep:depend"><html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head><title><xsl:value-of disable-output-escaping="no" select="@productName"/> - dependencies</title><link href="{$stylesheet}" rel="stylesheet" type="text/css"/></head><body><h1><xsl:value-of disable-output-escaping="no" select="@productName"/><xsl:text disable-output-escaping="no"> </xsl:text><xsl:value-of disable-output-escaping="no" select="@productVersion"/> - dependencies</h1><p><a href="{$homeURL}" shape="rect"><xsl:value-of disable-output-escaping="no" select="$homeLabel"/></a></p><xsl:call-template name="dependenciesList"/><xsl:apply-templates select="node()"/><hr/><table border="0" cellpadding="0" width="100%"><tr><td colspan="1" rowspan="1">Last update : <xsl:value-of disable-output-escaping="no" select="@lastUpdate"/></td><td colspan="1" rowspan="1"><small><xsl:value-of disable-output-escaping="no" select="$copyright"/></small></td></tr></table></body></html></xsl:template><xsl:template name="dependenciesList"><ul><xsl:for-each select="dep:package"><li><xsl:choose><xsl:when test="count(dep:package)"><a href="#{@id}" shape="rect"><xsl:value-of disable-output-escaping="no" select="@name"/></a></xsl:when><xsl:otherwise><xsl:value-of disable-output-escaping="no" select="@name"/></xsl:otherwise></xsl:choose><xsl:if test="@fullName"> (<code><xsl:value-of disable-output-escaping="no" select="@fullName"/></code>)</xsl:if><xsl:if test="@dependsOn"> depends on <xsl:call-template name="dependenciesString"><xsl:with-param name="dependencies" select="@dependsOn"/></xsl:call-template></xsl:if></li></xsl:for-each></ul></xsl:template><xsl:template name="dependenciesString"><xsl:param name="dependencies"/><xsl:choose><xsl:when test="contains($dependencies, &quot; &quot;)"><xsl:call-template name="dependency"><xsl:with-param name="id" select="substring-before($dependencies, &quot; &quot;)"/></xsl:call-template>, <xsl:call-template name="dependenciesString"><xsl:with-param name="dependencies" select="substring-after($dependencies, &quot; &quot;)"/></xsl:call-template></xsl:when><xsl:otherwise><xsl:call-template name="dependency"><xsl:with-param name="id" select="$dependencies"/></xsl:call-template></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="dependency"><xsl:param name="id"/><i><xsl:value-of disable-output-escaping="no" select="id($id)/@name"/></i></xsl:template><xsl:template match="dep:package"><xsl:if test="count(dep:package)"><h3><xsl:call-template name="stack"/></h3><xsl:call-template name="dependenciesList"/><xsl:apply-templates select="node()"/></xsl:if></xsl:template><xsl:template name="stack"><small>/ <xsl:if test="name(..) = &quot;package&quot;"><xsl:call-template name="stackString"><xsl:with-param name="top" select=".."/></xsl:call-template> / </xsl:if></small><a id="{@id}" name="{@id}" shape="rect"><xsl:value-of disable-output-escaping="no" select="@name"/></a></xsl:template><xsl:template name="stackString"><xsl:param name="top"/><xsl:variable name="parent" select="$top/.."/><xsl:if test="name($parent) = &quot;package&quot;"><xsl:call-template name="stackString"><xsl:with-param name="top" select="$parent"/></xsl:call-template> / </xsl:if><a href="#{$top/@id}" shape="rect"><xsl:value-of disable-output-escaping="no" select="$top/@name"/></a></xsl:template></xsl:stylesheet>