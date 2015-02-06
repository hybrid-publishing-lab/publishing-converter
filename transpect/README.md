# XProc-based document transformation / checking

 * Converting from IDML to HTML and back;
 * applying Schematron checks to the input, to intermediate formats, and to the output;
 * rendering the checking reports as HTML
 * generating other formats, such as EPUB

## Prerequisites

ext (see http://nopugs.com/ext-tutorial)

## Initial Checkout

In ```transpect```, call:

    ext co

For updates, call:

    ext up

## Sample invocation

    ./calabash/calabash.sh adaptions/common/xpl/idml2epub.xpl debug=yes debug-dir-uri=file:$(readlink -m debug) docx=$(readlink -f ../content/sample/sample.idml)

## Documentation

HTML pages of the embedded XProc documentation may be generated with the following command line invocation: 

    calabash/calabash.sh -i source=adaptions/common/xpl/idml2epub.xpl transpectdoc/xpl/transpectdoc.xpl project-name=BinB

The documentation will be stored in the doc subdirectory. This may be overridden with the option output-base-uri=… (may also be a relative path).


