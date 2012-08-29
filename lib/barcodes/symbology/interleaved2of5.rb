# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    
    # This class represents the Interleaved 2 of 5 symbology
    # Interleaved 2 of 5 can encode only numbers 0-9
    # 
    # More info: http://en.wikipedia.org/wiki/Interleaved_2_of_5
    class Interleaved2Of5 < Base
      
      # Interleaved 2 of 5 character set
      def self.charset
        ['0','1','2','3','4','5','6','7','8','9','S','E'].collect {|c| c.bytes.to_a[0] }
      end
      
      # Interleaved 2 of 5 values set
      def self.valueset
        [
          '101011011010','110101010110','101101010110','110110101010',
          '101011010110','110101101010','101101101010','101010110110',
          '110101011010','101101011010','1010','1101'
        ]
      end
      
      # Creates a new Interleaved2Of5 instance
      # Interleaved 2 of 5 must have the start and stop characters
      # 'S' and 'E' so they are overridden here.
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