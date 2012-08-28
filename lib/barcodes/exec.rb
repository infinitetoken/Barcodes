require 'optparse'

require 'barcodes'
require 'barcodes/version'

module Barcodes
  class Exec
    attr_reader :argv
    attr_reader :parser
    attr_reader :options
    attr_reader :command
    attr_reader :arguments

    def initialize(argv)
      @argv = argv
      @options = {}
      self._init_parser
    end

    def run
      self._parse!
      
      unless @symbology.nil?
        unless @options[:ascii]
          Barcodes.render(@symbology, @target, @options)
        else
          Barcodes.render(@symbology, @target, @options, Barcodes::Renderer::Ascii)
        end
      end
    end
    
    protected

    def _init_parser
      @parser ||= OptionParser.new do |opts|
        opts.banner = "Usage: barcodes [OPTIONS] symbology target"
        opts.separator ""
        opts.on('-D', '--data [DATA]', 'The barcode data to encode (0123456789)')                           { |v| options[:data] = v ||= '0123456789' }
        opts.on('-s', '--start_character [START_CHARACTER]', 'The barcode start character if applicable')   { |v| options[:start_character] = v ||= '' }
        opts.on('-e', '--stop_character [STOP_CHARACTER]', 'The barcode stop character if applicable')      { |v| options[:stop_character] = v ||= '' }
        opts.on('-W', '--bar_width [BAR_WIDTH]', 'The barcode bar width in mils (20)')                      { |v| options[:bar_width] = v.to_i ||= 20 }
        opts.on('-H', '--bar_height [BAR_HEIGHT]', 'The barcode bar height in mils (1000)')                 { |v| options[:bar_height] = v.to_i ||= 1000 }
        opts.on('-c', '--caption_height [CAPTION_HEIGHT]', 'The barcode caption height in mils (180)')      { |v| options[:caption_height] = v.to_i ||= 180 }
        opts.on('-p', '--caption_size [CAPTION_SIZE]', 'The caption font size in mils (167)')               { |v| options[:font_size] = v.to_f ||= 167 }
        opts.on('-A', '--alpha [ALPHA]', 'The barcode transparency (1.0)')                                  { |v| options[:alpha] = v.to_f ||= 1.0 }
        opts.on('-O', '--color [COLOR]', 'The barcode color in hex (000000)')                               { |v| options[:color] = v ||= '000000' }
        opts.on('-a', '--captioned', 'Render barcode caption (true)')                                       { |v| options[:captioned] = v ||= true }
        opts.on('-i', '--ascii', 'Render barcode as ASCII string (false)')                                  { |v| options[:ascii] = v ||= false }
        opts.on('-v', '--version')                                                                          { puts version; exit }
        opts.on('-h', '--help')                                                                             { puts opts; exit }
        opts.separator ""
      end
    end
    
    def _parse!
      
      begin
        @parser.parse!(@argv)
      rescue
        puts @parser.help
        exit 1
      end
      
      @symbology = @argv.shift
      @target = @argv.shift
      @arguments = @argv
    
    end

    def _version
      "barcodes #{Barcodes::VERSION}"
    end
  end
end