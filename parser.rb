require './log_parser.rb'

class Parser

  def initialize
    @log_parser = LogParser.new
  end

  def execute(filename = '', option)
    raise Exception.new('parser: missing filename') if filename.empty?
    @log_parser.parse(read_file(filename))
    case option
      when 'unique'
        display_unique_views
      when 'count'
        display_view_count
      else
        display_view_count
        display_unique_views
    end
  end

  def read_file(filename)
    raise Exception.new('parser: file not found') unless File.file?(filename)
    File.open(filename).read
  end

  def display_view_count
    display(@log_parser.views_by_page, 'visits')
  end

  def display_unique_views
    display(@log_parser.unique_views_per_page, 'unique views')
  end

  def display(data, label)
    data.each{|k, v| puts "#{k} #{v} #{label}"}
  end

end

# CLI
if __FILE__ == $0
  begin
    Parser.new.execute(ARGV[0], ARGV[1])
    exit(0)
  rescue Exception => e
    STDERR.puts e.message
    exit(1)
  end
end
