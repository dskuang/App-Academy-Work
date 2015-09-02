class Question < ActiveRecord::Base
  validates :body, :poll_id, presence: true

  has_many(
  :answer_choices,
  class_name: :AnswerChoice,
  foreign_key: :question_id,
  primary_key: :id

  )

  belongs_to(
    :poll,
    class_name: :Poll,
    foreign_key: :poll_id,
    primary_key: :id,

    dependent: :destroy
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    self.answer_choices
      .select('answer_choices.body')
      .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
      .group('answer_choices.body')
      .count

    # answers = self.responses.includes(:answer_choice)
    # output_hash = Hash.new{ 0.count }
    #
    # answers.each do |answer|
    #   output_hash[answer.answer_choice] += 1
    # end
    #
    # output_hash
  end
end
