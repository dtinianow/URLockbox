class LinkParser
  attr_reader :parsed_input, :url, :command, :recipient

  def initialize(input)
    @parsed_input = parse(input)
    @url          = parsed_input[0]
    @command      = parsed_input[1]
    @recipient    = parsed_input[2]
  end

  def parse(input)
    input.split(' ')
  end

  def should_be_emailed?
    command == '\:cc'
  end
end
