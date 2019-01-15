class ResultPrinter
  def initialize(results_path)
    # Ответы
    @results = self.load_answers(results_path)
  end

  def load_answers(file_path)
    file = File.new(file_path, 'r:UTF-8')
    answers = file.readlines
    file.close

    answers.map! do |line|
      {
          :text => /(["])(.+?)\1/.match(line)[2],
          :min => /([\[])(.+?)([\]])/.match(line)[2].split('-')[0],
          :max => /([\[])(.+?)([\]])/.match(line)[2].split('-')[1]
      }
    end
  end

  def print (test)
    puts
    puts "Результаты теста:"
    puts
    puts "Cуммарный балл: #{test.user_score}"

    @results.each do |i|
      puts i[:text] if test.user_score.between?(i[:min].to_i,i[:max].to_i)
    end
  end
end
