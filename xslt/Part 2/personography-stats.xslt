<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template match="TEI">
    <html>
      <head>
        <title>personography info</title>
      </head>
      <body>

        <p>There are <xsl:value-of select="count(* )"/> imeditate child nodes.</p>
        <p>There are <xsl:value-of select="count(descendant::*)"/> number of descendant nodes.</p>
        <p>There are <xsl:value-of select="count( //person )"/> people listed.</p>

        <p>Of those, <xsl:value-of select="count(//person[@role='author'])"/> are authors
          and <xsl:value-of select="count(//person[@role='ruler'])"/> are rulers.</p>

        <p>That is, our sample consists of
          <xsl:value-of select="round( 100 * count(//person[@role='author']) div count(//person) )"/>%
          authors and
          <xsl:value-of select="round( 100 * count(//person[@role='ruler']) div count(//person) )"/>%
          rulers.</p>
        
        <p>Of those people, <xsl:value-of select="count( //person[ not( death ) ] )"/> are still alive.</p>
        <p>That is, <xsl:value-of select="count( //person[ death ] )"/> have verified death dates.</p>
        <p>Our last person in our personography is <xsl:value-of select="//person[last()]/persName/forename"/><xsl:text> </xsl:text><xsl:value-of select="//person[last()]/persName/surname"/></p>
        <h3>Who, exactly, is in our document:</h3>
      <xsl:for-each select="//person">
        <li><xsl:value-of select="persName/forename"/> <xsl:text> </xsl:text><xsl:value-of select="persName/surname"/> is number <xsl:value-of select="position()"/> of <xsl:value-of select="last()"/></li>
      </xsl:for-each>
        
        <h3>How many Stuarts?</h3>
        <xsl:for-each select="//person[contains(persName/surname,'Stuart')]">
          <li><xsl:value-of select="."/><xsl:text>(</xsl:text><xsl:value-of select="birth/@when"/><xsl:text>-</xsl:text><xsl:value-of select="death/@when"/><xsl:text>)</xsl:text></li>
        </xsl:for-each>
        
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
