require 'pry'
class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    @doc = File.read(filename).downcase.gsub(/\W/, ' ').split(" ").reject{ |e| STOP_WORDS.include? e}
    @j = Hash.new
    @doc.uniq.each do |x|
      @j["#{x}"] = @doc.count(x)
    end
  end

  def frequency(word)
    if @j[word] == nil
      0
    else
      @j[word]
    end
  end

  def frequencies
    @j
  end

  def top_words(number)
    @j.sort { |a, b| [b[1], a[0]] <=> [a[1], b[0]] }[0..(number - 1)]
  end

  def print_report
    top_words(10).each do |x, y|
      puts "#{x} |".rjust(9) + " #{y} ".ljust(4) + "*" * @doc.count(x)
    end
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
