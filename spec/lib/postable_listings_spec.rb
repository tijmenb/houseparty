require 'spec_helper'

describe PostableListings do
  describe '#listings' do
    it "doesn't return anything when zoopla doesn't return listings" do
      zoopla = double(:zoopla, listings: [])

      listings = PostableListings.new(zoopla).listings

      expect(listings).to eql([])
    end

    it "returns the listings from Zoopla" do
      zoopla = double(:zoopla, listings: [ { 'listing_id' => '123123' } ])

      listings = PostableListings.new(zoopla).listings

      expect(listings).to eql([ { 'listing_id' => '123123' } ])
    end

    it "doesn't include listings that have been posted already" do
      PostableListings.exclude('123')
      zoopla = double(:zoopla, listings: [ { 'listing_id' => '123' },  { 'listing_id' => '456' }])

      listings = PostableListings.new(zoopla).listings

      expect(listings).to eql([ { 'listing_id' => '456' } ])
    end
  end
end
