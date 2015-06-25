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
  xmlns:tr="http://transpect.io"
  xmlns:hub2htm="http://www.le-tex.de/namespace/hub2htm" 
  xmlns:idml2xml="http://www.le-tex.de/namespace/idml2xml"
  xmlns:letex="http://www.le-tex.de/namespace"
  xmlns:hypub="http://hybridpublishing.org/"
  xmlns:dbk="http://docbook.org/ns/docbook"
  version="1.0" 
  name="html5_2epub"
  type="hypub:idml2epub">

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
    <p:document href="http://customers.le-tex.de/generic/book-conversion/conf/transpect-conf.xml"/>
    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
      <p>See the section on 
        <a href="https://subversion.le-tex.de/common/transpect-demo/content/le-tex/setup-manual/en/out/xhtml/transpect-setup.xhtml#sec-cascade">configuration clades.</a>
      </p>
      <p>The converter works also without clade-based configuration. If you store your content in an arbitrary directory (e.g,
        /my/dir/idml/mycontent.idml), you may put content-specific configuration overrides into /my/dir/css, /my/dir/evolve-hub,
        etc.</p>
    </p:documentation>
  </p:input>
  
  <p:output port="raw-html">
    <p:pipe port="result" step="html5"/>
  </p:output>
  <p:serialization port="raw-html" omit-xml-declaration="false" method="xhtml" indent="true"/>
  <p:output port="epub-file">
    <p:pipe port="result" step="html2epub"/>
  </p:output>
  <p:serialization port="epub-file" omit-xml-declaration="false" indent="true"/>

  <p:import href="http://transpect.le-tex.de/book-conversion/converter/xpl/paths.xpl"/>
  <p:import href="http://transpect.le-tex.de/xproc-util/store-debug/store-debug.xpl"/>
  <p:import href="http://transpect.io/xproc-util/html5/xpl/load-html5.xpl"/>
  <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl"/>
  <p:import href="html2epub.xpl"/>

  <transpect:paths name="paths" determine-transpect-project-version="no" pipeline="html5_2epub">
    <p:with-option name="interface-language" select="$interface-language"/>
    <p:with-option name="clades" select="$clades"/>
    <p:with-option name="file" select="$input"/>
    <p:with-option name="debug" select="$debug"/>  
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="status-dir-uri" select="$status-dir-uri"/>
    <p:input port="conf">
      <p:pipe port="conf" step="html5_2epub"/>
    </p:input>
    <p:input port="stylesheet">
      <p:document href="http://transpect.le-tex.de/book-conversion/converter/xsl/paths.xsl"/>
    </p:input>
  </transpect:paths>
  
  <tr:load-html5 name="html5">
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="file" select="$input"/>
  </tr:load-html5>
  
  <hypub:html2epub name="html2epub">
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="status-dir-uri" select="$status-dir-uri"/>
    <p:input port="paths">
      <p:pipe port="result" step="paths"/>
    </p:input>
  </hypub:html2epub>

  <p:sink/>

</p:declare-step>
