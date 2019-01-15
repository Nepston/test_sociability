class Test
  attr_reader :user_score

  POSITIVE_POINT = 2
  NEUTRAL_POINT = 1
  #NEGATIVE_RESPONSE_POINT = 0

  def initialize(questions_path)
    #храним текст вопроса и логику ответа
    #"false" - ответ юзера "Да" считаем отрицальным для степени коммуникабельности
    #"true" - ответ юзера "Да" считаем положительным для степени коммуникабельности
    @questions = self.load_questions(questions_path)

    @user_score = 0 #суммарный балл за тест
    @current_question = 0 #номер текущего вопроса теста
  end

  def load_questions(file_path)
    file = File.new(file_path, 'r:UTF-8')
    questions = file.readlines
    file.close

    questions.map! do |line|
      {:text => /(["])(.+?)\1/.match(line)[2], :logic => /([\(])(.+?)([\)])/.match(line)[2]}
    end
  end

  def positive_point
    POSITIVE_POINT
  end

  def neutral_point
    NEUTRAL_POINT
  end

  def next_question
    # Выводим на экран текущий вопрос
    puts
    puts "#{@current_question+1}. #{@questions[@current_question][:text]}"

    user_answer = -1
    until user_answer.between?(0,2)
      puts
      puts "Введите:\n"
      puts "\t'0' - если нет"
      puts "\t'1' - если да"
      puts "\t'2' - если иногда"
      puts
      print "Ваш ответ: "
      user_answer = STDIN.gets.to_i
    end

    #если логика ответа помечена как "true", то ответ "НЕТ", способствует увеличению итогового балла на 2
    #также как и ответ "Да" на вопрос с пометкой "false"
    #нейтральный ответ дает 1 балл
    if @questions[@current_question][:logic] && user_answer == 0
      @user_score += self.positive_point
    elsif !@questions[@current_question][:logic]  && user_answer == 1
      @user_score += self.positive_point
    elsif user_answer == 2
      @user_score += self.neutral_point
    end

    @current_question +=1
  end

  def finished?
    @current_question >= @questions.size
  end
end
