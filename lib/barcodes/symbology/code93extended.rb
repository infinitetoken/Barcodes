require 'barcodes/symbology/code93'

module Barcodes
  module Symbology
    class Code93Extended < Code93
      
      def formatted_data
        checksum = self.checksum
        unless checksum.nil?
          @start_character + self._data + checksum + @stop_character
        end
      end
      
      def checksum
        if self.valid?
          data = self._data
          c_value = self._checksum(data, 20)
          k_value = self._checksum(data + c_value, 15)
          return c_value + k_value
        end
      end
      
      def valid?
        return !self._data.nil?
      end
      
      protected

      def _data
        _data = ''
        self.data.each_byte do |char|
          unless self._encode_character(char).nil?
            _data += char.chr
          else
            case char
            when 0
              _data += "\xFD" + "U"
            when 1..26
              _data += "\xFC" + (char + 64).chr
            when 27..31
              _data += "\xFD" + (char + 38).chr
            when 127
              _data += "\xFD" + "T"
            when '!'.bytes.to_a[0]
              _data += "\xFE" + "A"
            when '"'.bytes.to_a[0]
              _data += "\xFE" + "B"
            when '#'.bytes.to_a[0]
              _data += "\xFE" + "C"
            when '$'.bytes.to_a[0]
              _data += "\xFE" + "D"
            when '%'.bytes.to_a[0]
              _data += "\xFE" + "E"
            when '&'.bytes.to_a[0]
              _data += "\xFE" + "F"
            when '\''.bytes.to_a[0]
              _data += "\xFE" + "G"
            when '('.bytes.to_a[0]
              _data += "\xFE" + "H"
            when ')'.bytes.to_a[0]
              _data += "\xFE" + "I"
            when '*'.bytes.to_a[0]
              _data += "\xFE" + "J"
            when '+'.bytes.to_a[0]
              _data += "\xFE" + "K"
            when ','.bytes.to_a[0]
              _data += "\xFE" + "L"
            when '/'.bytes.to_a[0]
              _data += "\xFE" + "O"
            when ':'.bytes.to_a[0]
              _data += "\xFE" + "Z"
            when ';'.bytes.to_a[0]
              _data += "\xFD" + "F"
            when '<'.bytes.to_a[0]
              _data += "\xFD" + "G"
            when '='.bytes.to_a[0]
              _data += "\xFD" + "H"
            when '>'.bytes.to_a[0]
              _data += "\xFD" + "I"
            when '?'.bytes.to_a[0]
              _data += "\xFD" + "J"
            when '@'.bytes.to_a[0]
              _data += "\xFD" + "V"
            when '['.bytes.to_a[0]
              _data += "\xFD" + "K"
            when '\\'.bytes.to_a[0]
              _data += "\xFD" + "L"
            when ']'.bytes.to_a[0]
              _data += "\xFD" + "M"
            when '^'.bytes.to_a[0]
              _data += "\xFD" + "N"
            when '_'.bytes.to_a[0]
              _data += "\xFD" + "0"
            when '`'.bytes.to_a[0]
              _data += "\xFD" + "W"
            when 97..122
              _data += "\xFF" + char.chr.upcase
            when '{'.bytes.to_a[0]
              _data += "\xFD" + "P"
            when '|'.bytes.to_a[0]
              _data += "\xFD" + "Q"
            when '}'.bytes.to_a[0]
              _data += "\xFD" + "R"
            when '~'.bytes.to_a[0]
              _data += "\xFD" + "S"
            else
              return nil
            end
          end
        end
        
        return _data
      end
    end
  end
end