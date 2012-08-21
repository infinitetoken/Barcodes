require 'barcodes/symbology/code39'

module Barcodes
  module Symbology
    class Code39Extended < Code39
      
      protected
      
      def _encode_character(character)
        unless (character == '$' || character == '%' || character == '+')
          unless super(character).nil?
            return super(character)
          end
        end
        
        case character
        when '!'
          return super('/') + super('A')
        when '"'
          return super('/') + super('B')
        when '#'
          return super('/') + super('C')
        when '$'
          return super('/') + super('D')
        when '%'
          return super('/') + super('E')
        when '&'
          return super('/') + super('F')
        when '\''
          return super('/') + super('G')
        when '('
          return super('/') + super('H')
        when ')'
          return super('/') + super('I')
        when '*'
          return super('/') + super('J')
        when '+'
          return super('/') + super('K')
        when ','
          return super('/') + super('L')
        when '/'
          return super('/') + super('O')
        when ':'
          return super('/') + super('Z')
        when ';'
          return super('%') + super('F')
        when '<'
          return super('%') + super('G')
        when '='
          return super('%') + super('H')
        when '>'
          return super('%') + super('I')
        when '?'
          return super('%') + super('J')
        when '@'
          return super('%') + super('V')
        when '['
          return super('%') + super('K')
        when '\\'
          return super('%') + super('L')
        when ']'
          return super('%') + super('M')
        when '^'
          return super('%') + super('N')
        when '_'
          return super('%') + super('0')
        when '`'
          return super('%') + super('W')
        when 'a'...'z'
          return super('+') + super(character.upcase)
        when '{'
          return super('%') + super('P')
        when '|'
          return super('%') + super('Q')
        when '}'
          return super('%') + super('R')
        when '~'
          return super('%') + super('S')
        else
          return nil
        end
      end
    end
  end
end