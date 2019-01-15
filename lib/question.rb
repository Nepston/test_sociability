class Question
  attr_reader :text, :logic

  def initialize(text_value, logic_value)
    @text = text_value
    @logic = logic_value
  end
end
