# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

# 
module Barcodes
  module Symbology
    
    # Base class for all barcode symbologies.
    class Base
      # Data to be encoded.
      attr_accessor :data
      
      # Bar width in mils
      attr_accessor :bar_width
      
      # Bar height in mils
      attr_accessor :bar_height
      
      # Alpha (transparency)
      attr_accessor :alpha
      
      # Color in hex
      attr_accessor :color
      
      # Caption height in mils
      attr_accessor :caption_height
      
      # Caption font size in mils
      attr_accessor :caption_size
      
      # Whether or not to print caption
      attr_accessor :captioned
      
      # Returns the barcode symbologies character set as array of
      # ASCII integer values. This method should be overridden by 
      # concrete subclass to provide character set for symbology.
      def self.charset
        # Should be overridden by subclass to provide charset
        [].collect {|c| c.bytes.to_a[0] }
      end
      
      # Returns the values of the symbologies character set as 
      # array of encoded sets. This method should be overridden by 
      # concrete subclass to provide value set for symbology.
      def self.valueset
        []
      end
    
      # Creates a new barcode instance with given arguments.
      # See class attributes for list of acceptable arguments.
      def initialize(args={})
        @data = '0123456789'
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
      
      # Returns the data to be printed in barcode caption.
      # Could be overridden by concrete subclass to provide 
      # additional formatting.
      def caption_data
        self.data
      end
      
      # Returns the formatted barcode data to be encoded
      # Could be overridden by concrete subclass to add additional
      # formatting to data string.
      def formatted_data
        self.data
      end
    
      # Returns the formatted barcode data encoded as 1's and 0's.
      def encoded_data
        if self.valid?
          encoded_data = ""
          self.formatted_data.each_byte do |char|
            encoded_data += self._encode_character char
          end
          encoded_data
        end
      end
      
      # Returns the symbologies quiet zone width in mils.
      # Should be overridden by concrete subclass to provide 
      # quiet zone width if applicable.
      def quiet_zone_width
        0
      end
      
      # Returns the overall width of the barcode in mils.
      def width
        if valid?
          (self.encoded_data.length * self.bar_width) + (self.quiet_zone_width * 2)
        else
          0
        end
      end
      
      # Returns the overall height of the barcode in mils.
      def height
        self.captioned ? self.caption_height + self.bar_height : self.bar_height
      end
      
      # Determines whether or not the barcode data to be encoded
      # is valid.
      # Should be overridden in concrete subclass to provide validation.
      def valid?
        valid = self.data.length > 0 ? true : false
      
        self.data.each_byte do |char|
          if self._encode_character(char).nil?
            return false
          end
        end
      
        return valid
      end
    
      protected
      
      # Encodes a single given ASCII character (as integer) into 1's and 0's.
      # Returns nil if character is not found in character set.
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