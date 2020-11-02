<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:variable name="dickinsonColl" select="collection('Dickinson/?select=*.xml')"/>
    
    <xsl:template match="/">
    <html>
        <head></head>
        <body>
            <h1>Amelia FitzDickens, Fasciculus XVI</h1>
            <h2>Table des matières</h2>
            <h3>Sorted alphabetically by first line of poem:</h3>
            <ul>
    <xsl:apply-templates select="$dickinsonColl//body" mode="toc">
        <xsl:sort select="(descendant::lg/l)[1]"/>
    </xsl:apply-templates>
            </ul>
            <h3>Sorted based on counts of variants in the poems:</h3>
            
            <ul>
                <xsl:apply-templates select="$dickinsonColl//body" mode="toc">
                    <xsl:sort select="count(descendant::app)" order="descending"/>
                </xsl:apply-templates>
            </ul>
            
           
            <hr/>
            <div id="main">
                <xsl:apply-templates select="$dickinsonColl//body"/>
                            </div>
        </body>
    </html>
    </xsl:template>
    
    <!-- I got most of this, but didn't manage to strip the poems themselves out of the TOC. -->
    
    <xsl:template match="body" mode="toc">
        <li><a href="#p{//idno}"><xsl:apply-templates select="descendant::title" mode="toc"/></a>
            <xsl:text>: </xsl:text><ul>
            <li><xsl:apply-templates select="(descendant::lg/l)[1]" mode="toc"/></li>
            <li>Count of variants: <xsl:value-of select="count(descendant::app)"/></li>
            
            </ul>
        </li>
    </xsl:template>
    
   
    <xsl:template match="title">
        <h2 id="p{//idno}"><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="title" mode="toc">
        <b><xsl:apply-templates/></b>
    </xsl:template>
    
    <xsl:template match="l">
        <xsl:apply-templates/><br/>
    </xsl:template>
    
    <xsl:template match="l" mode="toc">
       <span class="toc-line"><xsl:apply-templates/></span>
    </xsl:template>
 
    
</xsl:stylesheet>