# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

jj = User.create(username: "JohnJones")
superman = User.create(username: "Superman")
greenlantern = User.create(username: "GreenLantern")

gay_poll = Poll.create(title: "Gay Rights", author_id: superman.id)
martian_poll = Poll.create(title: "Martian Politics", author_id: jj.id)

gay_question = Question.create(body: "You gay bro?", poll_id: gay_poll.id)
green_question = Question.create(body: "Why so green?", poll_id: martian_poll.id)

gay_a_choice = AnswerChoice.create(body: "As gay as ruler", question_id: gay_question.id)
gay_b_choice = AnswerChoice.create(body: "You tell me ;),", question_id: gay_question.id)

response_1 = Response.create(user_id: jj.id, answer_choice_id: gay_b_choice.id)
response_2 = Response.create(user_id: superman.id, answer_choice_id: gay_b_choice.id)
response_3 = Response.create(user_id: greenlantern.id, answer_choice_id: gay_a_choice.id)
