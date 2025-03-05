RSpec.describe 'Books index', type: :request do
  let(:language) { create(:language) }
  let(:folder) { create(:folder) }
  let!(:books) { create_list(:book, Settings.app.items_per_page + 1, language: language, folder: folder) }

  it 'returns books in batch' do
    get '/books/1'
    expect(JSON.parse(response.body)).to be_an(Array)
    expect(JSON.parse(response.body).size).to eq(Settings.app.items_per_page)
  end

  it 'returns books correctly serialized books' do
    get '/books/1'
    expect(JSON.parse(response.body)[0].keys).to contain_exactly('id', 'authors', 'language', 'title')
  end

  it 'navigates through pages correctly' do
    get '/books/2'
    expect(JSON.parse(response.body)).to be_an(Array)
    expect(JSON.parse(response.body).size).to eq(1)
  end

  context 'when page param surpassing the number of books passed' do
    it 'returns empty list' do
      get '/books/3'
      expect(JSON.parse(response.body)).to be_an(Array)
      expect(JSON.parse(response.body).size).to eq(0)
    end
  end

  context 'when incorrect page param passed' do
    it 'returns books in batch as for the first page' do
      get '/books/qwerty'
      expect(JSON.parse(response.body)).to be_an(Array)
      expect(JSON.parse(response.body).size).to eq(Settings.app.items_per_page)
    end
  end
end
