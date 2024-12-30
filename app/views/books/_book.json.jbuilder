json.extract! book, :id, :title, :author, :publication_date, :rating, :status, :created_at, :updated_at
json.url book_url(book, format: :json)
