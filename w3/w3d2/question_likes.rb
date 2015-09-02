require_relative 'requirements'

class QuestionLikes
  attr_accessor :question_id, :user_id

  def initialize(options = {})
    @question_id = options["question_id"]
    @user_id = options["user_id"]
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id,
        users.fname,
        users.lname
      FROM
        question_likes
      JOIN
        users
      ON
        users.id = question_likes.user_id
      WHERE
        question_id = ?
    SQL
    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL
    result.first
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id,
        questions.author_id,
        questions.title,
        questions.body
      FROM
        question_likes
      JOIN
        questions
      WHERE
        user_id = ?
    SQL
    results.map { |result| Question.new(result) }
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.id,
      questions.title,
      questions.body,
      questions.author_id
    FROM
      questions
    JOIN
      question_likes
    ON
      questions.id = question_likes.question_id
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
