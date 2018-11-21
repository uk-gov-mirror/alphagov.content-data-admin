class ContentItemsPresenter
  include Kaminari::Helpers::HelperMethods
  attr_reader :title, :content_items, :pagination
  delegate :page, :total_pages, :prev_link?, :next_link?, to: :pagination

  def initialize(search_results, search_parameters, document_types, organisations)
    @title = 'Content Items'
    @search_parameters = search_parameters
    @document_types = document_types
    @organisations = organisations
    @pagination = PaginationPresenter.new(
      page: search_results[:page] || 1,
      total_pages: search_results[:total_pages],
      total_results: search_results[:total_results]
    )
    @content_items = pagination.paginate(search_results[:results].map { |item| ContentRowPresenter.new(item) })
  end

  def time_period
    @search_parameters[:date_range]
  end

  def document_type_options
    types = [{
      text: 'All document types',
      value: '',
      selected: @search_parameters[:document_type] == ''
    }]
    @document_types.each do |document_type|
      types.push(
        text: document_type.try(:tr, '_', ' ').try(:capitalize),
        value: document_type,
        selected: document_type == @search_parameters[:document_type]
      )
    end
    types
  end

  def organisation_options
    @organisations.map do |org|
      {
        text: org[:title],
        value: org[:organisation_id],
        selected: org[:organisation_id] == @search_parameters[:organisation_id]
      }
    end
  end

private

  def paginate(items)
    Kaminari.paginate_array(items, total_count: @total_results)
      .page(@page).per(100)
  end
end
