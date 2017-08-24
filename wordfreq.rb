require 'pry'
class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'she', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    @doc = File.read(filename).downcase.gsub(/\W/, ' ').split(" ").reject{ |e| STOP_WORDS.include? e}
    @j = Hash.new
    @doc.uniq.each do |x|
      @j["#{x}"] = @doc.count(x)
    end
  end

  def frequency(word)
    @j[word]
  end

  def frequencies
    #binding.pry

  end

  def top_words(number)
    ten = @j.sort{|a, b| b[1]<=>a[1]}
    eleven = ten.sort_by do |key, value|
      value
    end
    ten.take(number)
  end

  def print_report
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
