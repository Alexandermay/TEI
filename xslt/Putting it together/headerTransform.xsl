<?xml version="1.0" encoding="UTF-8" ?>

<!-- Last update 2016-03-25 by Alex May-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.tei-c.org/ns/1.0">

    <xsl:output method="xhtml" doctype-public="-//W3C/DTD XHTML 1.0 STRICT//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" encoding="UTF-8"
        indent="yes"/>

    <!-- A variable which is our directory path (relative to the output document) to the
        directory containing full size JPEG document images.
    -->

    <xsl:variable name="thumbnail-dir">../images/thumb</xsl:variable>
    <xsl:variable name="jpeg-dir">../images</xsl:variable>

    <!-- A variable for inline notes in which we set its initial value at 0.
    -->
    <xsl:variable name="inline-notes">0</xsl:variable>

    <!-- Variables for counting -->

    <xsl:variable name="supplied_undefined" select="count(//supplied[@reason = 'undefined'])"/>
    <xsl:variable name="supplied_lost" select="count(//supplied[@reason = 'lost'])"/>
    <xsl:variable name="num_supplied" select="count(//supplied)"/>
    <xsl:variable name="high_cert" select="count(//supplied[@cert = 'high'])"/>
    <xsl:variable name="interpunct" select="count(//g[@type = 'interpunct'])"/>
    <xsl:variable name="text" select="string-length(//body/div[@type = 'edition'])"/>


    <!-- This template writes the entire document into an HTML page -->

    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//title"/>
                </title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <style type="text/css">
                    #header{
                        background-image: url(../images/site_header_top3.png);
                        background-repeat: no-repeat;
                        height: 115px;
                        width: 97.4%;
                        min-width: 905px;
                        max-width: 995px;
                        float: left;
                        margin: auto;
                        color: white;
                        background-color: #FFFFFE;
                        text-align: center;
                        border-bottom: 1px solid gray;
                    }
                    #mainnav{
                        font-size: 90%;
                        font-weight: bold;
                        font-family: Helvetica, Geneva, Arial, sans-serif;
                    }
                    #mainnav ul{
                        list-style-type: none;
                        margin-top: 95px;
                        margin-right: 0px;
                        margin-left: 255px;
                        margin-bottom: 0px;
                        padding-top: 0px;
                        overflow: hidden;
                        width: auto;
                        min-width: 225px;
                        max-width: 767px;
                    }
                    #mainnav li{
                        float: right;
                    }
                    #mainnav a:link,
                    #mainnav a:visited{
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
                    #mainnav a:hover{
                        color: #FFF;
                        background-color: #558097;
                    }
                    * html #mainnav a{
                        display: inline;
                    }
                    #gloss #mainnav li.gloss a:link{
                        background-color: #558097;
                        color: #000;
                    }
                    #bibliography #mainnav li.bibliography a:link{
                        background-color: #558097;
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
                    .note{
                        color: gray;
                    }
                    a:link{
                        color: #1b5dA9;
                    }
                    a:hover{
                        color: #000;
                    }
                    a:visited{
                        color: #505151;
                    }
                    <!-- jquerry -->
                    .demo { position:relative }
                    .loupe { background-color:#555; background:rgba(0, 0, 0, 0.25); border:2px solid rgba(0, 0, 0, 0); cursor:url(blank.png), url(blank.cur), none; }
                
                
                </style>

            </head>
            <body>
                <div id="wrapper">
                    <div id="content_wrapper">
                        <div id="header">
                            <!--This starts the header for the web page-->
                            <div id="mainnav">
                                <ul>
                                    <li class="bibliography">
                                        <a href="../output tree/Bibliography.html">Bibliography</a>
                                    </li>
                                    <li class="gloss">
                                        <a href="../output tree/Transcription.html"
                                            >Gloss</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div id="content_main">
                            <xsl:apply-templates select="TEI"/>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- Match our root element -->
    <xsl:template match="TEI">
        
        <!-- This apply-template writes the teiHeader into the top of the document -->
        
        <xsl:apply-templates select="//fileDesc/titleStmt/title"/>
        
        
        <!-- This apply-template writes the image facsimile into the document, after the header. -->
        
        <xsl:apply-templates select="facsimile"/>

        <!-- This apply-template writes the teiHeader into the top of the document -->
        
        <xsl:apply-templates select="*//msItem"/>
        

        <xsl:apply-templates select="*//physDesc"/>
        
        
        
        
    </xsl:template>

    <!-- Suppress from view these tei elements for project editing -->

    <xsl:template match="tei:fileDesc/tei:publicationStmt"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msContents/tei:textLang"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:handDesc"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:decoDesc"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:provenance"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:listBibl"/>
    <xsl:template match="tei:encodingDesc"/>
    <xsl:template match="tei:profileDesc"/>
    <xsl:template match="tei:revisionDesc"/>
    <xsl:template match="//body"/>
    <xsl:template match="tei:body/tei:div[@type = 'bibliography']"/>

    <!-- Display these tei elements -->

    <xsl:template match="//title">
        <h3 class="center">
            <i>
                <xsl:apply-templates/>
            </i>
        </h3>
    </xsl:template>

    <xsl:template match="//msItem">
        <p>
            <b>Contents: </b>
            <br/>
            <br/>
            <xsl:apply-templates/>
        </p>
        <br/>
    </xsl:template>

    <xsl:template match="//support/p">
        <p>
            <b>Summary of Support: </b>
            <br/>
            <br/>
            <xsl:apply-templates/>
        </p>
        <br/>
    </xsl:template>

    <xsl:template match="//height">
        <p><b>Height: </b><xsl:apply-templates/> cm</p>
    </xsl:template>

    <xsl:template match="//width">
        <p><b>Width: </b><xsl:apply-templates/> cm</p>
    </xsl:template>

    <xsl:template match="//depth">
        <p><b>Depth: </b><xsl:apply-templates/> cm</p>
        <br/>
    </xsl:template>

    <xsl:template match="//supportDesc/condition/p">
        <p>
            <b>Condition: </b>
            <xsl:apply-templates/>
        </p>
        <br/>
    </xsl:template>

    <xsl:template match="//layoutDesc/layout/p">
        <p>
            <b>Layout: </b>
            <xsl:apply-templates/>
        </p>
        <br/>
    </xsl:template>

    <xsl:template match="//history/origin/date">
        <b>Date: </b>
        <xsl:apply-templates/>
        <br/>
    </xsl:template>

    <xsl:template match="//history/origin/placeName">
        <b>Place: </b>

        <a href="{.//@select}" target="_blank">
            <xsl:apply-templates/>
        </a>

        <br/>

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

   
</xsl:stylesheet>
