require 'barcodes/symbology/standard'

module Barcodes
  module Symbology
    class Code93 < Standard
      def initialize(args={})
        super(args)
        
        @start_character = '*'
        @stop_character = '*'
      end
      
      def caption_data
        @start_character + @data + @stop_character
      end
      
      def formatted_data
        checksum = self.checksum
        unless checksum.nil?
          @start_character + @data + checksum + @stop_character
        end
      end
      
      def encoded_data
        if self.valid?
          encoded_data = ''
          shifted = false
          shifted_char = ''
          self.formatted_data.each_char do |char|
            if shifted || char == '(' || char == ')'
              if shifted && char != ')'
                shifted_char = char
              elsif char == ')'
                shifted = false
                encoded_data += self._encode_character("(#{shifted_char})")
              else
                shifted = true
              end
            else
              encoded_data += self._encode_character char
            end
          end
          encoded_data
        end
      end
      
      def checksum
        if self.valid?
          c_value = self._checksum(@data, 20)
          k_value = self._checksum(@data + c_value, 15)
          return c_value + k_value
        end
      end
      
      protected
      
      def _checksum(data, weight_max)
        sum = 0
        weight = 1
        shifted = false
        data.reverse.each_char do |char|
          if shifted || char == '(' || char == ')'
            if shifted && char != '('
              case char
              when '$'
                sum += 43
              when '%'
                sum += 44
              when '/'
                sum += 45
              when '+'
                sum += 46
              end
            elsif char == ')'
              shifted = true
            else
              shifted = false
            end
          else
            if ('0'..'9').include? char
              sum += weight * char.to_i
            elsif ('A'..'Z').include? char
              sum += ('A'..'Z').to_a.index(char) + 10
            else
              case char
              when '-'
                sum += 36
              when '.'
                sum += 37
              when ' '
                sum += 38
              when '$'
                sum += 39
              when '/'
                sum += 40
              when '+'
                sum += 41
              when '%'
                sum += 42
              end
            end
          end
          if weight <= weight_max
            weight += 1
          else
            weight = 1
          end
        end
        
        value = sum % 47
        
        if (0..9).include? value
          return value.to_s
        elsif value >= 10 && value < 36
          return ('A'..'Z').to_a.fetch(value - 10)
        else
          case value
          when 36
            return '-'
          when 37
            return '.'
          when 38
            return ' '
          when 39
            return '$'
          when 40
            return '/'
          when 41
            return '+'
          when 42
            return '%'
          when 43
            return '($)'
          when 44
            return '(%)'
          when 45
            return '(/)'
          when 46
            return '(+)'
          end
        end
      end
      
      def _encode_character(character)
        case character
        when '0'
          return "100010100"
        when '1'
          return "101001000"
        when '2'
          return "101000100"
        when '3'
          return "101000010"
        when '4'
          return "100101000"
        when '5'
          return "100100100"
        when '6'
          return "100100010"
        when '7'
          return "101010000"
        when '8'
          return "100010010"
        when '9'
          return "100001010"
        when 'A'
          return "110101000"
        when 'B'
          return "110100100"
        when 'C'
          return "110100010"
        when 'D'
          return "110010100"
        when 'E'
          return "110010010"
        when 'F'
          return "110001010"
        when 'G'
          return "101101000"
        when 'H'
          return "101100100"
        when 'I'
          return "101100010"
        when 'J'
          return "100110100"
        when 'K'
          return "100011010"
        when 'L'
          return "101011000"
        when 'M'
          return "101001100"
        when 'N'
          return "101000110"
        when 'O'
          return "100101100"
        when 'P'
          return "100010110"
        when 'Q'
          return "110110100"
        when 'R'
          return "110110010"
        when 'S'
          return "110101100"
        when 'T'
          return "110100110"
        when 'U'
          return "110010110"
        when 'V'
          return "110011010"
        when 'W'
          return "101101100"
        when 'X'
          return "101100110"
        when 'Y'
          return "100110110"
        when 'Z'
          return "100111010"
        when ' '
          return "111010010"
        when '-'
          return "100101110"
        when '.'
          return "111010100"
        when '$'
          return "111001010"
        when '/'
          return "101101110"
        when '+'
          return "101110110"
        when '%'
          return "110101110"
        when '($)'
          return "100100110"
        when '(/)'
          return "111010110"
        when '(+)'
          return "100110010"
        when '(%)'
          return "111011010"
        when '*'
          return "101011110"
        else
          return nil
        end
      end
    end
  end
end