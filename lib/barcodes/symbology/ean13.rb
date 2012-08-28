require 'barcodes/symbology/ean'

module Barcodes
  module Symbology
    class Ean13 < Ean
      def initialize(args={})
        unless args.has_key? :data
          args[:data] = '012345678999'
        end
        
        super(args)
      end
      
      def formatted_data
        @start_character + @data[0..6] + @center_character + @data[7..12] + self.checksum + @stop_character
      end
      
      def valid?
        unless super
          return false
        end
        
        return self.data.length == 12 ? true : false
      end
    end
  end
end