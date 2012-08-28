# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

require 'spec_helper'
require 'barcodes'

describe Barcodes do
  describe "#create" do
    it "takes a symbology name and options and return an concrete barcode class" do
      Barcodes.create('Codabar', {}).should be_a_kind_of Barcodes::Symbology::Base
      Barcodes.create('Codabar', {}).should be_an_instance_of Barcodes::Symbology::Codabar
    end
    
    it "should throw an error if an unknown symbology is given" do
      lambda { Barcodes.create('Codabar') }.should_not raise_error(ArgumentError)
      lambda { Barcodes.create('Bad Symbology Name') }.should raise_error(ArgumentError)
    end
  end
  
  describe "#render" do
    it "should create and render a barcode with given symbology name and output string" do
      Barcodes.render('Codabar').should_not be_nil
      Barcodes.render('Codabar').should be_an_instance_of String
    end
    
    it "should return nil with unknown renderer" do
      Barcodes.render('Codabar', nil, {}, nil).should be_nil
    end
  end
end