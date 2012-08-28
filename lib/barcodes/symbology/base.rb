module Barcodes
  module Symbology
    class Base
      attr_accessor :data
      attr_accessor :start_character
      attr_accessor :stop_character
      attr_accessor :bar_width
      attr_accessor :bar_height
      attr_accessor :alpha
      attr_accessor :color
      attr_accessor :caption_height
      attr_accessor :caption_size
      attr_accessor :captioned
      
      def self.charset
        # Should be overridden by subclass to provide charset
        [].collect {|c| c.bytes.to_a[0] }
      end
      
      def self.valueset
        # Should be overridden by subclass to provide valueset
        []
      end
    
      def initialize(args={})
        @data = '0123456789'
        @start_character = ''
        @stop_character = ''
        @bar_width = 20
        @bar_height = 1000
        @alpha = 1.0
        @color = '000000'
        @caption_height = 180
        @caption_size = 167
        @captioned = true
      
        args.each do |k,v|
          instance_variable_set("@#{k}", v) unless v.nil?
        end
      end
    
      def caption_data
        # Can be overridden by subclass to format data string for display
        self.data
      end
    
      def formatted_data
        # Can be overridden by subclass to add additional formatting to data string
        self.data
      end
    
      def encoded_data
        if self.valid?
          encoded_data = ""
          self.formatted_data.each_byte do |char|
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
        if valid?
          (self.encoded_data.length * self.bar_width) + (self.quiet_zone_width * 2)
        else
          0
        end
      end
    
      def height
        self.captioned ? self.caption_height + self.bar_height : self.bar_height
      end
    
      def valid?
        # Can be overridden in subclass to validate barcode
        valid = self.data.length > 0 ? true : false
      
        self.data.each_byte do |char|
          if self._encode_character(char).nil?
            return false
          end
        end
      
        return valid
      end
    
      protected
    
      def _encode_character(character)
        if self.class.charset.include? character
          return self.class.valueset.at(self.class.charset.index(character))
        else
          return nil
        end
      end
    end
  end
end