# XProc-based document transformation / checking

 * Converting from IDML to HTML and back;
 * applying Schematron checks to the input, to intermediate formats, and to the output;
 * rendering the checking reports as HTML
 * generating other formats, such as EPUB

## Prerequisites

 * ext (see http://nopugs.com/ext-tutorial)
 * Java 1.6 or newer (OpenJDK does not seem to work)

## Initial Checkout

In ```transpect``` folder, call:

    ext co

For updates, call:

    ext up

## Sample invocation

This invokes a simplistic IDML→HTML→EPUB pipeline that doesn’t attempt at identifying any 
structure in the input (other pipelines are in preparation). 
In the ```transpect``` folder, call:

    ./calabash/calabash.sh -o html=out.html -o hub=/dev/null adaptions/common/xpl/idml2html.xpl debug=yes debug-dir-uri=file:$(readlink -m debug) input=../content/sample/idml/sample.idml

The EPUB will then be created as ../content/sample/sample.epub

If you’re on a Mac and if you didn’t install the GNU version of readlink, you might have to specify the absolute path yourself.

If you specify ```debug-dir-uri=debug```, it might be that the debug files are stored in xproc-util/store-debug/xpl/debug. 
Relative paths for the IDML input should work fine though.

Cygwin example:

    ./calabash/calabash.sh -o html=out.html -o hub=$(cygpath -ma /dev/null) adaptions/common/xpl/idml2html.xpl debug=yes debug-dir-uri=file:/$(cygpath -ma ../debug) input=../content/sample/idml/sample.idml

## Documentation

HTML pages of the embedded XProc documentation may be generated with the following command line invocation: 

    calabash/calabash.sh -i source=adaptions/common/xpl/idml2html.xpl transpectdoc/xpl/transpectdoc.xpl project-name=BinB

The documentation will be stored in the doc subdirectory. This may be overridden with the option output-base-uri=… (may also be a relative path).
