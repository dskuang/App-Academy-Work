require_relative 'requirements'


class Reply < DatabaseObject
  attr_accessor :id, :question_id, :parent_id, :user_id, :body, :rel_table

  def initialize(options = {})
    @id = options["id"]
    @question_id = options["question_id"]
    @parent_id = options["parent_id"]
    @user_id = options["user_id"]
    @body = options["body"]
    @rel_table = "replies"
  end

  def self.find_by_id(id)
    super(id, "replies", Reply)
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    results.map {|result| Reply.new(result)}
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    results.map {|result| Reply.new(result)}
  end

  def author
    @user_id
  end

  def question
    @question_id
  end

  def parent_reply
    @parent_id
  end

  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    results.map { |result| Reply.new(result) }
  end

end
