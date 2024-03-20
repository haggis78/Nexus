declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option saxon:output "method=text";
 (: WHC: This is an XPath/XQuery comment. 
 Delete both smiley faces to un-comment. :)
 
 (:1:)
 (:collection('data/')//TEI=>count()  :)
 
 (:2:)
 (:collection('data/')//TEI//sp=>count()  :)
  
 (:3:)
(: collection('data/')//TEI//titleStmt/title =>string-join("&#xa;") :)

(:4:)
(: collection('data/')//TEI[descendant::speaker/text()="Antonio"]
//titleStmt/title =>string-join("&#xa;") :)

(:5:)
(: collection('data/')//TEI[descendant::sp[data(@who)!matches(., 'Henry')]]
//titleStmt/title =>string-join("&#xa;")  :)

(:6:)
(: collection('data/')//TEI[descendant::sp[data(@who='HenryV')]]
//titleStmt/title =>string-join("&#xa;")  :)

(:7:)
(:collection('data/')//TEI[descendant::sp[data(@who='HenryV')]]
//l=>count() :)

(:8:)
(: collection('data/')//TEI[descendant::speaker/text()="Antonio"]
//role=>distinct-values()=>string-join("&#xa;")  :)

(:9:)
(:  doc('data/ham.xml')//TEI/concat('The play ', .//titleStmt/title/text(), 
', written by ', .//titleStmt/author/text(), ', contains ', 
.//castItem[data(@type='role')]=>count(), ' characters.')  :)