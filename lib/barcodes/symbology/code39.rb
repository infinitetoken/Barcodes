# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    
    # This class represents the Code 39 symbology.
    # Code 39 can encode the numbers 0-9 and all capital
    # letters along with the following symbols: ' ','-',
    # '.','$','/','+','%','*'
    # 
    # More info: http://en.wikipedia.org/wiki/Code_39
    class Code39 < Base
      
      # The Code 39 character set
      def self.charset
        [
          '0','1','2','3','4','5','6','7','8','9',
          'A','B','C','D','E','F','G','H','I','J',
          'K','L','M','N','O','P','Q','R','S','T',
          'U','V','W','X','Y','Z',' ','-','.','$',
          '/','+','%','*'
        ].collect {|c| c.bytes.to_a[0] }
      end
      
      # The Code 39 values set
      def self.valueset
        [
          "1010011011010","1101001010110","1011001010110","1101100101010",
          "1010011010110","1010011010110","1011001101010","1011001101010",
          "1101001011010","1011001011010","1101010010110","1011010010110",
          "1101101001010","1010110010110","1101011001010","1011011001010",
          "1010100110110","1101010011010","1011010011010","1010110011010",
          "1101010100110","1011010100110","1101101010010","1010110100110",
          "1101011010010","1011011010010","1010101100110","1101010110010",
          "1011010110010","1010110110010","1100101010110","1001101010110",
          "1100110101010","1001011010110","1100101101010","1001101101010",
          "1001101011010","1001010110110","1100101011010","1001001001010",
          "1001001010010","1001010010010","1010010010010","1001011011010"
        ]
      end
      
      # Creates a new Code39 instance.
      def initialize(args={})
        super(args)
        
        @start_character = '*'
        @stop_character = '*'
      end
      
      # Code 39 includes the start and stop symbols in
      # the caption so caption_data is overridden here
      # to return the formatted data string
      def caption_data
        self.formatted_data
      end
      
      # Start character + data + stop character
      def formatted_data
        @start_character + @data + @stop_character
      end
    end
  end
end