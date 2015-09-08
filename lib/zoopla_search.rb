class ZooplaSearch
  BASE_QUERY = {
    api_key: Configs.fetch('ZOOPLA_API_KEY'),
    order_by: 'age',
    listing_status: 'rent',
    furnished: 'unfurnished',
    page_size: 50,
    include_rented: false,
    minimum_price: ((1000 * 12) / 52).to_i,
    maximum_price: ((1700 * 12) / 52).to_i,
  }

  SEARCHES = [
    {
      area: 'Hackney, London',
    },
    {
      area: 'Islington, London',
    },
    {
      area: 'Tower Hamlets, London',
    }
  ]

  BASE_URL = 'http://api.zoopla.co.uk/api/v1/property_listings.json'

  def listings
    SEARCHES.map do |search_query|
      JSON.parse(search_zoopla(search_query))['listing']
    end.flatten
  end

private

  def search_zoopla(search_query)
    HTTParty.get(BASE_URL, query: BASE_QUERY.merge(search_query)).body
  end
end
