require_relative '../transfer_manager.rb'

@file_name_time_array = [["photo2.JPG", Time.new(1986, 03, 07, 18, 15)]]

@transfer = Transfer.new

describe Transfer do
  it 'makes a file name' do

  end
end

# expect(Transfer.make_folder_name_day(@file_name_time_array[0[1]])).to eq "2016-12-04"

# require 'journey'
# require 'oystercard'
# require 'station'
#
# describe Journey do
#   subject(:journey) {described_class.new}
#   let(:station) {double :station}
#   let(:card) {double :card, history: []}
#
#
#   before (:each) do
#     allow(card).to receive(:balance){10}
#     allow(card).to receive(:balance=){10}
#   end
#
#
#     # station = Station.new
#     # card = Oystercard.new
#     # card.top_up(10)
#
#   context 'starting and finishing' do
#
#     it 'responds to in_journey' do
#       expect(journey.in_journey?).to eq(true).or eq(false)
#     end
#
#   end
