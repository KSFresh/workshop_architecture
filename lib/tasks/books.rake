namespace :books do
  desc 'Индексируем список книг для доступа через MongoDB'
  task :index, [ :path ] => [ :environment ]  do
    BooksIndex.collection.drop
    i = 0

    Book.includes(:authors, :language).in_batches do |books|
      puts i
      i += 1
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
