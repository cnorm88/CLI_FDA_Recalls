class Cli

#   def initialize
#     @prompt = TTY::Prompt.new
#     welcome
#     # menu
#   end

#   def welcome
#     name = @prompt.ask("Please enter your name:")
#     puts "Welcome to the FDA recall information application #{name}!"
#   end
  
#   def menu
#     input = @prompt.enum_select("What would you like to do?", ["See All Characters", "Exit"])
#     case input
#     when "See All Characters"
#       binding.pry
#       Reports.all
#     when "Exit"
#       logout
#     end
#   end

#   def logout
#     puts "Thanks for helping our Breaking Bad Besties get Back on their Feet"
#   end
# end

  def initialize
    @prompt = TTY::Prompt.new
    start
  end

  def start
    name = @prompt.ask("Please enter your name:")
    puts "Welcome to the FDA recall information application #{name}!"
    Api.get_report
    self.menu
  end
 
def menu
    sleep(1)
    puts "\n"
    # user_input = @prompt.yes?("Would you like to see a list of recalls made by the FDA in 2020?")
    user_input = @prompt.select("Would you like to see a list of recalls by company name or would you like to 
      search for recalls by state? Enter any character to exit.", %w(List Search Exit))

    if user_input == "List"
      puts "\n" 
      puts "Here is the list of recalls"      
      list_of_recalls
    elsif user_input == "Search"
      find_by_static
    else
      sleep(1)
      puts "\n"
      puts "Thanks for using the FDA recall information app"
    end
  end

  def list_of_recalls
    Reports.all.each.with_index(1) do |report, index|
      report = report.name
      puts "#{index}. #{report}"
    end
    users_selection
  end


def users_selection
  puts "Enter the number of the report you'd like to know more about"
    index = gets.strip.to_i - 1
  # index = @prompt.ask("Provide number in range: 1-15?") { |q| q.in("1-9") }  
  # index = @prompt.ask("Provide range of numbers?", convert: :range)
  until index.between?(0, Reports.all.length - 1)
    puts "Sorry invalid input. Choose a valid number"
    index = gets.strip.to_i - 1
  end
  selection = Reports.all[index]
  recall_details(selection)
end

def recall_details(report)
  puts "\n"
  puts "What would you like to know about this #{report.state} state #{report.name} recall? Here are your options: Location, Description, Date, Quantity or Press any key to return to menus"
    choice = gets.strip.capitalize

    case choice

    when "Location"
      puts "State: #{report.state} City: #{report.city}"
        recall_details(report)
    when "Description"
      puts report.description
      puts report.recall_reason
        recall_details(report)
    when "Date"
      puts report.date
        recall_details(report)
    when "Quantity"
      puts "\n"
      puts report.quantity
        recall_details(report)
    else
      exit_or_continue
    end
  end

  def exit_or_continue
    puts "\n"
    user_input = @prompt.select("Go back to menu or Exit", %w(Menu List Exit))

    if user_input == "Menu"
      self.menu
    elsif
      user_input == "List"
      list_of_recalls
    else
      puts "Thank you"
    end
end


def find_by_static

   Reports.all.uniq.map.with_index(1) do |report|
        # binding.pry
      @report = report.state
      puts "#{@report}"
    end
     # binding.pry
    search
end

def search
  #  binding.pry

  #  user_input = @prompt.select("Which State would you like to see reports from?", %w(Select List Exit))
   user_input = @prompt.ask("Which State would you like to see reports from?")
       
# puts "what state?"
#     user_input = gets.strip

    # if user_input == @report      
    # report = Api.find_by_state(user_input)
    # recall_details(report)
    # else
    #   exit_or_continue
    # end

  until user_input == self.find_by_static
    puts "Sorry invalid input. Choose a valid state"
    user_input = @prompt.ask("Which State would you like to see reports from?")
  end
    report = Api.find_by_state(user_input)
    recall_details(report)
end

end