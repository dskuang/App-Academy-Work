require_relative 'requirements'

class User < DatabaseObject
  attr_accessor :id, :fname, :lname, :rel_table

  def initialize(options = {})
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
    @rel_table = "users"
  end

  def self.find_by_id(id)
    super(id, "users", User)
  end


  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? and lname = ?
    SQL
    User.new(results)
  end

  def authored_questions
    Question.find_by_user_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLikes.liked_questions_for_user_id(@id)
  end

  def average_karma
    num_questions = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        COUNT(*)
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    num_likes = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(*) AS FLOAT)
      FROM
        questions
      JOIN
        question_likes
      ON
        questions.id = question_likes.question_id
      WHERE
        questions.author_id = ?

    SQL
    num_likes.first.values.first / num_questions.first.values.first
  end

  def show
    "#{@id} fname: #{@fname} lname: #{@lname}"
  end

end
