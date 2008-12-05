<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><!--Transforms a flattened schema-documentation file into a hierarchical table of contents.--><xsl:output method="html"/><xsl:param name="caption"/><xsl:param name="path-doc-url"/><xsl:template match="/"><xsl:element name="html"><xsl:element name="head"><xsl:element name="title"><xsl:value-of select="$caption"/></xsl:element></xsl:element><xsl:element name="body"><xsl:element name="H1"><xsl:value-of select="$caption"/></xsl:element><xsl:element name="ul"><xsl:apply-templates select="rng:grammar-doc/rng:start"><xsl:with-param name="xpth" select="'/'"/></xsl:apply-templates></xsl:element></xsl:element></xsl:element></xsl:template><xsl:template match="*"><xsl:param name="xpth"/><xsl:apply-templates select="*"><xsl:with-param name="xpth" select="$xpth"/></xsl:apply-templates></xsl:template><xsl:template match="rng:element"><xsl:param name="xpth"/><xsl:variable name="curpth" select="concat($xpth, @name)"/><xsl:element name="li"><xsl:element name="a"><xsl:attribute name="href"><xsl:value-of select="concat($path-doc-url, $curpth)"/></xsl:attribute><xsl:element name="strong"><xsl:value-of select="@name"/></xsl:element></xsl:element><xsl:if test="rng:attribute"><xsl:element name="table"><xsl:attribute name="border"><xsl:text>1</xsl:text></xsl:attribute><xsl:attribute name="cellpadding"><xsl:text>2</xsl:text></xsl:attribute><xsl:for-each select="rng:attribute"><xsl:element name="tr"><xsl:attribute name="align"><xsl:text>center</xsl:text></xsl:attribute><xsl:element name="td"><xsl:element name="a"><xsl:attribute name="href"><xsl:value-of select="concat($path-doc-url, $curpth, '/@', @name)"/></xsl:attribute><xsl:value-of select="@name"/></xsl:element></xsl:element></xsl:element></xsl:for-each></xsl:element></xsl:if><xsl:if test="*"><xsl:element name="ul"><xsl:apply-templates select="*"><xsl:with-param name="xpth" select="concat($curpth, '/')"/></xsl:apply-templates></xsl:element></xsl:if></xsl:element></xsl:template><!--Remember that flattened schema-doc files still contain refs, just no includes.--><xsl:template match="rng:ref"><xsl:param name="xpth"/><xsl:variable name="ref-name" select="@name"/><xsl:apply-templates select="/rng:grammar-doc/rng:define[@name = $ref-name]"><xsl:with-param name="xpth" select="$xpth"/></xsl:apply-templates></xsl:template></xsl:stylesheet>