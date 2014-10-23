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
- My customized version of [Hakimel](http://lab.hakimel.se)'s Reveal.js library

## Installation

### Windows

#### Installing transformation(s)

1. Install FreePlane and run it at least once if you didn't already
2. [Download the files from this repository (zip)](https://github.com/jannecederberg/freeplane-xslt/archive/master.zip)
3. Extract the files from the zip archive into `C:\Users\<username>\AppData\Roaming\FreePlane\<version>\xslt`
  - Create the `xslt` directory if it doesn't exist already
4. Restart FreePlane if you had it running
5. You'll now see the added exporters in the 'Files of Type' dropdown in File => Export map

#### Getting the Reveal.js library

The Reveal.js library is required for presentations exported from FreePlane to work correctly. To obtain the Reveal.js library, follow the following instructions:

1. Download [RevealJS](https://github.com/jannecederberg/reveal.js/archive/master.zip) zip-package
2. Extract the `reveal.js-master` directory from the zip package into the directory where you want be keeping your presentation(s)
3. Rename the `reveal.js-master` directory to `reveal.js`
4. You're done with prep! Proceed to creating your kicka** RevealJS presentations directly FreePlane!


### Macintosh

Freeplane is available for Macintosh. I haven't tested the Mac version, but I'm guessing it'll work pretty much the same as the Linux version. Check the Linux instructions.

### Linux

#### Installing transformation(s)

1. `git clone https://github.com/jannecederberg/freeplane-xslt.git`
2. Copy the `.xsl` files into your `~/.freeplane/<version>/xslt`
  - create the `xslt` folder if it doesn't exist
3. Restart FreePlane if you had it running
4. You'll now see the added exporters in the 'Files of Type' dropdown in File => Export map

#### Getting the Reveal.js library

1. Open console and navigate to the directory where you saved your mindmap
2. Run: `git clone https://github.com/jannecederberg/reveal.js.git`

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
  - Make export standalone by using the (customized) Reveal.js from a CDN
  - Parse FreePlane root node into h1, h2 and h3 tags by lines
  - Render fourth level nodes and beyond as list items

# Version history

- **2014-10-05**: Added RevealJS exporter as well as instructions for using with FreePlane
- **2014-09-02**: First public release