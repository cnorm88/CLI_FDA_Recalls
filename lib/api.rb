class Api

  def self.get_report
    url = "https://api.fda.gov/food/enforcement.json?search=report_date:[20200101+TO+20200520]&limit=15"
    url = URI(url)
    response = Net::HTTP.get(url)
    hash = JSON.parse(response)

    reports_array = hash["results"]

    reports_array.each do |reports_hash|
        report = Reports.new
        report.name = reports_hash["recalling_firm"]
        report.date = reports_hash["recall_initiation_date"]
        report.state = reports_hash["state"]
        report.city = reports_hash["city"]
        report.recall_reason = reports_hash["reason_for_recall"]
        report.description = reports_hash["product_description"]
        report.quantity = reports_hash["product_quantity"]
    end
  end

  def self.find_by_state(state)
    Reports.all.find{|states| states.state == state}  
  end

  def self.state_count(state)
    count = Reports.all.count{|states| states.state == state}
    puts count  
  end
end