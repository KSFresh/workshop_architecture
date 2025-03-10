class BooksIndex
  include Mongoid::Document

  field :title, type: String
  field :language, type: String
  field :authors, type: Array
end
