require 'rails_helper'

describe 'Stocks pagination', type: :feature do

  let(:user) { create(:user) }
  before :all do
    Stock.paginates_per(3)
  end

  before :each do
    create_list(:stock, 8, user_id: user.id)
    login_as user
  end

  it 'displays 3 stocks per page' do
    visit root_path
    expect(page).to have_selector('a.stock', count: 3)
  end

  it '2-nd page displays next 3 pages' do
    expected_stocks = user.stocks[3...6]
    visit root_path
    click_on '2'

    expected_stocks.each do |stock|
      expect(page).to have_content(stock.name)
    end
  end

  context 'displays pagination links' do
    it 'has link to the next page' do
      visit root_path
      expect(page).to have_link('Next')
    end

    it 'has link to the last page' do
      visit root_path
      expect(page).to have_link('Last')
    end

    it 'has links with page numbers' do
      visit root_path
      expect(page).to have_selector('a.page-link', text: '1')
      expect(page).to have_link('2')
    end
  end
end