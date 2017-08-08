# FreePlane/FreeMind XSLT exporter(s)

## Objective

Exporting content from FreePlane/FreeMind mindmapping tool format (XML-based, .mm) to different output formats.

### mm2revealjs

An XSLT transformation tool for creating slideshow presentations for the web with ease:

1. Create a presentation in FreePlane/FreeMind mindmap program
2. Export as a Reveal.js presentation

### mm2markdown

Export FreePlane/FreeMind documents to Markdown
  * Known bugs: exporting numbered lists in notes of a node does not work

## Requirements

- FreePlane program (Windows/Linux/OSX)
- Transformation files from this repository

## Installation

### Windows

#### Installing transformation(s)

1. Install FreePlane and run it at least once if you didn't already
2. [Download the files from this repository (zip)](https://github.com/jannecederberg/freeplane-xslt/archive/master.zip)
3. Extract the files from the zip archive into `C:\Users\<username>\AppData\Roaming\FreePlane\<version>\xslt`
  - Create the `xslt` directory if it doesn't exist already
4. Restart FreePlane if you had it running
5. You'll now see the added exporters in the 'Files of Type' dropdown in File => Export map

### Macintosh

Freeplane is available for Macintosh. I haven't tested the Mac version, but I'm guessing it'll work pretty much the same as the Linux version. Check the Linux instructions.

### Ubuntu Linux

#### Installing transformation(s)

1. `git clone https://github.com/jannecederberg/freeplane-xslt.git`
2. Copy the `.xsl` files into your `~/.config/freeplane/<version>/xslt`
  - create the `xslt` folder if it doesn't exist
3. Restart FreePlane if you had it running
4. You'll now see the added exporters in the 'Files of Type' dropdown in File => Export map

## Creating a Reveal.js presentation from FreePlane

1. Create your mindmap using FreePlane and save it (as .mm) into the directory you extracted the reveal.js zip package
2. Export your mindmap from FreePlane
  - File => Export map
  - From the *Files of Type* dropdown choose *Reveal.js presentation*
  - Click on *Save*
3. Open HTML file created in step 2 in your browser

# TODO

* mm2markdown
  - Parse img tags in notes into Markdown
* mm2revealjs
  - Parse FreePlane root node into h1, h2 and h3 tags by lines

# Version history

- **2014-11-12**
  - Removed need to download Reveal.js separately
  - Level 3 and lower map nodes are shown as list items in Reveal.js
- **2014-10-05**
  - Added Reveal.js exporter as well as instructions for using with FreePlane
- **2014-09-02**
  - First public release