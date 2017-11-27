<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xpath-default-namespace="http://www.alex.org/authors/"
  xmlns:book="http://www.may.edu/books"
  xmlns="http://www.w3.org/1999/xhtml">
<xsl:template match="/">
    <html>
      <body>
        <div>
          <h1>
            <xsl:apply-templates select="//last_name"/>, <xsl:apply-templates select="//first_name"/>.
          </h1>
          <p>
          <xsl:apply-templates/>
          </p>
        </div>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="last_name">
    <b>
      <xsl:apply-templates/>
    </b>
  </xsl:template>
  <xsl:template match="first_name">
    <b>
      <xsl:apply-templates/>
    </b>  
  </xsl:template>
  <xsl:template match="book:title">
 <xsl:text>wrote the stories in this book: </xsl:text>
    <em><xsl:apply-templates/></em>,
  </xsl:template>
  <xsl:template match="book:publisher">
    <xsl:text>which was published by </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="book:date">
    <xsl:text>in </xsl:text>
    <xsl:apply-templates/>,
  </xsl:template>
  <xsl:template match="date"/>
  <xsl:template match="id"/>
 <xsl:template match="book:id">
    <xsl:text>and can usually be found in your library at this call number: </xsl:text>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@ptr"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  <xsl:template match="book:contributor">
    <em><xsl:apply-templates/></em>
  </xsl:template>
  <xsl:template match="book:subject">
    <xsl:text>and is frequently grouped with other books by him under this subject: </xsl:text>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@ptr"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a> 
  </xsl:template> 
  <xsl:template match ="book:cover[@ptr]" name="cover">
    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="@ptr"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </img>  
  </xsl:template>
</xsl:stylesheet>
