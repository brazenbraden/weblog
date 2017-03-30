class LogParser

  def initialize
    @entries = []
  end

  def parse(chunk)
    @entries = chunk
      .split("\n") # get each line as an entry
      .collect{|i| i.strip.split(' ')} # seperate the page from ip address
      .select{|i| i.length == 2} # select only valid entries

    # group ips by page
    @entries_by_page = Hash.new{ |hash, key| hash[key] = []}
    @entries.each do |page, ip|
      @entries_by_page.store(page, @entries_by_page[page] << ip)
    end
  end

  def get_entries
    @entries
  end

  def get_entries_by_page
    @entries_by_page
  end

  def views_by_page
    sort(@entries_by_page.map{ |k, v| [k, v.count] }.to_h)
  end

  def unique_views_per_page
    sort(@entries_by_page.map{ |k, v| [k, v.uniq.count] }.to_h)
  end

  def sort(results)
    results.sort_by{ |k, v| v }.reverse.to_h
  end

end
