class ListingFormatter
  INTERESTING_PROPERTIES = [
    "description",
    "num_bedrooms",
    "available_from_date",
    "first_published_date",
    "agent_name",
  ]

  attr_reader :source

  def initialize(source)
    @source = source
  end

  def payload
    {
      name: name,
      desc: description,
    }
  end

private

  def name
    address = source.fetch('displayable_address')
    price = source.fetch('rental_prices').fetch('per_month')
    area = source.fetch('area')
    "#{address} - £#{price} (#{area})"
  end

  def description
    [
      "### " + source.fetch('details_url'),
      source.slice(*INTERESTING_PROPERTIES).map { |k,v| "**#{k}**: #{v}" },
      "https://www.google.com/maps/dir/52+Wharf+Rd,+London+N1/#{url_safe_location}",
      "https://www.google.com/maps/dir/133-137+Whitechapel+High+Street,+London,+UK/#{url_safe_location}",
    ].flatten.join("\n\n")
  end

  def url_safe_location
    source.fetch('displayable_address').gsub(' ', '+')
  end
end
