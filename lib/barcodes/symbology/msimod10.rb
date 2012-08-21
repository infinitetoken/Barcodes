require 'barcodes/symbology/msi'

module Barcodes
  module Symbology
    class MsiMod10 < Msi
      def formatted_data
        checksum = self.checksum
        unless checksum.nil?
          @start_character + @data + checksum + @stop_character
        end
      end
      
      def checksum
        if self.valid?
          used_nums = []
          unused_nums = []
          index = 0
          data.reverse.each_char do |char|
            if index.even?
              used_nums << char.to_i
            else
              unused_nums << char.to_i
            end
            index += 1
          end
          used_nums.reverse!
          unused_nums.reverse!
          
          sum = 0
          (used_nums.join.to_i * 2).to_s.split(//).each do |n|
            sum += n.to_i
          end
          unused_nums.each do |n|
            sum += n
          end
        
          value = 10 - (sum % 10)
          
          if value == 10
            value = 0
          end
        
          if (0..9).include? value
            return value.to_s
          end
        end
      end
    end
  end
end