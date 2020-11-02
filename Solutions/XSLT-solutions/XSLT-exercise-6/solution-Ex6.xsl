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
    
    <xsl:variable name="dickinsonColl" select="collection('Dickinson')"/>
    
    <xsl:template match="/">
      <html>
          <head>
              <link rel="stylesheet" type="text/css" href="dickinsonStyle.css"/>
              <title>Emily Dickinson’s Fascicle 16</title></head>
          <body>
        
          <h1>Emily Dickinson’s Fascicle 16</h1>
             
               <div id="ContentsV">   <h2>Contents: Poems Sorted by Numbers of Variants</h2>
        <ul><xsl:apply-templates select="$dickinsonColl//body" mode="toc">
            <xsl:sort select="count(descendant::app)" order="descending"/>
     <!--2018-11-05 ebb: Here we are telling xsl:apply-templates to sort some nodes BEFORE sending them to be processed by template rules. 
         * We're sorting based on the count of <app> elements that mark variant passages in each of the poem files in the collection.  
         * We're sorting using order="descending" in order to get poems with high counts (= high numbers of variant passages) to be processed first.  Sorting based on a count() of something will sort based ascending values by default (alphabetical from A to Z, and low to high numbers). Descending will sort in reverse from Z to A, and high to low. 
     -->
        </xsl:apply-templates>
        </ul>
              <hr/>
          </div>
            
          <div id="ContentsA"> <h2>Contents: Poems Sorted Alphabetically by First Line</h2>
            <ul>
                <xsl:apply-templates select="$dickinsonColl//body" mode="toc">
                    <xsl:sort order="ascending">
                        <xsl:variable name="apos">'</xsl:variable>
                        <xsl:value-of select="translate(descendant::lg[1]/l[1], $apos, '')"/>
                    </xsl:sort>
                    <!--ebb: Here we open up the <xsl:sort> element to introduce a variable and a calculation with <xsl:value-of> so that we can translate the apostrophe out of our sort. The apostrophe doesn't go away; it just is translated during the sort to be no character at all, so the sorting proceeds on the next character. -->
                </xsl:apply-templates>
            </ul>
          <hr/></div>
          <div id="main">
             <xsl:apply-templates select="$dickinsonColl//body"/>

          </div>
          
          </body>
          
      </html>
    </xsl:template>
    

    
    <xsl:template match="body" mode="toc">
       <li><a href="#p{//idno}">
           <!--ebb: XPATH! We could also write this ATV like so:
           <a href="#p{ancestor::TEI//idno}">...
           Think about why each of these works to reach the <idno> element from <body>. But it would NOT work to use the descendant:: axis here (why not)? 
           -->
           <!--ebb: We used an Attribute Value Template (AVT) here to construct the @href that our internal links need to target so we can jump to each poem. Notice, the <idno> element is up in the teiHeader and not inside the body element, so this is one case where we actually DO want to begin our XPath from the document node. 
               We used nearly same AVT in the next template rule with the mode set to output full poems, in order to generate @id attributes that serve as the targets for our links. The difference here is that we need a hashtag (#) to start the @href that points to the @id (which has no hashtag) in order to make the internal links work to keep us jumping on the same HTML page. (Without the hashtag, a web browser thinks these links refer to new files that it won't be able to find.)-->
           <strong><xsl:apply-templates select="descendant::title"/></strong></a>: 
           <xsl:apply-templates select="lg[1]/l[1]"/><xsl:text> [Variants: </xsl:text><xsl:value-of select="count(descendant::rdg)"/><xsl:text>]</xsl:text>
       </li>
    </xsl:template>

    <xsl:template match="body">
      <h2 id="p{//idno}">
          <!--ebb: We used an Attribute Value Template (AVT) here (above) to construct the @id that our internal links need to target so we can jump to each poem. We used nearly the same AVT up in the table of contents divs to create the @href attributes. The only difference is that this one contains the simple @id with no hashtag.-->
          <xsl:apply-templates select="substring-before(descendant::title, '(') ! replace(., '\.', '')"/>
          </h2>
        <!--ebb: (above): This was the OPTIONAL CHALLENGE to make the poem titles appear more consistent on the website than the way the were entered in the source XML. 
            * Here I am selecting only the part of the title that gives Poem and its number, and I am discarding the stuff in parentheses about its later publication if it ever shows up. (See 1604variant.xml in the Dickinson collection for an example of this.) 
            * Because I noticed that one of the poems has a stray period after its number, I am replacing the period with nothing. Since replace() looks for regular expressions, I needed the backslash to look for a literal period and escape the regex "." which would otherwise mean *any* character. If I run this without the backslash character, I don't output a title at all because I'm asking for all the characters in the title to be replaced with nothing. 
    Consider: Where else could we use this replace() function in this XSLT?
        -->
       <xsl:apply-templates select="descendant::lg"/>
        
    </xsl:template>
    
    <xsl:template match="lg">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="l">
        <xsl:value-of select="count(preceding::l) + 1"/><xsl:text>: </xsl:text><xsl:apply-templates/>
        <xsl:if test="following-sibling::l"><br/></xsl:if>
    </xsl:template>
    
    <xsl:template match="rdg">
        <span class="{@wit}"><xsl:apply-templates/></span>
    </xsl:template>

</xsl:stylesheet> 
