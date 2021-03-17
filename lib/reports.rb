class Reports

  attr_accessor :name, :date, :state, :city, :recall_reason, :description, :quantity

  @@all = []

  def initialize(reports_hash)
    @name = reports_hash["recalling_firm"]
    @date = reports_hash["recall_initiation_date"]
    @state = reports_hash["state"]
    @city = reports_hash["city"]
    @recall_reason = reports_hash["reason_for_recall"]
    @description = reports_hash["product_description"]
    @quantity = reports_hash["product_quantity"]
    @@all << self
  end

end