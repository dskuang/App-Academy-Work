require_relative 'requirements'

class QuestionFollows
  attr_accessor :question_id, :user_id

  def initialize(options = {})
    @question_id = options["question_id"]
    @user_id = options["user_id"]
  end

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        fname,
        lname,
        id
      FROM
        question_follows
      JOIN
        user
      ON
        user.id = question_follows.user_id
      WHERE
        question_id = ?
    SQL
    results.map{ |result| User.new(result)}
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        id,
        title,
        body,
        author_id
      FROM
        question_follows
      JOIN
        question
      ON
        question.id = question_follows.question_id
      WHERE
        question_follows.user_id = ?
    SQL
    results.map { |result| Question.new(result) }
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      question.id,
      question.title,
      question.body,
      question.author_id
    FROM
      question
    JOIN
      question_follows
    ON
      question.id = question_follows.question_id
    GROUP BY
      question_id
    ORDER BY
      COUNT(*) DESC
    LIMIT
      ?
    SQL
    results.map { |result| Question.new(result) }
  end
end
