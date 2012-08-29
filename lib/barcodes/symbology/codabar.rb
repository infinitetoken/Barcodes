# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    
    # This class represents the Codabar symbology.
    # Codabar can encode the numbers 0-9 and the 
    # following symbols: -,$,:,/,.,+
    # 
    # More info: http://en.wikipedia.org/wiki/Codabar
    class Codabar < Base
      
      # Start character
      attr_accessor :start_character
      
      # Stop character
      attr_accessor :stop_character
      
      # Codabar character set (0-9,-,$,:,/,.,+)
      def self.charset
        ['0','1','2','3','4','5','6','7','8','9','-','$',':','/','.','+','A','B','C','D'].collect {|c| c.bytes.to_a[0] }
      end
      
      # Codabar values set
      def self.valueset
        [
          '1010100110','1010110010','1010010110','110010101',
          '101101001','110101001','100101011','100101101',
          '100110101','110100101','101001101','101100101',
          '1101011011','1101101011','1101101101','101100110011',
          '1011001001','1010010011','1001001011','1010011001'
        ]
      end
      
      # Creates a new Codabar instance with given arguments.
      def initialize(args={})
        unless args.has_key? :start_character
          args[:start_character] = 'A'
        end
        unless args.has_key? :stop_character
          args[:stop_character] = 'B'
        end
        
        super(args)
      end
      
      # Start character + data + stop character
      def formatted_data
        @start_character + @data + @stop_character
      end
    end
  end
end