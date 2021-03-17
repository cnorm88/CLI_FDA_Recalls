class Api
 
attr_reader :response

  def initialize
    @response = HTTParty.get("https://api.fda.gov/food/enforcement.json?search=report_date:[20200101+TO+20200520]&limit=15")
  end

end