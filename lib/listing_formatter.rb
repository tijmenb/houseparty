class ListingFormatter
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
    source.fetch('displayable_address') + ' - £' + source.fetch('rental_prices').fetch('per_month')
  end

  def description
    [
      source.fetch('description'),
      "### " + source.fetch('details_url'),
    ].join("\n\n")
  end
end
