RSpec.describe PaginationPresenter do
  subject do
    PaginationPresenter.new(
      page: page,
      total_pages: 123457,
      per_page: 10,
      total_results: 1234567
    )
  end

  let(:page) { 1 }

  it 'returns the #total_results' do
    expect(subject.total_results)
  end

  it 'returns the #formatted_total_results' do
    expect(subject.formatted_total_results).to eq('1,234,567')
  end

  context 'when on the first page' do
    it 'returns false from #prev_link?' do
      expect(subject.prev_link?).to eq(false)
    end

    it 'returns true from #next_link?' do
      expect(subject.next_link?).to eq(true)
    end

    it 'return the correct next page label' do
      expect(subject.next_label).to eq('2 of 123457')
    end

    it 'returns 1 for #first_record' do
      expect(subject.first_record).to eq(1)
    end

    it 'returns 10 for #last_record' do
      expect(subject.last_record).to eq(10)
    end
  end

  context 'when on the last page' do
    let(:page) { 123457 }

    it 'returns true from #prev_link?' do
      expect(subject.prev_link?).to eq(true)
    end

    it 'returns false from #next_link?' do
      expect(subject.next_link?).to eq(false)
    end

    it 'returns the correct next page label' do
      expect(subject.prev_label).to eq('123456 of 123457')
    end

    it 'returns 100 for #first_record' do
      expect(subject.first_record).to eq(1234561)
    end

    it 'returns 105 for #last_record' do
      expect(subject.last_record).to eq(1234567)
    end
  end

  context 'when somewhere in the middle' do
    let(:page) { 6 }

    it 'returns true from #prev_link?' do
      expect(subject.prev_link?).to eq(true)
    end

    it 'returns true from #prev_link?' do
      expect(subject.prev_link?).to eq(true)
    end

    it 'returns the correct next page label' do
      expect(subject.prev_label).to eq('5 of 123457')
    end

    it 'return the correct next page label' do
      expect(subject.next_label).to eq('7 of 123457')
    end

    it 'returns 51 for #first_record' do
      expect(subject.first_record).to eq(51)
    end

    it 'returns 60 for #last_record' do
      expect(subject.last_record).to eq(60)
    end
  end
end
