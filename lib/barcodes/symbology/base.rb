require 'barcodes/pdf/builder'

module Barcodes
  module Symbology
    class Base
      attr_accessor :data
      attr_accessor :start_character
      attr_accessor :stop_character
      attr_accessor :bar_width
      attr_accessor :bar_height
      attr_accessor :caption_height
      attr_accessor :alpha
      attr_accessor :color
      attr_accessor :font_family
      attr_accessor :font_size
      attr_accessor :captioned
    
      def initialize(args={})
        @data = '0123456789'
        @start_character = ''
        @stop_character = ''
        @bar_width = 20
        @bar_height = 1000
        @caption_height = 140
        @alpha = 1.0
        @color = '000000'
        @font_family = 'Courier'
        @font_size = 10.0
        @captioned = true
      
        args.each do |k,v|
          instance_variable_set("@#{k}", v) unless v.nil?
        end
      end
    
      def render(filename=nil)
        builder = Barcodes::PDF::Builder.new(self)
      
        unless filename.nil?
          builder.pdf.render_file filename
        else
          builder.pdf.render
        end
      end
      alias_method :to_pdf, :render
    
      def draw(pdf)
        # Must be overridden in subclass to draw barcode to PDF document
      end
    
      def caption_data
        # Can be overridden by subclass to format data string for display
        @data
      end
    
      def formatted_data
        # Can be overridden by subclass to add additional formatting to data string
        @data
      end
    
      def encoded_data
        if self.valid?
          encoded_data = ''
          self.formatted_data.each_char do |char|
            encoded_data += self._encode_character char
          end
          encoded_data
        end
      end
      
      def quiet_zone_width
        # Can be overriden in subclass to adjust quiet zone width
        0
      end
    
      def width
        (self.encoded_data.length * @bar_width) + (self.quiet_zone_width * 2)
      end
    
      def height
        @captioned ? @caption_height + @bar_height : @bar_height
      end
    
      def valid?
        # Should be overridden in subclass to validate barcode
        valid = @data.length > 0 ? true : false
      
        @data.each_char do |char|
          if self._encode_character(char).nil?
            valid = false
          end
        end
      
        return valid
      end
    
      protected
    
      def _encode_character(character)
        # Must be overridden in subclass to encode given character
        0
      end
    end
  end
end