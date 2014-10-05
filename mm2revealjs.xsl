<?xml version="1.0" encoding="utf-8"?>
<!--
    MINDMAPEXPORTFILTER htm;html RevealJS presentation
    (c) by Janne Cederberg, 2014
    This file is licensed under the GPL.
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink">
  
  <xsl:output method="html" indent="no" cdata-section-elements="body" />
  <xsl:strip-space elements="*" />

  <!-- xsl:template match="text(normalize-space()='')" / -->

  <!-- PREVENT DEFAULT OUTPUT (prevents whitespace between tags from leaking to output) -->
  <!-- xsl:template match="text()" mode="richtext">
    <xsl:value-of select="normalize-space()" />
  </xsl:template -->

  <xsl:template match="map">
    <html>
    <head>
      <meta charset="utf-8" />
      <meta name="author" content="Janne Cederberg" />
      <title><xsl:value-of select="node/@TEXT" /></title>
      <meta name="apple-mobile-web-app-capable" content="yes" />
      <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
      <link rel="stylesheet" href="reveal.js-master/css/reveal.min.css" />
      <style type="text/css">code{white-space: pre;}</style>
      <link rel="stylesheet" href="reveal.js-master/css/theme/simple.css" id="theme" />
      <link rel="stylesheet" media="print" href="reveal.js-master/css/print/pdf.css" />
    </head>
    <body>
      <div class="reveal">
        <div class="slides">
          <xsl:apply-templates select="node" />
        </div>
      </div>

      <script src="reveal.js-master/lib/js/head.min.js"></script>
      <script src="reveal.js-master/js/reveal.min.js"></script>

      <script>
        // Full list of configuration options available here:
        // https://github.com/hakimel/reveal.js#configuration
        Reveal.initialize({
          controls: true,
          progress: true,
          history: true,
          center: true,
          theme: 'default', // available themes are in /css/theme
          transition: Reveal.getQueryHash().transition || 'default', // default/cube/page/concave/zoom/linear/fade/none

          // Optional libraries used to extend on reveal.js
          dependencies: [
            { src: 'reveal.js-master/lib/js/classList.js', condition: function() { return !document.body.classList; } },
            { src: 'reveal.js-master/plugin/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
            { src: 'reveal.js-master/plugin/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } },
            //{ src: 'reveal.js-master/plugin/search/search.js', async: true, condition: function() { return !!document.body.classList; }, }
            //{ src: 'reveal.js-master/plugin/remotes/remotes.js', async: true, condition: function() { return !!document.body.classList; } }
          ]});
      </script>
    </body>
    </html>
  </xsl:template>

  <xsl:template match="node">
    <xsl:variable name="depth">
      <xsl:apply-templates select=".." mode="depthMeasurement"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$depth > 0">
        <xsl:text>&#xA;</xsl:text>
        <section>
          <xsl:call-template name="headingTag">
            <xsl:with-param name="level" select="$depth"/>
            <xsl:with-param name="heading" select="@TEXT"/>
          </xsl:call-template>
          <xsl:choose>
            <xsl:when test="richcontent">
              <xsl:call-template name="myrichcontent" />
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates select="node" />
        </section>
      </xsl:when>
      <xsl:otherwise>
        <section>
        <xsl:call-template name="tokenizeTitle">
          <xsl:with-param name="heading" select="@TEXT" />
        </xsl:call-template>
        </section>
        <xsl:apply-templates select="node" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template name="tokenizeTitle">
    <xsl:param name="heading" select="'Default Title'" />
      <h1><xsl:value-of select="$heading"/></h1>
    <!-- xsl:choose>
      <xsl:when test="not(contains($text, '&#xa;'))">
        <h1><xsl:value-of select="normalize-space($text)" /></h1>
        <xsl:text>&#xa;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="normalize-space(substring-before($text, '&#xa;'))" />
        <xsl:text>&#xa;</xsl:text>
        <xsl:call-template name="tokenizeTitle">
          <xsl:with-param name="text" select="substring-after($text, '&#xa;')" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose -->
  </xsl:template>

  <xsl:template name="myrichcontent">
    <xsl:copy-of select="richcontent/html/body/child::*" />
  </xsl:template>

  <xsl:template match="richcontent/html/body" mode="richcontent">
    <xsl:copy-of select="." />
  </xsl:template>

  <xsl:template name="headingTag">
    <xsl:param name="level" select="'1'"/>
    <xsl:param name="heading" select="'Default Title'"/>
    <xsl:text disable-output-escaping="yes">&lt;h</xsl:text>
    <xsl:value-of select="$level" />
    <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    <xsl:value-of select="$heading"/>
    <xsl:text disable-output-escaping="yes">&lt;/h</xsl:text>
    <xsl:value-of select="$level" />
    <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
  </xsl:template>

  <!-- NODE TAG DEPTH MEASUREMENT -->
  <xsl:template match="node" mode="depthMeasurement">
    <xsl:param name="depth" select=" '0' "/>
    <xsl:apply-templates select=".." mode="depthMeasurement">
      <xsl:with-param name="depth" select="$depth + 1"/>
    </xsl:apply-templates>
  </xsl:template>
        
  <!-- MAP TAG DEPTH MEASUREMENT -->
  <xsl:template match="map" mode="depthMeasurement">
    <xsl:param name="depth" select=" '0' "/>
    <xsl:value-of select="$depth"/>
  </xsl:template>
</xsl:stylesheet>