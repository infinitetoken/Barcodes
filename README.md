Barcodes
========

Barcodes is a RubyGem for creating and rendering common barcode symbologies. Here are some of the current features:

* Many common symbologies to choose from
* PDF and ASCII rendering support
* Command line interface for rendering barcodes to console or file

Currently supported symbologies:

* Code 11
* Code 128
* Code 39
* Code 39 Mod 43
* Code 39 Extended
* Code 39 Extended Mod 43
* Code 93
* Code 93 Extended
* EAN8
* EAN13
* Interleaved 2 of 5
* Interleaved 2 of 5 Mod 10
* MSI
* MSI Mod 10
* MSI Mod 11
* PLANET
* POSTNET
* Standard 2 of 5
* Standard 2 of 5 Mod 10
* UPC-A

Installation
------------

Barcodes is a RubyGem and can be installed using:

    $ gem install barcodes
  
Usage
-----

If you want to create and render a barcode all in one step you can simply do the following:

    Barcodes.render('Codabar', '/path/to/output.pdf', {:data => '12345'})
  
The output path can be left empty and the rendered output will be returned as a string. 

By default Barcodes uses the PDF renderer. To use a different renderer do the following:

    barcode = Barcodes.create('Postnet', {:data => '44555'})
  
    pdf_renderer = Barcodes::Renderer::Pdf.new(barcode)
    pdf_renderer.render('/path/to/output.pdf')
  
    ascii_renderer = Barcodes::Renderer::Ascii.new(barcode)
    ascii_renderer.render('/path/to/output.txt')
  
The following options (defaults shown below) are available (where applicable) for all barcode symbologies:

    {
      :data => '0123456789',
      :start_character => '',
      :stop_character => '',
      :bar_width => 20, # in mils
      :bar_height => 1000, # in mils
      :alpha => 1.0,
      :color => '000000',
      :caption_height => 180, # in mils
      :caption_size => 167, # in mils
      :captioned => true,
    }
  
Command Line
------------

Barcodes also provides a command line tool for rendering barcodes:

    $ barcodes -h
    Usage: barcodes [OPTIONS] symbology target

      -D, --data [DATA]                The barcode data to encode (0123456789)
      -s [START_CHARACTER],            The barcode start character if applicable
          --start_character
      -e [STOP_CHARACTER],             The barcode stop character if applicable
          --stop_character
      -W, --bar_width [BAR_WIDTH]      The barcode bar width in mils (20)
      -H, --bar_height [BAR_HEIGHT]    The barcode bar height in mils (1000)
      -c [CAPTION_HEIGHT],             The barcode caption height in mils (180)
          --caption_height
      -p [CAPTION_SIZE],               The caption font size in mils (167)
          --caption_size
      -A, --alpha [ALPHA]              The barcode transparency (1.0)
      -O, --color [COLOR]              The barcode color in hex (000000)
      -a, --captioned                  Render barcode caption (true)
      -i, --ascii                      Render barcode as ASCII string (false)
      -v, --version
      -h, --help

License
-------

MIT License. See LICENSE file for details.