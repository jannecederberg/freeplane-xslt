# FreePlane/FreeMind XSLT exporter(s)

## In a nutshell

These XSLT stylesheets are for exporting content from the XML format of FreePlane/FreeMind mindmapping tool to different output formats.

* *mm2markdown*: Export to Markdown
  * Known bugs: exporting numbered lists in notes of a node does not work
* *mm2revealjs*: Export a mindmap into a RevealJS presentation. Mindmap should only have two levels after root node!

## Installation for FreePlane

### Windows

1. Install FreePlane and run it at least once if you didn't already
2. [Download the files from this repository (zip)](https://github.com/jannecederberg/freeplane-xslt/archive/master.zip)
3. Extract the files from the zip archive into `C:\Users\<username>\AppData\Roaming\FreePlane\<version>\xslt`
  - Create the `xslt` directory if it doesn't exist already
4. Restart FreePlane if you had it running
5. You'll now see the added exporters in the 'Files of Type' dropdown in File => Export map

### Linux

1. `git clone https://github.com/jannecederberg/freeplane-xslt.git`
2. Copy the `.xsl` files into your `~/.freeplane/<version>/xslt`
  - create the `xslt` folder if it doesn't exist
3. Restart FreePlane if you had it running
4. You'll now see the added exporters in the 'Files of Type' dropdown in File => Export map

## Using with FreePlane to create RevealJS slides

### Preparations for Windows

1. Download [RevealJS](https://github.com/jannecederberg/reveal.js/archive/master.zip) zip-package
2. Extract the `reveal.js-master` directory from the zip package into the directory where you want be keeping your presentation(s)
3. Rename the `reveal.js-master` directory to `reveal.js`
4. You're done with prep! Proceed to creating your kicka** RevealJS presentations directly FreePlane!

### Preparations for Linux

1. Open console and navigate to the directory where you saved your mindmap
2. Run: `git clone https://github.com/jannecederberg/reveal.js.git`

### Creating a RevealJS presentation from FreePlane

1. Create your mindmap using FreePlane and save it (as .mm) into the directory you extracted the reveal.js zip package
2. Export your mindmap from FreePlane
  - File => Export map
  - From the *Files of Type* dropdown choose *RevealJS presentation*
  - Click on *Save*
3. Open HTML file created in step 2 in your browser

# TODO

* mm2markdown: Parse img tags in notes into Markdown
* mm2revealjs: Parse FreePlane root node into h1, h2 and h3 tags by lines

# Version history

- **2014-10-05**: Added RevealJS exporter as well as instructions for using with FreePlane
- **2014-09-02**: First public release