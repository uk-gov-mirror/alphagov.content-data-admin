class FindContent
  include MetricsCommon
  def self.call(params)
    new(params).call
  end

  def initialize(params)
    range = DateRange.new(params[:date_range])
    @from = range.from
    @to = range.to
    @organisation = params[:organisation]
  end

  def call
    api.content(from: @from, to: @to, organisation: @organisation)
  end
end
