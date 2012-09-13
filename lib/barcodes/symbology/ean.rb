# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    
    # This is the base class for all EAN type (EAN8, EAN13, UPC-A) barcode symbologies.
    # EAN type barcodes can encode only the numbers 0-9
    # 
    # More info: http://en.wikipedia.org/wiki/European_Article_Number
    class Ean < Base
      
      # EAN character set
      def self.charset
        ['0','1','2','3','4','5','6','7','8','9','S','C'].collect {|c| c.bytes.to_a[0] }
      end
      
      # EAN parity values table
      def self.parity
        [
          "000000", "001011", "001101", "001110",
          "010011", "011001", "011100", "010101",
          "010110", "011010"
        ]
      end
      
      # EAN left hand even values table
      def self.left_hand_even
        [
          "0001101", "0011001", "0010011", "0111101",
          "0100011", "0110001", "0101111", "0111011",
          "0110111", "0001011"
        ]
      end
      
      # EAN left hand odd values table
      def self.left_hand_odd
        [
          "0100111", "0110011", "0011011", "0100001",
          "0011101", "0111001", "0000101", "0010001",
          "0001001", "0010111"
        ]
      end
      
      # EAN right hand values table
      def self.right_hand
        [
          "1110010", "1100110", "1101100", "1000010",
          "1011100", "1001110", "1010000", "1000100",
          "1001000", "1110100"
        ]
      end
      
      # EAN uses special value sets so this returns an empty array
      def self.valueset
        []
      end
      
      # Creates a new EAN instance
      def initialize(args={})
        super(args)
        
        @start_character = 'S'
        @stop_character = 'S'
        @center_character = 'C'
      end
      
      # Returns data + checksum
      def caption_data
        @data + self.checksum
      end
      
      # Encodes data into 1's and 0's
      def encoded_data
        if self.valid?
          formatted_data = self.formatted_data
          encoded_data = ""
          parity = nil
          index = 0
          formatted_data.each_byte do |char|
            if char.chr == 'S'
              encoded_data += "101"
            elsif char.chr == 'C'
              encoded_data += "01010"
            else
              if index < 8
                unless parity.nil?
                  encoded_data += self._encode_character_with_parity(char, parity[index - 2])
                else
                  parity = self.class.parity.at(self.class.charset.index(char))
                end
              else
                encoded_data += self._encode_character_with_right_hand(char)
              end
            end
            index += 1
          end
          encoded_data
        end
      end
      
      # EAN uses quiet zone that is 9 times the bar width in mils
      def quiet_zone_width
        self.bar_width * 9
      end
      
      # Calculates the checksum
      def checksum
        if self.valid?
          sum = 0
          index = 1
          @data.reverse.each_char do |char|
            if ('0'..'9').include? char
              if index.even?
                sum += char.to_i
              else
                sum += char.to_i * 3
              end
            end
            index += 1
          end
          
          value = 10 - (sum % 10)
          
          return value.to_s
        end
      end
      
      protected
      
      # Encodes a single given character (as ASCII integer) using the given parity (1,0)
      def _encode_character_with_parity(character, parity)
        if self.class.charset.include? character
          if parity.to_i.even?
            self.class.left_hand_even.at(self.class.charset.index(character))
          else
            self.class.left_hand_odd.at(self.class.charset.index(character))
          end
        else
          return nil
        end
      end
      
      # Encodes a single given character (as ASCII integer) using right hand values table
      def _encode_character_with_right_hand(character)
        if self.class.charset.include? character
          self.class.right_hand.at(self.class.charset.index(character))
        else
          return nil
        end
      end
      
      # Returns nil
      def _encode_character(character)
        nil
      end
    end
  end
end