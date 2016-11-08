class LinkParser
  attr_reader :parsed_input

  def initialize(input)
    @parsed_input = input.split(' ')
  end

  def url
    parsed_input[0]
  end

  def command
    parsed_input[1]
  end

  def recipient
    parsed_input[2]
  end

  def should_be_emailed?
    command == '\:cc'
  end
end
