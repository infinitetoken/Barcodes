require 'spec_helper'
require 'barcodes'

describe Barcodes do
  it 'should return correct version' do
    Barcodes::VERSION == Barcodes::VERSION
  end
end