require_relative 'requirements'

class Question < DatabaseObject
  attr_accessor :id, :title, :body, :author_id, :rel_table

  def initialize(options = {})
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @author_id = options["author_id"]
    @rel_table = "questions"
  end

  def self.find_by_id(id)
    super(id, "questions", Question)
  end

  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL
    results.map { |result| Question.new(result) }
  end

  def author
    @author_id
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLikes.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLikes.num_likes_for_question_id(@id)
  end

  def self.most_liked(n)
    QuestionLikes.most_liked_questions(n)
  end

  def show
    "#{@title}, #{@body}, author: #{author_id}, id: #{@id}"
  end

end
