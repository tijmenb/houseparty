class Runner
  INCOMING_NAME = 'Incoming Houses'

  def run
    puts "Starting..."
    initialize_trello
    PostableListings.new.listings.each do |listing|
      CardCreator.new(listing, list_for_incoming).create
    end
    puts "Finished"
  end

private

  def initialize_trello
    Trello.configure do |config|
      config.developer_public_key = Configs.fetch('TRELLO_API_KEY')
      config.member_token = Configs.fetch('TRELLO_MEMBER_TOKEN')
    end
  end

  def create_incoming_list
    puts "Creating '#{INCOMING_NAME}' list"
    Trello::List.create(name: INCOMING_NAME, board_id: board.id)
  end

  def list_for_incoming
    @list_for_incoming ||= find_list || create_incoming_list
  end

  def find_list
    board.lists.find { |list| list.name == INCOMING_NAME }
  end

  def board
    @board ||= Trello::Board.find(Configs.fetch('TRELLO_BOARD_ID'))
  end
end
