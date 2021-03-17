class Cli

  def initialize
    @prompt = TTY::Prompt.new
    welcome
    # menu
  end

  def welcome
    name = @prompt.ask("Please enter your name:")
    puts "Welcome to the FDA recall information application #{name}!"
  end
  
end