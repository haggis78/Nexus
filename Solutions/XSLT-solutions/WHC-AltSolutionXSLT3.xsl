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
<!--WHC: This is an alternate solution using only a singe long template rule with xsl:for-each instead of one template rule for the html structure that calls to three other tempalte rules lower down for the table data. Both versions give identical html outputs.-->    
    <xsl:template match="/">
        <html>
            <head><title>Sanitary Conditions of Workshops and Factories in New York City</title></head>
            <body>
                <h1>Sanitary Conditions of Workshops and Factories in New York City</h1>
                <h2>Table 1: Yes or No Questions</h2>
                <table>
                    <tr>
                        <th>Number</th>
                        <th>Question</th>
                        <th>Yes</th>
                        <th>Yes, but fined</th>
                        <th>No</th>
                        <th>Blank</th>
                        <th>Total Responses</th>
                    </tr>
                    <xsl:for-each select="descendant::fs[f[@select='Yes']]">
                        <tr>
                            <td><xsl:value-of select="count(preceding-sibling::fs[f[@select='Yes']]) + 1"></xsl:value-of></td>
                            <td><xsl:apply-templates select="descendant::string"/></td>
                            <td><xsl:value-of select="f[@select='Yes']/@n"/></td>
                            <td><xsl:value-of select="f[@select='Yes_but_fined']/@n"/></td>
                            <td><xsl:value-of select="f[@select='No']/@n"/></td>
                            <td><xsl:value-of select="f[@select='Blank']/@n"/></td>
                            <td><xsl:value-of select="sum(f/@n)"/></td>
                        </tr>
                    
                    </xsl:for-each>
                </table>
                <h2>Table 2: Sources of Offensive Odors</h2>
                <table>
                    <tr>
                        <th>Question</th>
                        <th>Water Closet</th>
                        <th>Other Sources</th>
                        <th>Total Responses</th>
                    </tr>
                    
                    <!--WHC: Used an xsl:for-each for table 2 as well, even though there's only one <tr> of <td>, to give the XPath expression to isolate the desired <fs> node for each question somewhere to live.-->
                    <!--WHC: Alternately, the XPath expression leading to each question/answer can be embedded in each line, without the xsl:for-each OR a new template rule for the table. I was able to get this to work in Table 3 but only for the string: I was not able to get it to work for the numerical values @n.:-->
                    
                    <xsl:for-each select="descendant::fs[f[@select='water_closet']]">
                    <tr>
                        <td><xsl:apply-templates select="descendant::string"/></td>
                        <td><xsl:value-of select="f[@select='water_closet']/@n"/></td>
                        <td><xsl:value-of select="f[@select='other_causes']/@n"/></td>
                        <td><xsl:value-of select="sum(f/@n)"/></td>
                    </tr>
                    </xsl:for-each>
                </table>
                
                <h2>Table 3: Standing or Sitting at Work</h2>
                <table>
                    <tr>
                       <th>Question</th>
                        <th>Sit</th>
                        <th>Stand</th>
                        <th>Optional</th>
                        <th>Blank</th>
                        <th>Total Responses</th>
                    </tr>

                    <xsl:for-each select="descendant::fs[f[@select='Sit']]">
                    <tr>
                        <td><xsl:apply-templates select="descendant::string"/></td>
                        <td><xsl:value-of select="f[@select='Sit']/@n"/></td>
                        <td><xsl:value-of select="f[@select='Stand']/@n"/></td>
                        <td><xsl:value-of select="f[@select='Optional']/@n"/></td>
                        <td><xsl:value-of select="f[@select='Blank']/@n"/></td>
                        <td><xsl:value-of select="sum(f/@n)"/></td>
                    </tr>
                   </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>