require './parser'

RSpec.describe Parser, 'class' do

  # context 'CLI' do
  #   it 'should fail without filename' do
  #     expect(`ruby parser.rb`).to eq("parser: missing filename\n")
  #   end
  # end

  context 'executing parser' do
    it 'should raise an exception for missing filename' do
      expect{Parser.new.execute()}.to raise_error(Exception, 'parser: missing filename')
    end

    it 'should raise an exception for missing file' do
      expect{Parser.new.execute('foo.log')}.to raise_error(Exception, 'parser: file not found')
    end

    it 'should output results for file' do
      File.open('test.log', 'w') do |f|
        f.puts '/home 0.0.0.1'
        f.puts '/home 0.0.0.1'
        f.puts '/home 0.0.0.1'
        f.puts '/home 0.0.0.4'
        f.puts '/contact 0.0.0.1'
        f.puts '/contact 0.0.0.4'
        f.puts '/contact 0.0.0.7'
      end

      expect(Parser.new.execute('test.log')).to
    end
  end

end