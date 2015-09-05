require 'spec_helper'

describe ZooplaSearch do
  describe '#listings' do
    it 'returns listings from the Zoopla API' do
      stub_request(:get, %r[http://api.zoopla.co.uk/api/v1/property_listings.json*]).
        to_return(body: read_fixture('zoopla-listings'))

      listings = ZooplaSearch.new.listings

      expect(listings.size).to eql(20)
    end
  end
end
