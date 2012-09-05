# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'optparse'

require 'barcodes'
require 'barcodes/version'

module Barcodes
  
  # This class is the main handler for the command line tool interface.
  # It takes command line arguments and options and renders a barcode 
  # using those options.
  class Exec
    # Array of command line arguments
    attr_reader :argv
    
    # The parser instance
    attr_reader :parser
    
    # Hash of parsed options
    attr_reader :options
    
    # The barcode symbology
    attr_reader :symbology
    
    # The output target
    attr_reader :target
    
    # Creates a new instance with given command line arguments and options
    def initialize(argv)
      @argv = argv
      @options = {}
      self._init_parser
      self._parse!
    end
    
    # Runs the command and renders barcode
    def run
      begin
        unless self.symbology.nil?
          unless self.options[:ascii]
            Barcodes::Renderer::Pdf.new(Barcodes.create(self.symbology, self.options)).render(self.target)
          else
            Barcodes::Renderer::Ascii.new(Barcodes.create(self.symbology, self.options)).render(self.target)
          end
        end
      rescue Exception => e
        puts e.message
      end
    end
    
    protected
    
    # Initializes the option parser instance
    def _init_parser
      @parser ||= OptionParser.new do |opts|
        opts.banner = "Usage: barcodes [OPTIONS] symbology target"
        opts.separator ""
        opts.on('-D', '--data [DATA]', 'The barcode data to encode (0123456789)')                           { |v| @options[:data] = v ||= '0123456789' }
        opts.on('-s', '--start_character [START_CHARACTER]', 'The barcode start character if applicable')   { |v| @options[:start_character] = v ||= '' }
        opts.on('-e', '--stop_character [STOP_CHARACTER]', 'The barcode stop character if applicable')      { |v| @options[:stop_character] = v ||= '' }
        opts.on('-W', '--bar_width [BAR_WIDTH]', 'The barcode bar width in mils (20)')                      { |v| @options[:bar_width] = v.to_i ||= 20 }
        opts.on('-H', '--bar_height [BAR_HEIGHT]', 'The barcode bar height in mils (1000)')                 { |v| @options[:bar_height] = v.to_i ||= 1000 }
        opts.on('-c', '--caption_height [CAPTION_HEIGHT]', 'The barcode caption height in mils (180)')      { |v| @options[:caption_height] = v.to_i ||= 180 }
        opts.on('-p', '--caption_size [CAPTION_SIZE]', 'The caption font size in mils (167)')               { |v| @options[:font_size] = v.to_f ||= 167 }
        opts.on('-A', '--alpha [ALPHA]', 'The barcode transparency (1.0)')                                  { |v| @options[:alpha] = v.to_f ||= 1.0 }
        opts.on('-O', '--color [COLOR]', 'The barcode color in hex (000000)')                               { |v| @options[:color] = v ||= '000000' }
        opts.on('-a', '--captioned', 'Render barcode caption (true)')                                       { |v| @options[:captioned] = v ||= true }
        opts.on('-i', '--ascii', 'Render barcode as ASCII string (false)')                                  { |v| @options[:ascii] = v ||= false }
        opts.on('-v', '--version')                                                                          { puts self._version; exit }
        opts.on('-h', '--help')                                                                             { puts opts; exit }
        opts.separator ""
      end
    end
    
    # Parses the command line arguments
    def _parse!
      
      begin
        self.parser.parse!(self.argv)
      rescue
        puts self.parser.help
        exit 1
      end
      
      @symbology = self.argv.shift
      @target = self.argv.shift
    end
    
    # Returns the current version
    def _version
      "barcodes #{Barcodes::VERSION}"
    end
  end
end