<?xml version="1.0" encoding="utf-8"?>
<!--
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
    <xsl:if test="$depth > 0">
      <xsl:text>&#xA;</xsl:text>
      <xsl:call-template name="headingIndicator">
        <xsl:with-param name="count" select="$depth"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:text> </xsl:text>
    <xsl:choose>
      <xsl:when test="$depth = 0">
        <xsl:call-template name="tokenizeString">
          <xsl:with-param name="string" select="./@TEXT"/>
          <xsl:with-param name="delimiter" select="'\n'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="normalize-space(@TEXT)" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#xA;</xsl:text>
    <xsl:choose>
      <xsl:when test="richcontent">
        <xsl:apply-templates select="richcontent/html/body" mode="richtext" />
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="node" />
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

  <xsl:template name="tokenizeString">
    <!--passed template parameter -->
    <xsl:param name="string" />
    <xsl:param name="delimiter" />
    <xsl:choose>
      <xsl:when test="contains($string, $delimeter)">               
        <color>
          <!-- get everything in front of the first delimiter -->
          <xsl:value-of select="substring-before($string,$delimiter)"/>
        </color>
        <xsl:call-template name="tokenizeString">
          <!-- store anything left in another variable -->
          <xsl:with-param name="list" select="substring-after($string,$delimiter)"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$string = ''">
            <xsl:text/>
          </xsl:when>
          <xsl:otherwise>
            <color>
              <xsl:value-of select="$string"/>
            </color>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- TEMPLATE: hashes -->
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