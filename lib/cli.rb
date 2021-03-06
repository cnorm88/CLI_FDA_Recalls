class Cli

  def initialize
    @prompt = TTY::Prompt.new
    start
  end

  def start
    name = @prompt.ask("Please type your name and press Enter:", echo: false)
    puts "Welcome to the FDA recall information application #{name}!"
    Api.get_report
    self.menu
  end
 
 def menu
    sleep(2)
    puts "\n"
    user_input = @prompt.select("Select whether you would like to see a List of recalls by brand, Search recalls by state or recieve a Count of recalls in your state.", %w(List Search Count Exit))

    if user_input == "List"
      puts "\n" 
      puts "Here is the list of recalls"      
      list_of_recalls
    elsif user_input == "Search"
      search
    elsif user_input == "Count"
      state_count
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

  def search
   user_input = @prompt.select("Which State would you like to see reports from?", Reports.all.map{|state| state.state})
   report = Api.find_by_state(user_input)
   recall_details(report)
  end

  def state_count
   user_input = @prompt.select("Select a state to see how many reports were filed there:", Reports.all.map{|state| state.state})
   Api.state_count(user_input)
   exit_or_continue
  end

end