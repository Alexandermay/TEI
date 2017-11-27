<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.opengis.net/kml/2.2" version="2.0"> 

  <!-- Read in the MME places.xml file (.../dev/manuscripts/emerson/data/places.xml) -->
  <!-- and write out a very simple KML file representation thereof -->
  <!-- Written 2012-12-01 by Syd Bauman, copylefted. -->
  <!-- Adapted 2016-03-22 by Alex May, for introduction to XSLT for classics students -->
  
  <!-- Set your variables here -->

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <kml>
      <xsl:apply-templates/>
    </kml>
  </xsl:template>

  <xsl:template match="teiHeader"/> <!-- Prune -->
  
  <xsl:template match="text">
    <Folder>
      <name><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/></name>
      <xsl:apply-templates select=".//listPlace"/> <!--start at text element and get all listPlace elements-->
    </Folder>
  </xsl:template>
  
  <xsl:template match="listPlace">
    <Folder>
      <name>place list #<xsl:value-of select="position()"/></name>
      <xsl:apply-templates select="place[location[@type='point']]"><!--Nesting predicates-->
        <xsl:sort select="concat( placeName[@type='parsed']/region, placeName[@type='parsed']/settlement )"/>
      </xsl:apply-templates>
    </Folder>
  </xsl:template>


  <xsl:template match="place">
    
    <!--I like this-->
    
    <Placemark>
      <name><xsl:apply-templates select="placeName[@type='editors']"/></name>
      <description><xsl:apply-templates select="note[@type='editors']"/> 
        <xsl:apply-templates select=".//ptr"/><a href="{.//@target}">Click for more on this description from: <xsl:value-of select=".//ptr/@type"/></a>.
      </description>
      <Point>
        <xsl:variable name="geo" select="normalize-space( location[@type='point'] )"/>
        <xsl:variable name="lat" select="substring-before($geo,' ')"/>
        <xsl:variable name="long" select="substring-after($geo,' ')"/>
        <coordinates><xsl:value-of select="$long"/>,<xsl:value-of select="$lat"/>,0</coordinates>
      </Point>
    </Placemark>
  </xsl:template>
  
</xsl:stylesheet>
