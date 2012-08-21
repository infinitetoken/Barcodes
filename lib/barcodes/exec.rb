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
      init_parser
    end

    def run
      parse!
      
      unless @symbology.nil?
        Barcodes.create(@symbology, @options).render(@target)
      else
        Barcodes.create('Codabar', @options).render(@target)
      end
    end
    
    protected

    def init_parser
      @parser ||= OptionParser.new do |opts|
        opts.banner = "Usage: barcodes [OPTIONS] target"
        opts.separator ""
        opts.on('-S', '--symbology [SYMBOLOGY]', 'The barcode symbology (Codabar)')                         { |v| @symbology = v ||= 'Codabar' }
        opts.on('-D', '--data [DATA]', 'The barcode data to encode (0123456789)')                           { |v| options[:data] = v ||= '0123456789' }
        opts.on('-s', '--start_character [START_CHARACTER]', 'The barcode start character')                 { |v| options[:start_character] = v ||= '' }
        opts.on('-e', '--stop_character [STOP_CHARACTER]', 'The barcode stop character')                    { |v| options[:stop_character] = v ||= '' }
        opts.on('-W', '--bar_width [BAR_WIDTH]', 'The barcode bar width in mils (20)')                      { |v| options[:bar_width] = v.to_i ||= 20 }
        opts.on('-H', '--bar_height [BAR_HEIGHT]', 'The barcode bar height in mils (1000)')                 { |v| options[:bar_height] = v.to_i ||= 1000 }
        opts.on('-c', '--caption_height [CAPTION_HEIGHT]', 'The barcode caption height in mils (140)')      { |v| options[:caption_height] = v.to_i ||= 140 }
        opts.on('-A', '--alpha [VALUE]', 'The barcode transparency (1.0)')                                  { |v| options[:alpha] = v.to_f ||= 1.0 }
        opts.on('-O', '--color [VALUE]', 'The barcode color in hex (000000)')                               { |v| options[:color] = v ||= '000000' }
        opts.on('-f', '--font_family [VALUE]', 'The caption font family (Courier)')                         { |v| options[:font_family] = v ||= 'Courier' }
        opts.on('-p', '--font_size [VALUE]', 'The caption font size in pixels (10.0)')                      { |v| options[:font_size] = v.to_f ||= 10.0 }
        opts.on('-a', '--captioned', 'Render barcode caption (true)')                                       { |v| options[:captioned] = v ||= true }
        opts.on('-v', '--version')                                                                          { puts version; exit }
        opts.on('-h', '--help')                                                                             { puts opts; exit }
        opts.separator ""
      end
    end
    
    def parse!
      
      begin
        @parser.parse!(@argv)
      rescue
        puts @parser.help
        exit 1
      end
      
      @target = @argv.shift
      @arguments = @argv
    
    end

    def version
      "barcodes #{Barcodes::VERSION}"
    end
  end
end