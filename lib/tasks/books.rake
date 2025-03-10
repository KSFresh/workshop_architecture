namespace :books do
  desc 'Индексируем список книг для доступа через MongoDB'
  task :index, [ :path ] => [ :environment ]  do
    BooksIndex.collection.drop

    Book.includes(:authors, :language).in_batches do |books|
      book_indexes = books.map do |book|
        {
          title: book.title.strip,
          language: book.language.name,
          authors: book.authors.map { |a| [a.first_name&.strip, a.last_name&.strip].compact.join(' ') }
        }
      end

      BooksIndex.collection.insert_many(book_indexes)
    end
  end
end
