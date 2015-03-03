<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:dbk="http://docbook.org/ns/docbook"
  xmlns:letex="http://www.le-tex.de/namespace"
  xmlns:idml2xml="http://www.le-tex.de/namespace/idml2xml"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:css="http://www.w3.org/1996/css"
  xmlns:hub="http://www.le-tex.de/namespace/hub"
  xmlns="http://docbook.org/ns/docbook"
  xpath-default-namespace="http://docbook.org/ns/docbook"
  exclude-result-prefixes="xs saxon letex xlink hub dbk idml2xml"
  version="2.0">
 
  <xsl:import href="http://transpect.le-tex.de/evolve-hub/evolve-hub.xsl"/>

  <xsl:template match="@role" mode="hub:twipsify-lengths hub:expand-css-properties">
  	<xsl:copy />
  </xsl:template>

  <xsl:template match="imagedata/@fileref" mode="hub:preprocess-hierarchy">
     <xsl:attribute name="{name()}" select="concat(
                                              'images/',
                                              replace(
                                                replace(
                                                  replace(
                                                    replace(., 
                                                      '^.+/', 
                                                      ''
                                                    ),
                                                    '%[A-F\d]{2}',
                                                    '_'
                                                  ),
                                                  '[^-_.0-9A-Za-z]',
                                                  ''
                                                ),
                                              '\.tiff?$',
                                              '.jpg'
                                            )
                                          )"/>
  </xsl:template>


  <xsl:template match="*[some $c in * satisfies hub:grouping($c)]" mode="hub:preprocess-hierarchy">
    <xsl:copy>
      <xsl:apply-templates select="info" mode="#current"/>
      <xsl:for-each-group select="node() except info" group-adjacent="replace(hub:grouping(.), '_-_.+$', '')">
        <xsl:choose>
          <xsl:when test="current-grouping-key()">
            <section role="{current-grouping-key()}">
              <xsl:apply-templates select="current-group()" mode="#current"/>
            </section>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="current-group()" mode="#current"/>            
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each-group>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="para[@role='review_head'][not(preceding-sibling::*[1]/@role = 'review_head')]" mode="hub:preprocess-hierarchy">
    <title>
      <xsl:apply-templates select="@*, node()" mode="#current"/>
    </title>
  </xsl:template>

  <xsl:function name="hub:grouping" as="xs:string*">
    <xsl:param name="elt" as="node()"/>
    <xsl:choose>
      <xsl:when test="$elt/self::text()">
        <xsl:sequence select="hub:grouping($elt/following-sibling::*[1])"/>
      </xsl:when>
      <xsl:when test="$elt/self::para[matches(@role, '^(pagenum|review)')]">
        <xsl:sequence select="replace($elt/self::para/@role, '^([^_]+).*$', '$1')"/>
      </xsl:when>
      <xsl:when test="$elt/self::img[following-sibling::*[not(self::img)][1]/self::para[matches(@role, '^review')]]">
        <xsl:sequence select="'review'"/>
      </xsl:when>
    </xsl:choose>
  </xsl:function>

</xsl:stylesheet>