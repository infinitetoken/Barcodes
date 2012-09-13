# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'barcodes/symbology/base'

module Barcodes
  module Symbology
    
    # This class represents the Code 128 symbology.
    # Code 128 can encode all 128 ASCII characters using
    # three different code sets.
    #
    # More info: http://en.wikipedia.org/wiki/Code_128
    # 
    # Assigned to code sets where applicable are the following 
    # special characters representing Code 128 functions:
    # 
    # * START_A - \xF4
    # * START_B - \xF5
    # * START_C - \xF6
    # * CODE_A - \xF7
    # * CODE_B - \xF8
    # * CODE_C - \xF9
    # * FNC1 - \xFA
    # * FNC2 - \xFB 
    # * FNC3 - \xFC
    # * FNC4 - \xFD
    # * SHIFT - \xFE
    # * STOP - \xFF
    class Code128 < Base
      
      # Code 128 uses three special character sets so this
      # returns an empty array
      def self.charset
        [].collect {|c| c.bytes.to_a[0] }
      end
      
      # Character code set A
      def self.charset_a
        [
          " ","!","\"","#","$","%","&","'","(",")","*","+",",","-",".","/",
          "0","1","2","3","4","5","6","7","8","9",":",";","<","=",">","?","@",
          "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q",
          "R","S","T","U","V","W","X","Y","Z","[","\\","]","^","_","\x00","\x01",
          "\x02","\x03","\x04","\x05","\x06","\x07","\x08","\x09","\x0A","\x0B",
          "\x0C","\x0D","\x0E","\x0F","\x10","\x11","\x12","\x13","\x14","\x15",
          "\x16","\x17","\x18","\x19","\x1A","\x1B","\x1C","\x1D","\x1E","\x1F",
          "\xFC","\xFB","\xFE","\xF9","\xF8","\xFD","\xFA","\xF4","\xF5","\xF6",
          "\xFF"
        ].collect {|c| c.bytes.to_a[0] }
      end
      
      # Character code set B
      def self.charset_b
        [
          " ","!","\"","#","$","%","&","'","(",")","*","+",",","-",".","/",
          "0","1","2","3","4","5","6","7","8","9",":",";","<","=",">","?","@",
          "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q",
          "R","S","T","U","V","W","X","Y","Z","[","\\","]","^","_","`","a","b",
          "c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s",
          "t","u","v","w","x","y","z","{","|","}","~","\x7F","\xFC","\xFB","\xFE",
          "\xF9","\xFD","\xF7","\xFA","\xF4","\xF5","\xF6","\xFF"
        ].collect {|c| c.bytes.to_a[0] }
      end
      
      # Character code set C
      def self.charset_c
        [
          "00","01","02","03","04","05","06","07","08","09","10","11","12","13",
          "14","15","16","17","18","19","20","21","22","23","24","25","26","27",
          "28","29","30","31","32","33","34","35","36","37","38","39","40","41",
          "42","43","44","45","46","47","48","49","50","51","52","53","54","55",
          "56","57","58","59","60","61","62","63","64","65","66","67","68","69",
          "70","71","72","73","74","75","76","77","78","79","80","81","82","83",
          "84","85","86","87","88","89","90","91","92","93","94","95","96","97",
          "98","99","\xF8","\xF7","\xFA","\xF4","\xF5","\xF6","\xFF"
        ].collect {|c| c.bytes.to_a.length > 1 ? c.bytes.to_a : c.bytes.to_a[0] }
      end
      
      # Code 128 values set
      def self.valueset
        [
          "11011001100","11001101100","11001100110","10010011000","10010001100",
          "10001001100","10011001000","10011000100","10001100100","11001001000",
          "11001000100","11000100100","10110011100","10011011100","10011001110",
          "10111001100","10011101100","10011100110","11001110010","11001011100",
          "11001001110","11011100100","11001110100","11101101110","11101001100",
          "11100101100","11100100110","11101100100","11100110100","11100110010",
          "11011011000","11011000110","11000110110","10100011000","10001011000",
          "10001000110","10110001000","10001101000","10001100010","11010001000",
          "11000101000","11000100010","10110111000","10110001110","10001101110",
          "10111011000","10111000110","10001110110","11101110110","11010001110",
          "11000101110","11011101000","11011100010","11011101110","11101011000",
          "11101000110","11100010110","11101101000","11101100010","11100011010",
          "11101111010","11001000010","11110001010","10100110000","10100001100",
          "10010110000","10010000110","10000101100","10000100110","10110010000",
          "10110000100","10011010000","10011000010","10000110100","10000110010",
          "11000010010","11001010000","11110111010","11000010100","10001111010",
          "10100111100","10010111100","10010011110","10111100100","10011110100",
          "10011110010","11110100100","11110010100","11110010010","11011011110",
          "11011110110","11110110110","10101111000","10100011110","10001011110",
          "10111101000","10111100010","11110101000","11110100010","10111011110",
          "10111101110","11101011110","11110101110","11010000100","11010010000",
          "11010011100","1100011101011"
        ]
      end
      
      # Data + checksum + stop character
      def formatted_data
        self._prepared_data + self.checksum + "\xFF"
      end
      
      # Data encoded as 1's and 0's using three code sets
      def encoded_data
        if self.valid?
          encoded_data = ""
          charset = 'A'
          char_c = nil
          self.formatted_data.each_byte do |char|
            if char == "\xF4".bytes.to_a[0] || char == "\xF5".bytes.to_a[0] || char == "\xF6".bytes.to_a[0]
              case char
              when "\xF4".bytes.to_a[0]
                encoded_data += self._encode_character_in_charset(char, 'A')
                charset = 'A'
              when "\xF5".bytes.to_a[0]
                encoded_data += self._encode_character_in_charset(char, 'B')
                charset = 'B'
              when "\xF6".bytes.to_a[0]
                encoded_data += self._encode_character_in_charset(char, 'C')
                charset = 'C'
              end
            elsif char == "\xF7".bytes.to_a[0] || char == "\xF8".bytes.to_a[0] || char == "\xF9".bytes.to_a[0] || char == "\xFE".bytes.to_a[0]
              case char
              when "\xF7".bytes.to_a[0]
                encoded_data += self._encode_character_in_charset(char, charset)
                charset = 'A'
              when "\xF8".bytes.to_a[0]
                encoded_data += self._encode_character_in_charset(char, charset)
                charset = 'B'
              when "\xF9".bytes.to_a[0]
                encoded_data += self._encode_character_in_charset(char, charset)
                charset = 'C'
              when "\xFE".bytes.to_a[0]
                if charset == 'A'
                  encoded_data += self._encode_character_in_charset(char, charset)
                  charset = 'B'
                elsif charset == 'B'
                  encoded_data += self._encode_character_in_charset(char, charset)
                  charset = 'A'
                end
              end
            else
              if charset == 'C'
                if char > 127
                  encoded_data += self._encode_character_in_charset(char, charset)
                else
                  if char_c.nil?
                    char_c = char
                  else
                    encoded_data += self._encode_character_in_charset([char_c, char], charset)
                    char_c = nil
                  end
                end
              else
                encoded_data += self._encode_character_in_charset(char, charset)
              end
            end
          end
          return encoded_data
        end
      end
      
      # Calculates the checksum using barcode data
      def checksum
        if valid?
          sum = 0
          index = 1
          charset = self.class.charset_a
          char_c = nil
          self._prepared_data.each_byte do |char|
            if char == "\xF4".bytes.to_a[0] || char == "\xF5".bytes.to_a[0] || char == "\xF6".bytes.to_a[0]
              sum += self.class.charset_a.index(char) if self.class.charset_a.include?(char)
              
              case char
              when "\xF4".bytes.to_a[0]
                charset = self.class.charset_a
              when "\xF5".bytes.to_a[0]
                charset = self.class.charset_b
              when "\xF6".bytes.to_a[0]
                charset = self.class.charset_c
              end
            elsif char == "\xF7".bytes.to_a[0] || char == "\xF8".bytes.to_a[0] || char == "\xF9".bytes.to_a[0] || char == "\xFE".bytes.to_a[0]
              sum += charset.index(char) * index if charset.include?(char)
              index += 1
              
              case char
              when "\xF7".bytes.to_a[0]
                charset = self.class.charset_a
              when "\xF8".bytes.to_a[0]
                charset = self.class.charset_b
              when "\xF9".bytes.to_a[0]
                charset = self.class.charset_c
              when "\xFE".bytes.to_a[0]
                if charset == self.class.charset_a
                  charset = self.class.charset_b
                elsif charset == self.class.charset_b
                  charset = self.class.charset_a
                end
              end
            else
              if charset == self.class.charset_c
                if char_c.nil?
                  char_c = char
                else
                  sum += charset.index([char_c, char]) * index if charset.include?([char_c, char])
                  index += 1
                  char_c = nil
                end
              else
                sum += charset.index(char) * index if charset.include?(char)
                index += 1
              end
            end
          end
          
          value = sum % 103
          
          if charset == self.class.charset_c
            return charset.at(value)[0].chr + charset.at(value)[1].chr
          else
            return charset.at(value).chr
          end
        end
      end
      
      # Validates the data
      def valid?
        valid = @data.length > 0 ? true : false
      
        @data.each_byte do |char|
          if self._encode_character_in_charset(char, 'A').nil? &&
             self._encode_character_in_charset(char, 'B').nil?
            return false
          end
        end
      
        return valid
      end
      
      protected
      
      # Inspects barcode data and determines the best character sets to use
      # for provided data
      def _prepared_data
        start = "\xF4"
        charset = "A"
        data = ""
        cursor = 0
        
        if /^[\d]{4,}/ === @data
          start = "\xF6"
          charset = "C"
        elsif self._encode_character_in_charset(@data.bytes.to_a[0], 'A').nil?
          start = "\xF4"
          charset = "B"
        end
        data += start
        
        (0...@data.length).each do |i|
          if charset == 'C' && cursor > i
            next
          else
            if charset == 'C' && /^[\d]{4,}/ === @data[i...@data.length]
              integers = 0
              (cursor...@data.length).each do |j|
                if /^[\d]/ === @data[j]
                  integers += 1
                else
                  break
                end
              end
              
              if integers.even?
                data += @data[cursor...(cursor + integers)]
                cursor += integers
              else
                data += @data[cursor...(cursor + integers - 1)]
                cursor += integers - 1
              end
            else
              if /^[\d]{4,}/ === @data[i...@data.length] && charset != 'C'
                data += "\xF9"
                charset = "C"
              elsif self._encode_character_in_charset(@data.bytes.to_a[i], charset).nil?
                if charset == 'C'
                  if self._encode_character_in_charset(@data.bytes.to_a[i], 'B').nil?
                    data += "\xF7"
                    charset = "A"
                  else
                    data += "\xF8"
                    charset = "B"
                  end
                else
                  # Shift
                  data += "\xFE"
                  if charset == "A"
                    charset = "B"
                  else
                    charset = "A"
                  end
                end
                data += @data[cursor]
                cursor += 1
              else
                data += @data[cursor]
                cursor += 1
              end
            end
          end
        end
        
        return data
      end
    
      # Returns nil due to Code 128 using special character sets
      def _encode_character(character)
        return nil
      end
      
      # Encodes a single character (as ASCII integer) using given 
      # character set
      def _encode_character_in_charset(character, charset)
        case charset
        when 'A'
          selected_charset = self.class.charset_a
        when 'B'
          selected_charset = self.class.charset_b
        when 'C'
          selected_charset = self.class.charset_c
        else
          return nil
        end
        
        if selected_charset.include? character
          return self.class.valueset.at(selected_charset.index(character))
        else
          return nil
        end
      end
    end
  end
end