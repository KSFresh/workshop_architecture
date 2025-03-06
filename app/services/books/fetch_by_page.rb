class Books::FetchByPage
  include Callable
  extend Dry::Initializer

  option :page, type: Dry::Types['strict.integer']
  option :items_per_page, type: Dry::Types['strict.integer'], default: -> { Settings.app.items_per_page }

  def call
    Book
      .includes(:language, :authors)
      .order(:id)
      .limit(items_per_page)
      .offset(offset)
  end

  private

  def offset
    items_per_page * skipped_pages
  end

  def skipped_pages
    page.positive? ? page - 1 : 0
  end
end
