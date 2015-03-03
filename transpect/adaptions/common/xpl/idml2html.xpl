<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:c="http://www.w3.org/ns/xproc-step" 
  xmlns:css="http://www.w3.org/1996/css"
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:cxf="http://xmlcalabash.com/ns/extensions/fileutils" 
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:s="http://purl.oclc.org/dsdl/schematron" 
  xmlns:epub="http://transpect.le-tex.de/epubtools"
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
  <p:option name="decorators" required="false" select="'yes'">
    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
      <p>Whether to use <a href="http://transpect.le-tex.de/use-css-decorator-classes/xpl/use-css-decorator-classes.xpl">css decorator resolution</a>.</p>
    </p:documentation>
  </p:option>
  
  <p:input port="conf" primary="true">
    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
      <p>See the section on 
        <a href="https://subversion.le-tex.de/common/transpect-demo/content/le-tex/setup-manual/en/out/xhtml/transpect-setup.xhtml#sec-cascade">configuration clades.</a>
      </p>
      <p>The converter works also without clade-based configuration. If you store your content in an arbitrary directory (e.g,
        /my/dir/idml/mycontent.idml), you may put content-specific configuration overrides into /my/dir/css, /my/dir/evolve-hub,
        etc.</p>
    </p:documentation>
    <p:document href="http://customers.le-tex.de/generic/book-conversion/conf/transpect-conf.xml"/>
  </p:input>
  <p:output port="hub">
    <p:pipe port="result" step="idml2hub"/>
  </p:output>
  <p:serialization port="hub" omit-xml-declaration="false"/>
  <p:output port="html" primary="true">
    <p:pipe port="result" step="html"/>
  </p:output>
  <p:serialization port="html" omit-xml-declaration="false" method="xhtml" indent="true"/>
  <p:output port="epub-zip-manifest">
    <p:pipe port="result" step="epub-convert"/>
  </p:output>
  <p:serialization port="epub-zip-manifest" omit-xml-declaration="false" method="xhtml" indent="true"/>

  <p:import href="http://transpect.le-tex.de/book-conversion/converter/xpl/evolve-hub.xpl"/>
  <p:import href="http://transpect.le-tex.de/book-conversion/converter/xpl/load-cascaded.xpl"/>
  <p:import href="http://transpect.le-tex.de/book-conversion/converter/xpl/paths.xpl"/>
  <p:import href="http://transpect.le-tex.de/hub2html/xpl/hub2html.xpl"/>
  <p:import href="http://transpect.le-tex.de/idml2xml/xpl/idml2hub.xpl"/>
  <p:import href="http://transpect.le-tex.de/epubtools/epub-convert.xpl"/>
  <p:import href="http://transpect.le-tex.de/map-style-names/xpl/map-style-names.xpl"/>
  <p:import href="http://transpect.le-tex.de/use-css-decorator-classes/xpl/use-css-decorator-classes.xpl"/>
  <p:import href="http://transpect.le-tex.de/xproc-util/store-debug/store-debug.xpl"/>
  <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl"/>

  <transpect:paths name="paths" determine-transpect-project-version="no" pipeline="idml2html">
    <p:with-option name="interface-language" select="$interface-language"/>
    <p:with-option name="clades" select="$clades"/>
    <p:with-option name="file" select="$input"/>
    <p:with-option name="debug" select="$debug"/>  
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="status-dir-uri" select="$status-dir-uri"/>
    <p:input port="conf">
      <p:pipe port="conf" step="idml2html"/>
    </p:input>
    <p:input port="stylesheet">
      <p:document href="http://transpect.le-tex.de/book-conversion/converter/xsl/paths.xsl"/>
    </p:input>
  </transpect:paths>
  
  <idml2xml:hub name="idml2hub">
    <p:with-option name="srcpaths" select="'yes'"/>
    <p:with-option name="all-styles" select="$all-styles"/>
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="idmlfile" select="$input"/>
  </idml2xml:hub>
  
  <css:map-styles name="map-styles">
    <p:input port="paths">
      <p:pipe port="result" step="paths"/>
    </p:input>
    <p:with-option name="map-name" select="concat('styles/map-', /c:param-set/c:param[@name eq 'ext']/@value, '.xhtml')">
      <p:pipe port="result" step="paths"/>
    </p:with-option>
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="status-dir-uri" select="$status-dir-uri"/>
  </css:map-styles>

  <transpect:evolve-hub name="evolve-hub" srcpaths="yes">
    <p:input port="paths">
      <p:pipe port="result" step="paths"/> 
    </p:input>
    <p:with-option name="load" select="concat('evolve-hub/driver-', /c:param-set/c:param[@name eq 'ext']/@value)">
      <p:pipe port="result" step="paths"/>
    </p:with-option>
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="status-dir-uri" select="$status-dir-uri"/>
  </transpect:evolve-hub>

  <hub2htm:convert name="hub-html">
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:input port="paths">
      <p:pipe port="result" step="paths"/>
    </p:input>
    <p:with-param name="target" select="'HTML5'"/>
    <p:with-param name="html-title" select="/*/dbk:info/dbk:keywordset[@role = 'hub']/dbk:keyword[@role = 'source-basename']"/>
  </hub2htm:convert>

  <p:choose name="decorators">
    <p:xpath-context>
      <p:pipe port="result" step="paths"/>
    </p:xpath-context>
    <p:when test="(/c:param-set/c:param[@name = 'use-css-decorator-classes']/@value, $decorators)[1] = 'yes'">
      <p:output port="result" primary="true"/>
      <css:use-decorator-classes>
        <p:with-option name="debug" select="$debug"/>
        <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
      </css:use-decorator-classes>
    </p:when>
    <p:otherwise>
      <p:output port="result" primary="true"/>
      <p:identity name="testi"/>
    </p:otherwise>
  </p:choose>
  
  <p:delete match="@source-dir-uri | @srcpath"/>
  
  <p:add-attribute attribute-name="xml:base" match="/*" name="html">
    <p:with-option name="attribute-value" select="replace(base-uri(/*), '^(.+?)(/[^/]+)(/.[^/]+)\.idml.*$', '$1$3.xhtml')"/>
  </p:add-attribute>

  <transpect:load-cascaded name="epub-conf" filename="epubtools/epub-config.xml">
    <p:input port="paths">
      <p:pipe port="result" step="paths"/>
    </p:input>
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
  </transpect:load-cascaded>  
  
  <epub:convert name="epub-convert">
    <p:input port="source">
      <p:pipe step="html" port="result"/>
    </p:input>
    <p:input port="meta">
      <p:pipe port="result" step="epub-conf"/>
    </p:input>
    <p:input port="conf">
      <p:empty/>
    </p:input>
    <p:with-option name="terminate-on-error" select="'no'"/>
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="status-dir-uri" select="$status-dir-uri"/>
  </epub:convert>

  <p:sink/>

</p:declare-step>
