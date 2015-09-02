require_relative 'requirements'

# options1 = {"fname" => "Robert", "lname" => "Yates" }
# user1 = User.new(options1)
# user1.save
# user1.fname = "John"
# user1.save
#
#
# options2 = {"question_id" => 1, "user_id" => 2, "body" => "reply from testing"}
# options3 = {"question_id" => 2, "user_id" => 3, "body" => "reply from testing 2"}
# options4 = {"question_id" => 1, "user_id" => 4, "body" => "reply from testing 3"}
#
# reply1 = Reply.new(options2)
# reply2 = Reply.new(options3)
# reply3 = Reply.new(options4)
# reply1.save
# reply2.save
# reply3.save
#
# options5 = {"title" => "this is a title", "body" => "this is a body", "author_id" => 1}
# question1 = Question.new(options5)
# question1.save

user1 = User.find_by_id(1)
puts user1

question1 = Question.find_by_id(1)
puts question1.likers.map(&:show)
# puts user1.liked_questions.map(&:show)
#
# puts Question.most_liked(1).map(&:show)
#
# puts Question.most_liked(2).map(&:show)
#
# puts User.find_by_id(1).average_karma
# puts User.find_by_id(2).average_karma
# puts User.find_by_id(3).average_karma


# results = QuestionsDatabase.instance.execute(<<-SQL)
#     SELECT
#       *
#     FROM
#       users
#   SQL
#
#   puts results
