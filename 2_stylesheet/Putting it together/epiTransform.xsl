<?xml version="1.0" encoding="UTF-8" ?>

<!-- Last update 2016-04-10 by Alex May-->

<!-- Namespace: think of this as  way to disambiguate terms  the key element you need is the xpath-default-namespace -->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.tei-c.org/ns/1.0">

<!-- Output as xhtml -->
    <xsl:output method="xhtml" doctype-public="-//W3C/DTD XHTML 1.0 STRICT//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" encoding="UTF-8"
        indent="yes"/>

    <!-- A variable which is our directory path (relative to the output document) to the
        directory containing the thumb and full size JPEG document images.
    -->

    <xsl:variable name="thumbnail-dir">../images/thumb</xsl:variable>
    <xsl:variable name="jpeg-dir">../images</xsl:variable>

    <!-- A variable for inline notes in which we set its initial value at 0.
    -->
    <xsl:variable name="inline-notes">0</xsl:variable>
    
    <!-- Variables for counting our content -->
    
    <xsl:variable name="supplied_undefined" select="count(//supplied[@reason='undefined'])"/>
    <xsl:variable name="supplied_lost" select="count(//supplied[@reason='lost'])"/>
    <xsl:variable name="num_supplied"  select="count( //supplied )"/>
    <xsl:variable name="high_cert" select="count( //supplied[@cert='high'] )"/>
    <xsl:variable name="interpunct" select="count(//g[@type='interpunct'])"/>
    <xsl:variable name="apex" select="count(.//hi[@rend='apex'])"/>
    <xsl:variable name="text" select="string-length(translate(.//div[@type='edition']/ab,'&#x20;&#x9;&#xD;&#xA;',''))"/>
    <xsl:variable name="note" select="string-length(normalize-space(.//div[@type='edition']/ab/note))"/>
      

    <!-- This template writes the entire document into an HTML page -->


<!-- We are matching the root, if there is a root, then we are going to input some literal content, in this case, some html  -->
    <xsl:template match="/">
        <html>
            <head>              
                <title>
                    <xsl:value-of select=".//title"/>
                </title>
                
                <!-- In-line CSS for our web page -->
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <style type="text/css">
                    #header {
                    background-image:url(../images/site_header_top3.png);
                    background-repeat:no-repeat;
                    height: 115px;
                    width:97.4%;
                    min-width:905px;
                    max-width:995px;
                    float:left;
                    margin: auto;
                    color:white;
                    background-color:#FFFFFE;
                    text-align: center;
                    border-bottom:1px solid gray;
                    }
                    #mainnav {
                    font-size: 90%;
                    font-weight:bold;
                    font-family: Helvetica, Geneva, Arial, sans-serif;
                    }
                    #mainnav ul {
                    list-style-type: none;
                    margin-top: 95px;
                    margin-right:0px;
                    margin-left: 255px;
                    margin-bottom:0px;
                    padding-top:0px;
                    overflow:hidden;
                    width:auto;
                    min-width:225px;
                    max-width:767px;
                    }
                    #mainnav li {
                    float:right;
                    }
                    #mainnav a:link, #mainnav a:visited {
                    display: inline;
                    padding: 0.5em 1.5em 0.5em 1.5em;
                    color: #FFF;
                    background-color: #000;
                    text-decoration: none;
                    border-top: 0px;
                    border-right: 2px solid white;
                    border-left: 0px;
                    border-bottom: 1px solid #b4b4b4;
                    }
                    #mainnav a:hover {
                    color: #FFF;
                    background-color: #558097;
                    }
                    * html #mainnav a {
                    display:inline;
                    }
                    #about #mainnav li.about a:link {
                    background-color:#558097;
                    color: #000;
                    }
                    #bibliography #mainnav li.bibliography a:link {
                    background-color:#558097;
                    color: #000;
                    }                    
                    body{
                        background: #ffffff;
                        font-size: 85%;
                        font-family: Helvetica, Geneva, Arial, sans-serif;
                        color: #363636;
                        margin: auto;
                        line-height: 1.33em
                    }
                    h1{
                        font-size: 185%;
                        color: #000000;
                        font-weight: bold;
                        line-height: 1.7em;
                        margin: 0px;
                        padding: 0px;
                    }
                    h2{
                        font-size: 140%;
                        color: #484848;
                        text-transform: uppercase;
                        font-weight: bold;
                        line-height: 1.6em;
                        margin: 0px;
                        padding: 0px;
                    }
                    h3{
                        font-size: 125%;
                        color: #484848;
                        font-weight: bold;
                    }
                    h4{
                        font-size: 115%;
                        color: #101010;
                        font-weight: bold;
                        margin: 0px;
                        padding: 0px;
                    }
                    h5{
                        font-size: 105%;
                        color: #383838;
                        font-weight: bold;
                        margin: 0px;
                        padding: 0px;
                    }
                    h6{
                        font-size: 100%;
                        color: #404040;
                        font-weight: bold;
                        margin: 0px;
                        padding: 2px 0px;
                    }
                    #wrapper{
                        /* float: left; */
                        width: 55%;
                        min-width: 805px;
                        max-width: 860px;
                        margin: auto;
                    }
                    #content_main{
                        display: block;
                        float: left;
                        width: 86%;
                        padding-left: 25px;
                        margin: auto;
                    }
                    .shrinktofit{
                        width: 45%
                    }
                    .center{
                        text-align: center;
                    }
                    p{
                        margin-top: .25em;
                        margin-bottom: .25em;
                    }
                    hr{
                        color: #888833;
                    }
                    
                    <!--The .class selector selects elements with a specific class attribute. To select elements with a specific class, write a period (.) character, followed by the name of the class.-->
                    .note{
                        color: gray;
                    }
                    a:link {
                    color:#1b5dA9;
                    }
                    a:hover {
                    color:#000;
                    }
                    a:visited {
                    color:#505151;
                    }
                    
                   <!-- jQuerry  specific class selector-->
                    .demo { position:relative }
                    .loupe { background-color:#555; background:rgba(0, 0, 0, 0.25); border:2px solid rgba(0, 0, 0, 0); cursor:url(blank.png), url(blank.cur), none; }
                    
                </style>  
            </head>
            <body>
                <div id="wrapper">
                    <div id="content_wrapper">
                        <div id="header"><!--This starts the header for the web page-->
                            <div id="mainnav">
                                <ul>      
                                    <li class="bibliography"><a
                                        href="../output tree/Bibliography.html"
                                        >Bibliography</a></li>
                                    <li class="about"><a
                                        href="../output tree/About.html"
                                        >About</a></li>  
                               </ul>
                            </div>
                        </div>
                        <div id="content_main">
                            <xsl:apply-templates />
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- Now lets fill it all in -->

    <!-- Match our root element -->
    <xsl:template match="TEI">
        
        <xsl:apply-templates select="teiHeader"/>
       
        <!-- This apply-template writes the image facsimile into the document, after the header. -->

        <xsl:apply-templates select="facsimile"/>
      

        <!-- This apply-template writes the text itself into the document, after the facsimile. -->

        <xsl:apply-templates select="//text"/>

        <xsl:if test="$inline-notes = 0">
            <hr/>
            <b>Notes</b>
            <xsl:apply-templates select="//note" mode="endnote"/>
        </xsl:if>
    
    </xsl:template>

    <!-- Suppress from view these tei elements for project editing -->

    <xsl:template match="fileDesc/publicationStmt"/>
    <xsl:template match="fileDesc/sourceDesc/msDesc/msIdentifier"/>
    <xsl:template match="fileDesc/sourceDesc/msDesc/msContents/textLang"/>
    <xsl:template match="fileDesc/sourceDesc/msDesc/physDesc/handDesc"/>
    <xsl:template match="fileDesc/sourceDesc/msDesc/physDesc/decoDesc"/>
    <xsl:template match="fileDesc/sourceDesc/msDesc/history/provenance"/>
    <xsl:template match="fileDesc/sourceDesc/listBibl"/>
    <xsl:template match="encodingDesc"/>
    <xsl:template match="profileDesc"/>
    <xsl:template match="revisionDesc"/>
    <xsl:template match="body/div[@type = 'bibliography']"/>
    <xsl:template match="//msDesc"/>
    <xsl:template match="//sourceDesc"/>
      
   
   <!-- Display these tei elements -->

    <xsl:template match="//title">
        <h3 class="center">
            <i>
                <xsl:apply-templates/>
            </i>
        </h3>
    </xsl:template>

    
   <!-- facsimile display -->

    <xsl:template match="//facsimile">
        <p class="center">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="//graphic">
        <span>
            <a  class="demo" href="{$jpeg-dir}/{@url}.jpg">
                <img src="{$thumbnail-dir}/{@url}.jpg" class="shrinktofit" />
            </a>
        </span>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
        <script type="text/javascript" src="../jquery/jquery.loupe.min.js"></script>
        <script type="text/javascript">$('.demo').loupe();</script>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Body -->

    <xsl:template match="//body">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Div  -->

    <xsl:template match="./div[@type = 'edition']">
        <b>Transcription: </b>
        <xsl:apply-templates/>
        <br/>
        <b>What these colors mean:</b>
        <br/>
        <br/>
        <p style="color:#BDBDBD">[This is supplied text]</p>
        <p style="color:#FF8000">This is damaged text</p>
        <p style="color:#2E9AFE">This is a personal name</p>
        <br/>
    </xsl:template>

    <xsl:template match="//body/div[@type = 'commentary']">
        <b>Commentary: </b>
        <br/>
        <br/>
        <xsl:apply-templates/>
        <br/>
    </xsl:template>

    <xsl:template match="//body/div[@type = 'translation']">
        <b>Translation: </b>
        <br/>
        <br/>
        <xsl:apply-templates/>
        <br/>
        <br/>
        <b>Some interesting facts about our document: </b>
        <br/>
        <br/>
        <p>There are <xsl:value-of select="$num_supplied"/> editor supplied additons.</p>
        
        <xsl:choose>
            <xsl:when test="$supplied_lost lt 2">
                <p>Of those, <xsl:value-of select="$supplied_lost"/> is a lost element;</p>                
            </xsl:when>
            <xsl:otherwise>
                <p>Of those, <xsl:value-of select="$supplied_lost"/> are lost elements;</p>    
            </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="$supplied_undefined lt 2">
                <p> and <xsl:value-of select="$supplied_undefined"/> is an undefined element.</p>  
            </xsl:when>
            <xsl:otherwise><p> and <xsl:value-of select="$supplied_undefined"/> are undefined elements.</p></xsl:otherwise>
        </xsl:choose>
        
        <p>That is, our sample consists of
            <xsl:value-of select="100 * $supplied_lost div $num_supplied "/>%
            lost elements and
            <xsl:value-of select="round( 100 * $supplied_undefined div $num_supplied )"/>%
            undefined elements.  Of these supplied elements our editor felt that <xsl:value-of select="$high_cert"/> were of high certainty.</p>
        <p>There are <xsl:value-of select="$text - $note + $apex"/> total characters.</p>
        <p>Of those, <xsl:value-of select="$interpunct"/> are interpuncts and <xsl:value-of select="$apex"/> are apexes.</p>
        <p>Which means that <xsl:value-of select="round(100 * $interpunct div ($text - $note + $apex)) "/>% are interpuncts and <xsl:value-of select="round(100 * $apex div ($text - $note + $interpunct))"/>% are apexes!</p>
        <xsl:if test="round(100 * $interpunct div $text) gt 17">
           <p>(Clearly our inscriber loved interpuncts)</p> 
        </xsl:if>
        <br/>
        <br/>
    </xsl:template>

   
    <!-- P and AB -->

    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="ab">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- LINE BEGININGS -->

    <xsl:template match="lb">
        <br/><xsl:apply-templates/> [Line <xsl:number/>] &#160;&#160;&#160;&#160;&#160;&#160; </xsl:template>

    <!-- TRANSCRIPTION -->

    <xsl:template match="damage">
        <span style="color: #ff8000;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="persName">
        <span style="color: #2E9AFE;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- FORM AND APPEARANCE -->

    <xsl:template match="g[@type = 'interpunct']"> &#183; </xsl:template>

    <xsl:template match="hi[@rend = 'apex']"> &#769;<xsl:apply-templates/>
    </xsl:template>

    <!-- EDITORIAL INTERVENTIONS -->

    <xsl:template match="supplied">
        <span style="color: #bdbdbd;">[<xsl:apply-templates/>] </span>
    </xsl:template>

    <xsl:template match="ex">
        <span style="color: #bdbdbd;">(<xsl:apply-templates/>) </span>
    </xsl:template>

    <!-- Annotations -->

    <xsl:template match="note">
        <xsl:choose>
            <xsl:when test="$inline-notes != 0">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                    <sup>
                        <xsl:value-of select="index-of(//body/note, .)"/>
                    </sup>               
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//note" mode="endnote">
        <p>
            <xsl:value-of
                select="index-of(//note, .)"/>.&#160;&#160;
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- LINKS -->

    <xsl:template match="//ref">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="@rend"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="//ptr">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="@rend"/>
            </xsl:attribute>
            <xsl:value-of select="@target"/>
        </a>
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>

