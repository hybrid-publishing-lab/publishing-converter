
#THROUGH THE PUBLISHING CONVERTER
###The hybrid publishing converter manual for designers and editors

The hybrid publishing converter is a tool that converts publications formats into others in a durable, high-quality, design caring hybrid publishing way.

In short, “hybrid publishing” refers to contemporary practices of producing different publications formats (paper books, ebooks, web contents…) in a connected and complementary way.

The production of a publications layout is informed by the tools used and the culture embedded in these tools. There isn’t one “way” of doing layout but traditions, conventions and a series of tools, more or less accessible, more or less taught and used. The approach here isn’t to build one tool solving all the issues that come with a hybrid publishing workflow but to try and find clever connections between different tools — open source ones as much as we can, to make it available to smaller publishers, graphic designers and institutions.

###Installation of the hybrid publishing converter and terminal commands

Clone the converter [repository](https://github.com/consortium/publishing-converter/tree/master/transpect) in your computer, and follow the readme to [install it](https://github.com/consortium/publishing-converter/tree/master/transpect/README.md)

Once you have installed it, create a folder on your computer in which you will put your publications files.
Don’t forget to adapt the path of the command ``ìnput=`` to point at the right files.

###HTML ➝ EPUB

###Run the converter through the Terminal

    calabash/calabash.sh -o raw-html=input.xhtml adaptions/common/xpl/html5_2epub.xpl input=***path***/***filename***.html

See also the [installation manual](https://github.com/consortium/BinB/blob/master/transpect/README.md).

###IDML ➝ EPUB

###Some of the components of the hybrid publishing converter:

* an IDML file with linked assets, images, fonts

* a mapping file

* an overriding css stylesheet

* some configuration files


###Preparation of the input file

The preparation of the InDesign file depends of the situation: is it an existing document that needs to be converted or is it a document that doesn’t exist yet and needs to be created?

###CONVERT AN EXISTING DOCUMENT

Converting old InDesign publications in an open source structured format like HTML allows them to last longer in an accessible and flexible format: they can be re-used, re-published under new formats and re-distributed much more easily.

####Style mapping

Re-styling the old InDesign document would take ages and isn’t the point here. What we want to do is give enough information to the converter so that it can save as much information as possible.
The styles can then be mapped in an html table in order to improve the translation into html structure and css styling.

####Page anchoring script

Download the page anchoring script here: https://github.com/le-tex/InDesignScripts/blob/master/pagenames/PageNamesToStoryALL.jsx
import it in InDesign and run it in the INDD document.
It will add information as conditional text on every element so that the converter knows how to order them in the ePub.

###START A NEW INDESIGN DOCUMENT

###FORMAT & PROPORTIONS
The main difference between a classical page-to-page print layout and hybrid-digital layout is that, in the first case, the final page format is fixed, while in the second case the page format is variable and depends of the size and settings of the device of each user.
In the digital realm, since the format isn’t fixed, it might be more about proportions, that can be set as percents of each element container.

The format of the different objects should be thought in relation with each media’s specificities: will it be interesting for this content to be published in a small pocket-size format or in a fancy coffee-table book format? How do the codes of these classical paper formats translate in the digital realm?
The proportions between the content and the container—for instance the size of the images and the size of the device (be it paper or screen)—should highlight the editorial concept, the qualities of the content and the effect wanted on the reader. Some detailed images need to be displayed in very big sizes. This requires different parameters on the different formats. For instance, a bigger printed size, or preferably a web application than an epub for black and white ereaders, and a proportionnaly big image size.
Others, won’t need that much importance, compared to the size of the other elements (text, the surface of the page) and will be better in a proportionnally smaller size.
But some projects will also need a different treatment in the different formats: big images in the printed version might be displayed in the ereader version as small vignettes linking to a web page with even bigger versions of the images than in the printed format, in which you can zoom and navigate in a different way.

###FLOW
The common denominator between a paper and digital publications is the notion of story, or thread: a series of elements developing a narrative by their composition and their disposition in sequences, framed by different elements in the different formats: the size of the pages, bound in a paper version, the size of the screen in an ereader, the size of the screen, and inside, the size of the reading application window on a computer.
Thus, the easiest situation is when a main “story” runs through all the pages and represents a kind of skeleton for the whole document.
Historically and technically, the text is the element that represents the story. 
With programmatic layout systems, it is the linearity imposed by the text format, different elements inscribed one after the others
In the page-to-page layout software realm, like InDesign, the text blocks represent this main squeletton, on which we can anchor side elements (images, notes, margin notes, etc).
But this only represents one vision of the book, majoritary but not exhaustive, centered on a main and linear discourse, and a primacy of the text over images…
Situations that imply two or more parallel stories require reorganisation to fit flowing and hybrid formats.

###NAVIGATION
The navigation is also informed by the degree of transparency of a paper, its flipping qualities, the ability to zoom in a digital publication, click on links and search.

###METADATA
Create a text condition 'metadata' and include metadata, one per paragraph, as name and value pairs, separated by a colon, for instance:
dc.title: Book Title
dc.identifier: id-number (like urn:isbn:9781449325299)
dc.language: en
(those three first are required)
dc.creator: Author’s Name
dc.contributor: Authors’ Names
dc.date: yyyy-mm-dd
dcterms.modified: 2011-01-01T12:00:00Z
version: 3.0.2

All property names starting with 'dc.' will refer to Dublin Core
properties: http://dublincore.org/documents/dces/


####Granular assignment of metadata:
Each metadata refers to the unit established by the structural element that preceeds it. For instance, a metadata inserted immediately after a heading refers to the section defined by this heading. Anything before the first heading will refer to the whole book.
A 'metadata' conditional content that is immediately after a figure or a table (after their caption for instance) will be attached to the corresponding objects.

###Anchoring things to a main text
If we use INDD epub export and have many parallel un-anchored item > exported object order is random
Anchoring is necessary to restore the linear reading order, attach figures and marginal notes to a main text.
Limitations: if there is no main text on a spread (no anchoring possibilities on a page)
or anchor linked text frames spread across two pages to another text — anchoring only works for one text frame, not for linked text frames (?)
use of StoryID & StoryRef
FigureRef (write the name of the image with FigureRef)

###IMAGES
Each publication format require different image formats, due to their specific display parameters. Digital  like epubs require 
The converter has an automatic tool to convert images in the right format, for instance from .tiff to .jpg. But some formats are a bit more complicated to handle, and it is always better to do this transformation by hand, in an image editor, which allows more control on the colors and contrasts.
If you do it by hand, use the same name as the original image for the jpg, and save it in the images folder. No need to change the 
Put an image in a text frame
Add StoryID as a conditional text to a name of our choice
Place the same string with an other conditional text StoryRef
If no info, order is relative to the creation date

###Captions

When the caption is on its image, anchoring it will make the image be on top of the text block and thus hide the text, it is necessary then to add an intermediary empty text block, before the caption’s one.

###TEXT
Works better with one main text
If the texts are not linked, use a script that you run in INDD that will add two text conditions PageStart_1 and PageEnd_1 etc
https://github.com/le-tex/InDesignScripts/blob/master/pagenames/PageNamesToStoryALL.jsx
If we have a main story and on some pages a few texts standing alone on the page, should we still run the script on all the document?
Useful if we have only.
Depends how we want to make sense of the information that is on the spread (they will be by default at the end of the document).
Should use the StoryID and StoryRef 
Or page break-break with empty text frame
Script: (no modifications after that, right?) run again: remove existing page name
It doesn’t anchor images in the page, isn’t it? no
Later plans for this script: add coordinates of each element
 * Footnotes:
Check INDD native footnotes (but no footnotes in tables)
End note: StoryID & StoryRef, but no automatic numbering (scripting)
Footnotes in tables: a bit more complicated
Make different categories of footnotes
Other files:
COVER
 * cover: in which folder should it be? is there guidelines on how it should be depending on the outputs? (format, size)
the cover is a file named cover.jpg in the images folder)


###HIERARCHIC STRUCTURE

###HEADINGS


###STYLES

Mapping file

####Paragraphs
Variants in paragraph styles:
When one or a series of paragraphs that is preceeded by a heading they belong to (see “hierarchic structure”), have different stylings, you can for example decorate them with tilde classes, like this:
paragraph~in_box
paragraph~in_box~noindent
paragraph~fancy
paragraph~fancy~space_above
paragraph~fancy~space_above~centered

Paragraphs that don’t have a heading but need to be grouped in some way should have a distinct base name, such as paragraph_stanza_line

####Heading
There may be groups of headers, for instance: chapter title, chapter author and chapter subtitle.
In that case, use heading_1_author (or author_1) and
heading_1_subtitle (or subheading_1). We can group these before
hierarchizing so that we don’t naively hierarchize at a heading_2
paragraph that is preceded by a heading_2_author paragraph (that would
be grouped with the previous chapter then).

When the chapter starts with an image rather than a heading, add the graphic frame style ```heading_2```.
When the chapter starts with a text, add a conditional text ```heading_2``` and the name of the 


What happens with the INDD style that are based on another style?
Style inheritance (based on): other concept than in css (combined), here it’s inherited, derived > two distinct styles in transpect, no link between them. The derived style will have all the propreties of the parent

   * formulation of how it works precisely (what is the connection between the new style names and the new output?)
stylename vocabulary in place (transpect): left column (> hierarchy, grouping, list nesting) configurable in the xslt file
element + style name: ? tilde character h1-tilde-orange
everything after the tilde is optional formatting, a decorator (a thing that is something like bold, italic, style variation) no semantic, structural meaning
second column: style from the InDesign file
master template = INDD stylenames
canonical styles = the pipeline
generic catalogue: sample document you sent us?
use predefined stylenames or new stylenames
rules for style naming: 
 * in the case of a generic heading
differentiate: heading-_-one heading-_-two
heading_one, heading_two / h1
 * paragraphs: if they belong together, if they want a variation: for instance standard standard-_-noindent
What is the difference between structural and decoration
   * is there a list of standard style names?
not really but should be set up

Distinction between character and paragraph styles?

Look at the ePub3 structural vocabulary
epub, type

TOC: story on it own (text(s) frame(s)) but not placed into the main text

###Footnotes and endnotes

###Different orientations


###VERTICAL ALIGN


###Anchors
To anchor two element that are not on the same page (which InDesign doesn’t allow), use the conditional text IDStory and IDRef



###Rotated elements
By default, they will be displayed in the epub with a normal orientation, as the reason for rotating an element might be different on a paper book than in an epub (which doesn’t necessarily allow you to turn the device as a book)
image~90_left
image~90_right


###Horizontal lines?


###Templates
The word template has different meanings in the different design tools.
In the fixed visual layout systems, even if the approach is very “hand-crafted”, templates and guides can be created to build constants and systematics throughout the pages. 
In the flowing code-based layout systems, a template is a kind of empty structure, that gets filled with a content stored somewhere else, in a database.

###template-style-content
Distinction between the template (empty structure) the style (generic style inofrmation) and the content (stored somewhere else and imported automatically in the template).


INDD books
Script for that convert idml chapters individually and then pipelines combines them (upload the book xml file) export script for that 
https://github.com/le-tex/InDesignScripts/blob/master/indb/ExportChapterAsIDML.jsx
TO DO create an infrastructure/pipeline that processes the .indb.xml file.
This pipeline needs to roam the upload/conversion directories of the individual IDML files and assemble their conversion artifacts (e.g., HTML files) according to some rules (merge everything under the body of the first HTML file or something like that).

FIXED EPUB?
 * is there an option for that?
Fixed ePub: INDD is good for that
Fixed layout from PDF: have a demo, open source (create html from the pdf)
 * then we should probably make a different user manual for fixed ePubs

HTML (XML) > EPUB
command:
./calabash/calabash.sh -i source=edited.html -o html=/dev/null adaptions/common/xpl/html2epub.xpl
 * where should we put the html file and assets (img, fonts, etc)?
anywhere on the drive: specify the path to the html file
adapt it to html5


###Run the converter through the Terminal

Terminal command in Linux:

    calabash/calabash.sh -o html=out.html -o raw-html=raw.html -o hub=/dev/null adaptions/common/xpl/idml2epub.xpl debug=yes debug-dir-uri=file:$(readlink -m debug) input=***path***/***filename***.idml

MacOS:

    calabash/calabash.sh -o html=out.html -o raw-html=raw.html -o hub=/dev/null adaptions/common/xpl/idml2epub.xpl debug=yes debug-dir-uri=debug input=***path***/***filename***.idml

See also the [installation manual](https://github.com/consortium/BinB/blob/master/transpect/README.md).

###ONLINE CONVERTER

Url of the converter:
http://transpect.le-tex.de/en/converter/save_file?set_button=&upload_type=BinB
(currently there is no access control)

TO USE THE CONVERTER

NEW FILE

1. upload a zip file, which contains:
– a folder called images, which contains the images
– the style mapping map-idml.xhtml in a folder called styles
(styles/map-idml.xhtml)
– etc. /fonts

2. upload the corresponding IDML file (same base name as the zip file)
Example: Manifest_Extract.idml, Manifest_Extract.zip

3. click on the red button!
Download filelist.html and enjoy your ePub


TO UPDATE ALREADY UPLOADED FILES

1. don’t upload all the zip file, but a new zip with only the updated files 
(keep the same structure: i.e., images/…)

2. click on the red button!
Download filelist.html and enjoy your ePub


MORE OPTIONS, MORE CONTROL:

FILE FORMATS:
.jpg
.tiff > .jpg
.png

.EPS files don’t work


IMAGES
All image paths, no matter where they were before, will be replaced with
that path. And currently the file extension will be changed to .jpg, at
least for tiff. You can export the images using one of the scripts here:
https://github.com/le-tex/InDesignScripts/tree/master/image-export

INDESIGN GUIDELINES
…

CUSTOM STYLESHEET
Modify the classes in the file map-idml.xhtml
/transpect/adaptions/common/css/overriding.css


REMOVE ELEMENTS FROM THE EPUB
- Give the elements a specific class in INDD (epub-no)
[is it possible to attribute several classes to one element?]





