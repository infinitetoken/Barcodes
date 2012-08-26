require 'barcodes/symbology/code39'

module Barcodes
  module Symbology
    class Code39Extended < Code39
      
      protected
      
      def _encode_character(character)
        unless (character == 36 || character == 37 || character == 43)
          unless super(character).nil?
            return super(character)
          end
        end
        
        case character
        when 0
          return super('%'.bytes.to_a[0]) + super('U'.bytes.to_a[0])
        when 1..26
          return super('$'.bytes.to_a[0]) + super((character.bytes.to_a[0] + 64))
        when 27..31
          return super('%'.bytes.to_a[0]) + super((character.bytes.to_a[0] + 38))
        when 127
          return super('%'.bytes.to_a[0]) + super('T'.bytes.to_a[0])
        when '!'.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('A'.bytes.to_a[0])
        when '"'.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('B'.bytes.to_a[0])
        when '#'.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('C'.bytes.to_a[0])
        when '$'.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('D'.bytes.to_a[0])
        when '%'.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('E'.bytes.to_a[0])
        when '&'.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('F'.bytes.to_a[0])
        when '\''.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('G'.bytes.to_a[0])
        when '('.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('H'.bytes.to_a[0])
        when ')'.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('I'.bytes.to_a[0])
        when '*'.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('J'.bytes.to_a[0])
        when '+'.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('K'.bytes.to_a[0])
        when ','.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('L'.bytes.to_a[0])
        when '/'.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('O'.bytes.to_a[0])
        when ':'.bytes.to_a[0]
          return super('/'.bytes.to_a[0]) + super('Z'.bytes.to_a[0])
        when ';'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('F'.bytes.to_a[0])
        when '<'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('G'.bytes.to_a[0])
        when '='.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('H'.bytes.to_a[0])
        when '>'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('I'.bytes.to_a[0])
        when '?'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('J'.bytes.to_a[0])
        when '@'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('V'.bytes.to_a[0])
        when '['.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('K'.bytes.to_a[0])
        when '\\'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('L'.bytes.to_a[0])
        when ']'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('M'.bytes.to_a[0])
        when '^'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('N'.bytes.to_a[0])
        when '_'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('0'.bytes.to_a[0])
        when '`'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('W'.bytes.to_a[0])
        when 97..122
          return super('+'.bytes.to_a[0]) + super(character.chr.upcase.bytes.to_a[0])
        when '{'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('P'.bytes.to_a[0])
        when '|'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('Q'.bytes.to_a[0])
        when '}'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('R'.bytes.to_a[0])
        when '~'.bytes.to_a[0]
          return super('%'.bytes.to_a[0]) + super('S'.bytes.to_a[0])
        else
          return nil
        end
      end
    end
  end
end