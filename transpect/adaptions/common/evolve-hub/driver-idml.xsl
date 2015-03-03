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

</xsl:stylesheet>
