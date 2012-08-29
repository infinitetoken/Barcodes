# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    
    # This class represents the Standard 2 of 5 symbology
    # Standard 2 of 5 can encode only numbers 0-9
    # 
    # More info: http://en.wikipedia.org/wiki/Two-out-of-five_code
    class Standard2Of5 < Base
      
      # Standard 2 of 5 character set
      def self.charset
        ['0','1','2','3','4','5','6','7','8','9','S','E'].collect {|c| c.bytes.to_a[0] }
      end
      
      # Standard 2 of 5 values set
      def self.valueset
        [
          '10101110111010','11101010101110','10111010101110','11101110101010',
          '10101110101110','11101011101010','10111011101010','10101011101110',
          '11101010111010','10111010111010','11011010','1101011'
        ]
      end
      
      # Creates a new Standard2Of5 instance
      def initialize(args={})
        super(args)
        
        @start_character = 'S'
        @stop_character = 'E'
      end
      
      # Returns start character + data + stop character
      def formatted_data
        @start_character + @data + @stop_character
      end
    end
  end
end