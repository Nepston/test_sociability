class Test
  attr_reader :user_score, :points

  def initialize(questions_path)
    @questions = self.load_questions(questions_path)
    @user_score = 0
    @current_question = 0

    @points = Hash.new { :positive => 2, :neutral => 1 }
  end

  def load_questions(file_path)
    file = File.new(file_path, 'r:UTF-8')
    questions = file.readlines
    file.close

    #храним текст вопроса и логику ответа
    #"false" - ответ юзера "Да" считаем отрицальным для степени коммуникабельности
    #"true" - ответ юзера "Да" считаем положительным для степени коммуникабельности
    questions.map! do |line|
      text = /(["])(.+?)\1/.match(line)[2]
      logic = /([\(])(.+?)([\)])/.match(line)[2]
      Question.new(text, logic)
    end
  end

  def next_question
    ask_question(@current_question, @questions[@current_question])
    @current_question +=1
  end

  def finished?
    @current_question >= @questions.size
  end

  def get_user_answer
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
  end

  def ask_question(number, question)
    # Выводим на экран текущий вопрос
    puts
    puts "#{number+1}. #{question.text}"

    user_answer = self.get_user_answer
    #если логика ответа помечена как "true", то ответ "НЕТ", способствует увеличению итогового балла на 2
    #также как и ответ "Да" на вопрос с пометкой "false"
    #нейтральный ответ дает 1 балл
    if question.logic && user_answer == 0
      @user_score += @points[:positive]
    elsif !question.logic  && user_answer == 1
      @user_score += @points[:positive]
    elsif user_answer == 2
      @user_score += @points[:neutral]
    end
  end
end
