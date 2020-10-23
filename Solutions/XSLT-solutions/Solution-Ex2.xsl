<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <html>
            <head> 
                <title>Digital Mitford Organizations</title>
            </head> 
            <body>
                <h1>Organizations Referenced in the Digital Mitford Project</h1>
                <ol>
                    <xsl:apply-templates select="descendant::listOrg"/>
                </ol>  
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="listOrg">
        <li>
            <xsl:apply-templates select="descendant::head"/><!-- RJP: Consider why select="head" (or select="child::head",  select="descendant::head" or select=".//head") all work here but select="//head" does not. -->
            <ul><!--ebb: Here is how we set up a NEW list to nest inside *each* list item of the outer list -->
              <xsl:apply-templates select="child::org"/>
            </ul>
        </li>
    </xsl:template>
    
    <xsl:template match="org">
       <li><xsl:apply-templates select="orgName[1]"/></li>
        <!--ebb: We need to isolate the orgName child of org, so this could be written as select="child::orgName[1]". Why the [1]? In some cases we have multiple names listed for an organization, so the output will bunch these all together. To simplify matters for this exercise, we are just listing the first one, which is the best known organization name, using a [1].  
            Alternatively, we could string-join() these together with a white space, but we need to change from <xsl:apply-templates> to <xsl:value-of> because <xsl:apply-templates> must refer only to a node on the XML tree to process next. When we use <xsl:value-of> we refer to a calculation, the result of an XPath function that takes us OFF the tree. So if we wanted to string-join all the orgName values together, we'd use:
    <li><xsl:value-of select="string-join(orgName, ', ')"/></li>
        -->
      
    </xsl:template>
</xsl:stylesheet>
