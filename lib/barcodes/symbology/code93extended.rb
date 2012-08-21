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
        self.data.each_char do |char|
          unless self._encode_character(char).nil?
            _data += char
          else
            case char
            when '!'
              _data += '(/)' + 'A'
            when '"'
              _data += '(/)' + 'B'
            when '#'
              _data += '(/)' + 'C'
            when '$'
              _data += '(/)' + 'D'
            when '%'
              _data += '(/)' + 'E'
            when '&'
              _data += '(/)' + 'F'
            when '\''
              _data += '(/)' + 'G'
            when '('
              _data += '(/)' + 'H'
            when ')'
              _data += '(/)' + 'I'
            when '*'
              _data += '(/)' + 'J'
            when '+'
              _data += '(/)' + 'K'
            when ','
              _data += '(/)' + 'L'
            when '/'
              _data += '(/)' + 'O'
            when ':'
              _data += '(/)' + 'Z'
            when ';'
              _data += '(%)' + 'F'
            when '<'
              _data += '(%)' + 'G'
            when '='
              _data += '(%)' + 'H'
            when '>'
              _data += '(%)' + 'I'
            when '?'
              _data += '(%)' + 'J'
            when '@'
              _data += '(%)' + 'V'
            when '['
              _data += '(%)' + 'K'
            when '\\'
              _data += '(%)' + 'L'
            when ']'
              _data += '(%)' + 'M'
            when '^'
              _data += '(%)' + 'N'
            when '_'
              _data += '(%)' + '0'
            when '`'
              _data += '(%)' + 'W'
            when 'a'...'z'
              _data += '(+)' + char.upcase
            when '{'
              _data += '(%)' + 'P'
            when '|'
              _data += '(%)' + 'Q'
            when '}'
              _data += '(%)' + 'R'
            when '~'
              _data += '(%)' + 'S'
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