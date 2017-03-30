require './log_parser.rb'

RSpec.describe LogParser, 'class' do

  it 'should return an empty array for no input' do
    log_parser = LogParser.new
    expect(log_parser.get_entries).to be_an Array
  end

  before(:example) do
    @sample = '''
      /pages 1
      /pages/2 2
      /pages 3
    '''
    @log_parser = LogParser.new
  end

  context 'testing parsing' do
    it 'should return an array of split entries' do
      @log_parser.parse(@sample)
      expect(@log_parser.get_entries).to eq([
        ['/pages', '1'],
        ['/pages/2', '2'],
        ['/pages', '3']
      ])
    end

    it 'should return a hash of pages with an array of ip addresses' do
      @log_parser.parse(@sample)
      expect(@log_parser.get_entries_by_page).to eq({
        '/pages' => ['1', '3'],
        '/pages/2' => ['2']
      })
    end
  end

  context 'testing hits per page' do
    it 'should return a hash of view counts grouped by page' do
      @log_parser.parse(@sample)
      expect(@log_parser.views_by_page).to eq({
        '/pages' => 2,
        '/pages/2' => 1
      })
    end

    it 'should return an empty hash for no entries' do
      @log_parser.parse('')
      expect(@log_parser.views_by_page).to eq({})
    end
  end

  context 'testing unique hits per page' do

    it 'should return a hash of unique views per page' do
      sample = '''
        /pages 1
        /pages 1
        /pages/2 2
        /pages/2 2
        /pages/2 4
        /pages/2 5
        /pages 3
      '''
      @log_parser.parse(sample)
      expect(@log_parser.unique_views_per_page).to eq({
        '/pages/2' => 3,
        '/pages' => 2
      })
    end
  end

end


# a = {
#   one: [1,3],
#   two: [2]
# }