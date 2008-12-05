<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><!--This converts moleculizer-input into a tree-like HTML display--><!--in which each element and attribute name is a link to moleculizer documentation via cgi.--><!--This version of moleculizer2static-doc.xsl differs from the one in --><!--xmloperator/moleculizer/xsl in that it gets the URL for locating documentation--><!--as a parameter, instead of extracting it from a configuration file.--><xsl:param name="flat-doc-url"/><xsl:param name="caption"/><!--The mzr-tests.xsl transformer should be accessible with this path, since it's delivered in the same directory as this transformer?  xmloperator runs Xalan in the xsl file's directory?  Or, Xalan resolves document() relative to the xsl file's directory?--><xsl:include href="mzr-tests.xsl"/><xsl:template match="*"><xsl:param name="xpth"/><xsl:variable name="curpth" select="concat($xpth, name())"/><xsl:variable name="curpth-name"><xsl:call-template name="xpth-name"><xsl:with-param name="xpth" select="$curpth"/><xsl:with-param name="rest-pth" select="substring-after($curpth, '/')"/></xsl:call-template></xsl:variable><xsl:element name="li"><xsl:element name="a"><xsl:attribute name="href"><xsl:value-of select="concat($flat-doc-url, $curpth-name)"/></xsl:attribute><xsl:if test="@anchor-name"><xsl:attribute name="name"><xsl:value-of select="@anchor-name"/></xsl:attribute></xsl:if><xsl:element name="strong"><xsl:value-of select="name()"/></xsl:element></xsl:element><xsl:apply-templates mode="consistency" select="."/><xsl:if test="@*"><xsl:element name="table"><xsl:attribute name="border"><xsl:text>1</xsl:text></xsl:attribute><xsl:attribute name="cellpadding"><xsl:text>2</xsl:text></xsl:attribute><xsl:for-each select="@*"><xsl:variable name="attrpth" select="concat($curpth, &quot;/@&quot;, name())"/><xsl:variable name="attrpth-name"><xsl:call-template name="xpth-name"><xsl:with-param name="xpth" select="$attrpth"/><xsl:with-param name="rest-pth" select="substring-after($attrpth, '/')"/></xsl:call-template></xsl:variable><xsl:element name="tr"><xsl:attribute name="align"><xsl:text>center</xsl:text></xsl:attribute><xsl:element name="td"><xsl:element name="a"><xsl:attribute name="href"><xsl:value-of select="concat($flat-doc-url, $attrpth-name)"/></xsl:attribute><xsl:value-of select="name()"/></xsl:element></xsl:element><xsl:element name="td"><xsl:value-of select="."/></xsl:element></xsl:element></xsl:for-each></xsl:element></xsl:if><xsl:if test="*"><xsl:element name="ul"><xsl:apply-templates><xsl:with-param name="xpth" select="concat($curpth, '/')"/></xsl:apply-templates></xsl:element></xsl:if></xsl:element></xsl:template><xsl:template match="user-doc"><xsl:param name="xpth"/><xsl:element name="a"><!--Here, trying the concatenation of the anchor name and the url--><!--as the anchor's text.--><!--It seems as though one should not need to look at the XML model--><!--to find the name of the anchor, and hence to link from the wiki to --><!--the HTML version of the model.--><!--(This way of emitting the anchor text may not be legal,--><!--putting two text items where only one is permitted?)--><xsl:if test="@anchor-name"><xsl:attribute name="name"><xsl:value-of select="@anchor-name"/></xsl:attribute></xsl:if><xsl:if test="@anchor-href"><xsl:attribute name="href"><xsl:value-of select="@anchor-href"/></xsl:attribute></xsl:if><xsl:if test="@anchor-name"><xsl:text>(</xsl:text><xsl:value-of select="@anchor-name"/><xsl:text>) </xsl:text></xsl:if><xsl:value-of select="@anchor-href"/></xsl:element><xsl:if test="text()"><xsl:element name="p"><xsl:value-of select="text()"/></xsl:element></xsl:if></xsl:template><xsl:template match="/"><xsl:element name="head"><xsl:element name="title"><xsl:value-of select="$caption"/></xsl:element></xsl:element><xsl:element name="body"><xsl:element name="H1"><xsl:value-of select="$caption"/></xsl:element><xsl:element name="ul"><xsl:apply-templates><xsl:with-param name="xpth" select="'/'"/></xsl:apply-templates></xsl:element></xsl:element></xsl:template><xsl:template name="path-anchor-text"><xsl:param name="pth"/><xsl:choose><xsl:when test="contains($pth, '/')"><xsl:call-template name="path-anchor-text"><xsl:with-param name="pth" select="substring-after($pth, '/')"/></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="$pth"/></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="xpth-name"><xsl:param name="xpth"/><xsl:param name="rest-pth"/><!--I add '!' to both strings, assuming that this will never be in an element or attribute name, so that substring-before will find the substring before the LAST (and only) copy of rest-pth in xpth.  This fixes a bug that appeared when the last element name in the path matched a substring of the next-to-last element, such as in the path stub .../dump-streams/dump-stream.--><xsl:variable name="cur-pth" select="substring-before(concat($xpth, '!'), concat('/', $rest-pth, '!'))"/><xsl:variable name="next-rest-pth" select="substring-after($rest-pth, '/')"/><xsl:if test="$cur-pth"><xsl:text>_</xsl:text><xsl:call-template name="path-anchor-text"><xsl:with-param name="pth" select="$cur-pth"/></xsl:call-template></xsl:if><xsl:choose><xsl:when test="$next-rest-pth"><xsl:call-template name="xpth-name"><xsl:with-param name="xpth" select="$xpth"/><xsl:with-param name="rest-pth" select="$next-rest-pth"/></xsl:call-template></xsl:when><xsl:otherwise><xsl:text>_</xsl:text><xsl:call-template name="path-anchor-text"><xsl:with-param name="pth" select="$xpth"/></xsl:call-template><xsl:text>.html</xsl:text></xsl:otherwise></xsl:choose></xsl:template></xsl:stylesheet>