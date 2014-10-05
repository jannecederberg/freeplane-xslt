<?xml version="1.0" encoding="utf-8"?>
<!--
    MINDMAPEXPORTFILTER md;markdown Markdown
    (c) by Janne Cederberg, 2014
    This file is licensed under the GPL.
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink">
  
  <xsl:output method="text" indent="yes" />
  <xsl:strip-space elements="*" />

  <!-- xsl:template match="text(normalize-space()='')" / -->

  <!-- PREVENT DEFAULT OUTPUT (prevents whitespace between tags from leaking to output) -->
  <xsl:template match="text()" mode="richtext">
    <xsl:value-of select="normalize-space()" />
  </xsl:template>

  <xsl:template match="map">
    <xsl:apply-templates select="node" />
  </xsl:template>

  <xsl:template match="node">
    <xsl:variable name="depth">
      <xsl:apply-templates select=".." mode="depthMesurement"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$depth > 0">
        <xsl:text>&#xA;</xsl:text>
        <xsl:call-template name="headingIndicator">
          <xsl:with-param name="count" select="$depth"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space(@TEXT)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="tokenizeTitle">
          <xsl:with-param name="text" select="@TEXT" />
        </xsl:call-template>
        <!-- xsl:text>% </xsl:text>
        <xsl:value-of select="@TEXT" / -->
        <!-- xsl:call-template name="tokenizeString" mode="tokenizeTitle">
          <xsl:with-param name="list" select="@TEXT"/>
          <xsl:with-param name="delimiter" select="'&#xA;'" />
        </xsl:call-template -->
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#xa;</xsl:text>
    <xsl:choose>
      <xsl:when test="richcontent">
        <xsl:apply-templates select="richcontent/html/body" mode="richtext" />
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="node" />
  </xsl:template>

  <xsl:template name="tokenizeTitle">
    <xsl:param name="text" />
    <xsl:text>% </xsl:text>
    <xsl:choose>
      <xsl:when test="not(contains($text, '&#xa;'))">
        <xsl:value-of select="normalize-space($text)" />
        <xsl:text>&#xa;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="normalize-space(substring-before($text, '&#xa;'))" />
        <xsl:text>&#xa;</xsl:text>
        <xsl:call-template name="tokenizeTitle">
          <xsl:with-param name="text" select="substring-after($text, '&#xa;')" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="body" mode="richtext">
    <xsl:apply-templates select="*" mode="richtext" />
  </xsl:template>

  <!-- Don't process text() nodes for these - prevents unnecessary whitespace -->
  <xsl:template match="ul" mode="richtext">
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates select="li" mode="richtext" />
  </xsl:template>

  <xsl:template match="li" mode="richtext">
    <xsl:text>* </xsl:text>
    <!-- xsl:value-of select="normalize-space(.)" / -->
    <xsl:apply-templates select="*|text()" mode="richtext" />
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="a" mode="richtext">
    <xsl:text> [</xsl:text>
    <xsl:apply-templates select="node()|text()" mode="richtext" />
    <xsl:text>](</xsl:text>
    <xsl:value-of select="@href" />
    <xsl:text>)</xsl:text>
  </xsl:template>

  <xsl:template match="strong|b" mode="richtext">
    <xsl:text> **</xsl:text>
    <xsl:value-of select="." />
    <xsl:text>**</xsl:text>
  </xsl:template>

  <xsl:template match="em|i" mode="richtext">
    <xsl:text> *</xsl:text>
    <xsl:value-of select="." />
    <xsl:text>*</xsl:text>
  </xsl:template>
  
  <xsl:template match="code" mode="richtext">
    <!-- todo: skip the ` if inside a pre -->
    <xsl:text>`</xsl:text>
    <xsl:value-of select="." />
    <xsl:text>`</xsl:text>
  </xsl:template>

  <xsl:template match="p|div" mode="richtext">
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates select="*|text()" mode="richtext" />
    <xsl:text>&#xa;</xsl:text> <!-- Block element -->
  </xsl:template>

  <!-- TEMPLATE: headingIndicator -->
  <xsl:template name="headingIndicator">
    <xsl:param name="count" select="1"/>
    <xsl:if test="$count > 0">
      <xsl:text>#</xsl:text>
      <xsl:call-template name="headingIndicator">
        <xsl:with-param name="count" select="$count - 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- NODE TAG DEPTH MEASUREMENT -->
  <xsl:template match="node" mode="depthMesurement">
    <xsl:param name="depth" select=" '0' "/>
    <xsl:apply-templates select=".." mode="depthMesurement">
      <xsl:with-param name="depth" select="$depth + 1"/>
    </xsl:apply-templates>
  </xsl:template>
        
  <!-- MAP TAG DEPTH MEASUREMENT -->
  <xsl:template match="map" mode="depthMesurement">
    <xsl:param name="depth" select=" '0' "/>
    <xsl:value-of select="$depth"/>
  </xsl:template>
</xsl:stylesheet>