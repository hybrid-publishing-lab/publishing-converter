<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:c="http://www.w3.org/ns/xproc-step" 
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:cxf="http://xmlcalabash.com/ns/extensions/fileutils" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:s="http://purl.oclc.org/dsdl/schematron" 
  xmlns:transpect="http://www.le-tex.de/namespace/transpect"
  xmlns:hub2htm="http://www.le-tex.de/namespace/hub2htm" 
  xmlns:idml2xml="http://www.le-tex.de/namespace/idml2xml"
  xmlns:letex="http://www.le-tex.de/namespace"
  xmlns:hypub="http://hybridpublishing.org/"
  xmlns:dbk="http://docbook.org/ns/docbook"
  version="1.0" 
  name="idml2html"
  type="hypub:idml2html">

  <p:option name="clades" select="''"/>
  <p:option name="input" select="''"/>
  <p:option name="all-styles" required="false" select="'no'"/>
  <p:option name="debug" required="false" select="'no'"/>
  <p:option name="debug-dir-uri" required="false" select="resolve-uri('debug')"/>
  <p:option name="status-dir-uri" required="false" select="resolve-uri('status')"/>
  <p:option name="interface-language" required="false" select="'en'"/>
  
  <p:input port="conf" primary="true">
    <p:empty/>
  </p:input>
  <p:output port="hub">
    <p:pipe port="result" step="idml2hub"/>
  </p:output>
  <p:serialization port="hub" omit-xml-declaration="false"/>
  <p:output port="html" primary="true"/>
  <p:serialization port="html" omit-xml-declaration="false" method="xhtml" indent="true"/>

  <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl"/>
  <p:import href="http://transpect.le-tex.de/idml2xml/xpl/idml2hub.xpl"/>
  <p:import href="http://transpect.le-tex.de/book-conversion/converter/xpl/paths.xpl"/>
  <p:import href="http://transpect.le-tex.de/hub2html/xpl/hub2html.xpl"/>
  <p:import href="http://transpect.le-tex.de/xproc-util/store-debug/store-debug.xpl"/>
  
  <idml2xml:hub name="idml2hub"><!-- cx:depends-on="idml2hub-start-msg"-->
    <p:with-option name="srcpaths" select="'yes'"/>
    <p:with-option name="all-styles" select="$all-styles"/>
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="idmlfile" select="$input"/>
  </idml2xml:hub>

  <hub2htm:convert name="hub-html">
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:input port="paths">
      <p:empty/>
    </p:input>
    <p:with-param name="target" select="'html5'"/>
    <p:with-param name="html-title" select="/*/dbk:info/dbk:keywordset[@role = 'hub']/dbk:keyword[@role = 'source-basename']"/>
  </hub2htm:convert>

  <p:delete match="@source-dir-uri | @srcpath"/>
    
</p:declare-step>
