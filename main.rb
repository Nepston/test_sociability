require_relative "test"
require_relative "result_printer"

test = Test.new
result_printer = ResultPrinter.new

# Основной цикл программы
until test.finished?
  #Пока тест не закончился, задаем пользователю следующий вопрос
  test.next_question
end

# Выводим результаты теста
result_printer.print (test)

