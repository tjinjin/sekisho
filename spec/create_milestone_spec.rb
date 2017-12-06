require 'spec_helper'

describe 'next day of week' do
  let(:cm) { Sekisho::Milestone.new }

  context 'Base week: Thu' do
    it 'Mon' do
      expect(cm.get_next_week(Date.new(2017, 12, 4), 4)).to eq(Date.new(2017, 12, 7))
    end

    it 'Tue' do
      expect(cm.get_next_week(Date.new(2017, 12, 5), 4)).to eq(Date.new(2017, 12, 7))
    end

    it 'Wed' do
      expect(cm.get_next_week(Date.new(2017, 12, 6), 4)).to eq(Date.new(2017, 12, 7))
    end

    it 'Thu' do
      expect(cm.get_next_week(Date.new(2017, 12, 7), 4)).to eq(Date.new(2017, 12, 7))
    end

    it 'Fri' do
      expect(cm.get_next_week(Date.new(2017, 12, 8), 4)).to eq(Date.new(2017, 12, 14))
    end

    it 'Sat' do
      expect(cm.get_next_week(Date.new(2017, 12, 9), 4)).to eq(Date.new(2017, 12, 14))
    end

    it 'Sun' do
      expect(cm.get_next_week(Date.new(2017, 12, 10), 4)).to eq(Date.new(2017, 12, 14))
    end
  end

  context 'Base week: Sun' do
    it '12/10 Sun -> 12/10' do
      expect(cm.get_next_week(Date.new(2017, 12, 10), 0)).to eq(Date.new(2017, 12, 10))
    end

    it '12/4 Mon -> 12/10' do
      expect(cm.get_next_week(Date.new(2017, 12, 4), 0)).to eq(Date.new(2017, 12, 10))
    end

    it '12/11 Mon -> 12/17' do
      expect(cm.get_next_week(Date.new(2017, 12, 11), 0)).to eq(Date.new(2017, 12, 17))
    end
  end
end
