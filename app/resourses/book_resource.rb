# frozen_string_literal: true

class BookResource
  include Alba::Resource

  attributes :id, :title, :language, :authors
end
