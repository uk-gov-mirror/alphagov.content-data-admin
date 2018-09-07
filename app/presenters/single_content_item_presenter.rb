class SingleContentItemPresenter
  attr_reader :unique_pageviews, :pageviews, :unique_pageviews_series,
    :pageviews_series, :base_path

  def self.parse_metrics(metrics)
    new.parse_metrics(metrics.deep_symbolize_keys)
  end

  def parse_metrics(metrics)
    @unique_pageviews = metrics[:unique_pageviews]
    @pageviews = metrics[:pageviews]
    @base_path = metrics[:base_path]
    self
  end

  def parse_time_series(time_series)
    @unique_pageviews_series = ChartPresenter.new(json: time_series, metric: :unique_pageviews)
    @pageviews_series = ChartPresenter.new(json: time_series, metric: :pageviews)
    self
  end
end
