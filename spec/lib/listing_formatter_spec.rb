require 'spec_helper'

describe ListingFormatter do
  EXAMPLE_LISTING =  {
    "rental_prices"=>{"per_week"=>"350", "accurate"=>"per_week", "per_month"=>"1517"},
    "num_floors"=>"0",
    "listing_status"=>"rent",
    "num_bedrooms"=>"1",
    "latitude"=>51.56676,
    "agent_address"=>"97 Newington Green Road, Islington",
    "property_type"=>"Flat",
    "letting_fees"=>"Things about fees.",
    "longitude"=>-0.058209,
    "thumbnail_url"=>"http://li.zoocdn.com/8e02e8e7888537e3458cb860d8d5c8ae196ad0ed_80_60.jpg",
    "description"=>"A long description.",
    "post_town"=>"London",
    "details_url"=>"http://www.zoopla.co.uk/the-url",
    "short_description"=>"<p class=\"top\">Some description with HTML.</p>",
    "outcode"=>"E5",
    "county"=>"London",
    "price"=>"350",
    "listing_id"=>"38023058",
    "image_caption"=>"Kitchen.Jpg",
    "status"=>"to_rent",
    "agent_name"=>"M&M Property",
    "num_recepts"=>"1",
    "country"=>"England",
    "displayable_address"=>"Moresby Road, London E5",
    "first_published_date"=>"2015-09-05 09:26:00",
    "floor_plan"=>["http://lc.zoocdn.com/bffcd4b9ba0711bab00df859c960845979730c2a.jpg"],
    "street_name"=>"Moresby Road",
    "num_bathrooms"=>"1",
    "price_change"=>[{"date"=>"2015-09-05 09:25:09", "price"=>"350.00"}],
    "agent_logo"=>"http://st.zoocdn.com/zoopla_static_agent_logo_(64777).jpeg",
    "agent_phone"=>"020 3318 7014",
    "image_url"=>"http://li.zoocdn.com/8e02e8e7888537e3458cb860d8d5c8ae196ad0ed_354_255.jpg",
    "last_published_date"=>"2015-09-05 09:26:57"
  }

  describe '#format' do
    it "works" do
      formatter = ListingFormatter.new(EXAMPLE_LISTING)

      payload = formatter.payload

      expect(payload).to eql(
        name: "Moresby Road, London E5 - £1517",
        desc: "A long description.\n\n### http://www.zoopla.co.uk/the-url\n\nhttps://www.google.com/maps/dir/52+Wharf+Rd,+London+N1/Moresby+Road,+London+E5\n\nhttps://www.google.com/maps/dir/Holborn,+London,+UK/Moresby+Road,+London+E5"
      )
    end
  end
end
