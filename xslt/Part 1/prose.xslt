<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:output method="xhtml" indent="yes"/>

  <xsl:template match="TEI">
    <html>
      <xsl:apply-templates/>
    </html>
  </xsl:template>
  
  

  <xsl:template match="teiHeader">
    <head>
      <title>A Short Text Encoding Experiment</title>
    </head>
  </xsl:template>

  <xsl:template match="text">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="front"/>

  <xsl:template match="body">
    <body>
      <xsl:apply-templates/>
    </body>
  </xsl:template>
  
  <xsl:template match="body/head">
    <h1><xsl:apply-templates/></h1>
  </xsl:template>

  <xsl:template match="div/head">
    <h2><xsl:apply-templates/></h2>
  </xsl:template>

  <xsl:template match="p">
    <p><xsl:apply-templates/></p>
  </xsl:template>
  
  <xsl:template match=" emph | foreign ">
    <em><xsl:apply-templates/></em>
  </xsl:template>
  
</xsl:stylesheet>
