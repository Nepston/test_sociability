class ResultPrinter
  def initialize(results_path)
    # Ответы
    file = File.new(results_path, 'r:UTF-8')
    @results = file.readlines
    @results.map! do |line|
      { :text => /(["])(.+?)\1/.match(line)[2],
        :min => /([\[])(.+?)([\]])/.match(line)[2].split('-')[0].to_i,
        :max => /([\[])(.+?)([\]])/.match(line)[2].split('-')[1].to_i
      }
    end
    file.close
  end

  def print (test)
    puts
    puts "Результаты теста:"
    puts
    puts "Cуммарный балл: #{test.user_score}"

    @results.each do |i|
      puts i[:text] if test.user_score.between?(i[:min],i[:max])
    end
  end
end
