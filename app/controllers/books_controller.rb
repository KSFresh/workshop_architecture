# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    books = Books::FetchByPage.call(page: params[:page]&.to_i || 1)
    render plain: BookResource.new(books).serialize
  end
end
