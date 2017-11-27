<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
  <xsl:template match="/">
    <html>
      <head>
        <title>A Short Test Document</title>
      </head>
      <body>
        <div>
          <p>
            <xsl:apply-templates/>
          </p>
        </div>
        <div>
          <h3>Some facts about our sample mark-up:</h3>
          <p>In our doucument there are <xsl:value-of select="count(//reg)"/> abreviations that have been regularized;
            <xsl:value-of select="count(//name[@type='person'])"/> references to persons; and <xsl:value-of select="count(//title)"/> references to titles of works.</p>
          <p>The last work listed is: <xsl:value-of select="descendant::title[last()]"/>.</p>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="teiHeader"/>
  <xsl:template match="orig"/>
<!--here we match and process p elements-->
  <xsl:template match="p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <!--here we match and process title elements, and give it a little color-->
  <xsl:template match="title">
    <em color="blue">
      <xsl:apply-templates/>
    </em>
  </xsl:template>
  <!--here we match and process name elements with an attribute of type and an attribute value of person, and give it a little color-->
  <xsl:template match="//name">
    <a color = "red">
      <xsl:attribute name="href">
        <xsl:value-of select="@ref"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  <xsl:template match="reg">
    <b><xsl:apply-templates/></b>
  </xsl:template>
  <xsl:template match="ref">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@target"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  <xsl:template match="title[@ref]">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@target"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
</xsl:stylesheet>
