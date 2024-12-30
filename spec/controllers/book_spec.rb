require "rails_helper"

RSpec.describe BooksController, :type => :controller do
  let(:book) do
    Book.create(
      title: 'Book 1',
      author: 'Author',
      publication_date: DateTime.current,
      rating: 2
    )
  end
  
  let(:book2) do
    Book.create(
      title: 'Book 2',
      author: 'Author',
      publication_date: DateTime.current,
      rating: 4
    )
  end

  describe '#INDEX' do
    context 'when listing the books' do
      before do
        book
        book2
      end

      it 'returns all books sorted by rating' do
        get :index, as: :json

        aggregate_failures do
          expect(response.status).to eq(200)
          expect(json_response.count).to eq(2)
          expect(JSON.parse(response.body).first['id']).to eq(book2.id)
          expect(JSON.parse(response.body).last['id']).to eq(book.id)
        end
      end
    end
  end

  describe '#CREATE' do
    let(:create_params) do
      {
        book: {
          title: 'Book 1',
          author: 'Author',
          publication_date: DateTime.current
        }
      }
    end

    before { post :create, params: create_params }

    context 'with valid params' do
      it 'creates a new book' do
        expect(Book.count).to eq(1)
      end
    end

    context 'when missing the title' do
      let(:create_params) do
        {
          book: {
            author: 'Author',
            publication_date: DateTime.current
          }
        }
      end

      it 'fails to create a new book' do
        expect(Book.count).to eq(0)
      end
    end
  end

  describe '#UPDATE' do
    let(:update_params) do
      {
        rating: 4,
        status: 'checked_out'
      }
    end

    before do
      patch :update, id: book.id, params: { book: update_params }
    end

    context 'with valid params' do
      it 'updates the book correctly' do
        db_book = Book.last

        aggregate_failures do
          expect(db_book.rating).to eq(4)
          expect(db_book.status).to eq('checked_out')
        end
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end