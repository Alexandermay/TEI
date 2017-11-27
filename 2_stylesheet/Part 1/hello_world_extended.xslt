<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

  <xsl:template match="/">
    <html>
      <head>
        <title>A Short Test Document</title>
      </head>
      <body>
        <div>
          
            <xsl:apply-templates/>
          
        </div>
      </body>
    </html>
  </xsl:template>

<xsl:template match="paragraph">
  <p>
    <xsl:apply-templates/>
  </p>
</xsl:template>
  
  
  <xsl:template match="parens">
    <xsl:text>(</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>)</xsl:text>
  </xsl:template>
  

</xsl:stylesheet>
