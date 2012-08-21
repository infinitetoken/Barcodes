require 'barcodes/symbology/code39extended'

module Barcodes
  module Symbology
    class Code39ExtendedMod43 < Code39Extended
      def caption_data
        @start_character + @data + @stop_character
      end
      
      def formatted_data
        checksum = self.checksum
        unless checksum.nil?
          @start_character + @data + checksum + @stop_character
        end
      end
      
      def checksum
        if valid?
          sum = 0
          self.data.each_char do |char|
            if ('0'..'9').include? char
              sum += char.to_i
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

          value = sum % 43

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
            end
          end
        end
      end
    end
  end
end