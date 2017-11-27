<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template match="TEI">
    <html>
      <head>
        <title>Persons!</title>
      </head>
      <body>
        <div>
          <h1>
            <xsl:apply-templates select="descendant::titleStmt"/>
          </h1>
        </div>
        <div>
          <h1>Authors</h1>
          <ol>
            <xsl:apply-templates select="/TEI/text/body/listPerson/person[@role = 'author']"/>
          </ol>
        </div>
        <div>
          <h1>Rulers</h1>
          <ol>
            <xsl:apply-templates select="/TEI/text/body/listPerson/person[@role = 'ruler']"/>
          </ol>
        </div>
        <div>
          <h3 color="4682b4">An interesting fact about our document:</h3>
          <p>There are <xsl:value-of select="count(descendant::*)"/> number of descendant nodes.</p>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="person">
    <li>
      <xsl:value-of select="persName/forename"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="persName/surname"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="birth/@when"/>
      <xsl:text>–</xsl:text>
      <xsl:value-of select="death/@when"/>
      <xsl:text>)</xsl:text>
      <br/>
    </li>
  </xsl:template>
 
</xsl:stylesheet>
