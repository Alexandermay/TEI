<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

  <xsl:template match="paragraph">
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
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
