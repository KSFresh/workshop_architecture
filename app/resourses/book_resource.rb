# frozen_string_literal: true

class BookResource
  include Alba::Resource

  attributes :id, :title, :language, :authors

  def language(book)
    book.language.name
  end

  def authors(book)
    book.authors.map { |a| "#{a.first_name} #{a.last_name}" }
  end
end
