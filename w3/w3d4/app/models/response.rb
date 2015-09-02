class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :cant_respond_more_than_once_to_same_question

  belongs_to(
  :respondent,
  class_name: :User,
  foreign_key: :user_id,
  primary_key: :id,

  dependent: :destroy
  )

  belongs_to(
    :answer_choice,
    class_name: :AnswerChoice,
    foreign_key: :answer_choice_id,
    primary_key: :id,

    dependent: :destroy
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )



  def sibling_responses
    self_id = self.id
    self.question.responses.where.not(id: self_id)
  end

  def cant_respond_more_than_once_to_same_question
    if self.sibling_responses.find_by_user_id(user_id)
      errors[:respondent] << "Can't respond more than once to same question"
    end
  end

  def author_cant_answer_own_question
    author_id = self.question.poll.user.id
    
    if author_id == respondent.id
      errors[:respondent] << "Author can't respond to own question"
    end
  end
end
