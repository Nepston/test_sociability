require_relative "lib/test"
require_relative "lib/result_printer"

test = Test.new('./data/questions.txt')
result_printer = ResultPrinter.new('./data/results.txt')

# Основной цикл программы
until test.finished?
  #Пока тест не закончился, задаем пользователю следующий вопрос
  test.next_question
end

# Выводим результаты теста
result_printer.print(test)
