<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    >
  
  <xsl:template match="lg">
    <html>
      <head>
        <title>a poem</title>
      </head>
      <xsl:apply-templates select="*except byline"/>
    </html>
  </xsl:template>
  
  <!-- Lets kill Ogden off, here is one way<xsl:apply-templates select="* except byline"/>-->
  
  <xsl:template match="l">
    <p>
      <xsl:apply-templates/>
    </p>        
  </xsl:template>
   
  <xsl:template match="byline">
    <p style="text-indent:50px">
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <!--Note our order here-->
  <xsl:template match="opener">
    <h2><xsl:apply-templates/></h2>
  </xsl:template>
  
</xsl:stylesheet>
