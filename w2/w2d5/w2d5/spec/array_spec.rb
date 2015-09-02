require 'rspec'
require 'array'


describe "Array#uniq" do

  it 'returns only unique elements' do
    expect( [1, 2, 3, 3].uniq ).to match_array([1, 2, 3])
  end

  it 'returns unique elements in order of appearance' do
    expect( [2, 3, 3, 5, 5].uniq ).to match_array([2, 3, 5])
  end

end

describe "Array#two_sum" do

  it 'returns all pairs in an array' do
    expect( [2, -3, 3, -2].two_sum ).to match_array([[0, 3], [1, 2]])
  end

  it 'returns pairs' do
    expect( [2, -3, 3, -2].two_sum ).to match_array([[0, 3], [1, 2]])
  end

  it 'returns pairs with smaller index first' do
    expect( [2, -3, 3, -2].two_sum ).to match_array([[0, 3], [1, 2]])
  end

  it 'returns an empty array if there are no pairs' do
    expect( [2, 3, 4, 5,].two_sum ).to match_array([])
  end

end

describe "Array#median" do

  it 'return middle item of odd length array' do
    expect( [1, 2, 3].median ).to eq(2)
  end

  it 'returns the average of middle two items of even length array' do
    expect( [2, 3, 3, 5, 5, 6].median ).to eq(4)
  end

  it 'returns nil if array is empty' do
    expect( [].median ).to eq(nil)
  end

end

describe "Array#my_transpose" do

  it 'switches rows and columns' do
    expect( [ [0, 1, 2], [3, 4, 5], [6, 7, 8]].my_transpose ).to match_array([
      [0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end

  it 'returns nil if array is empty' do
    expect( [].my_transpose ).to eq([])
  end

end

describe "Array#stock_picker" do

  it 'makes sure stock is bought before sold' do
      expect([0, 1, 2, -1].stock_picker).to_not eq ([3, 2])
  end

  it 'outputs a profitable pair of days' do
    expect([0, 1, 2, 3].stock_picker).to eq ([0, 3])
  end

  it 'returns and empty array if array is empty' do
    expect( [].stock_picker ).to eq([])
  end

  it 'returns and empty array if prices are always decreasing' do
    expect( [5, 4, 3, 2].stock_picker ).to eq([])
  end

end
