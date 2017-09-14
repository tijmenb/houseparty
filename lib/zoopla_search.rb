class ZooplaSearch
  # Full docs: https://developer.zoopla.co.uk/docs/read/Property_listings
  BASE_QUERY = {
    api_key: Configs.fetch('ZOOPLA_API_KEY'),
    order_by: 'age',
    listing_status: 'rent',
    furnished: 'unfurnished',
    page_size: 25,
    include_rented: false,
    minimum_price: ((1400 * 12) / 52).to_i,
    maximum_price: ((1900 * 12) / 52).to_i,
    minimum_beds: '1',
  }

  SEARCHES = [
    {
      area: 'Tower Hamlets, London',
    },
    {
      area: 'Islington, London',
    },
    {
      area: 'Hackney, London',
    },
  ]

  BASE_URL = 'https://api.zoopla.co.uk/api/v1/property_listings.json'

  def listings
    SEARCHES.map do |search_query|
      JSON.parse(search_zoopla(search_query))['listing'].each do |source|
        source["area"] = search_query[:area].gsub(', London', '')
        source["from"] = Date.parse(source["available_from_date"])
        source
      end
    end.flatten.compact
  end

private

  def search_zoopla(search_query)
    query = BASE_QUERY.merge(search_query)
    puts "Executing Zoopla search: #{query}"
    HTTParty.get(BASE_URL, query: query).body
  end
end
