require 'spec_helper'
require 'rails_helper'
require 'goal'

feature "Comment creation process" do
  feature "has a new comment page" do
    let(:factory_goal) { FactoryGirl.create(:goal, title: 'Goal 1', body: 'Be a baller') }
    # let(:complete_body) { Comment.new(body: 'commentboddy', commentable_id: new_goal.id, commentable_type: 'Goal') }
    before(:each) do
      visit "/goals/#{factory_goal.id}"
      fill_in 'Body', :with => "commentcommentcomment"
      click_on "Create Comment"
    end

    let(:incomplete_body) { Comment.new(commentable_type: 'user', commentable_id: 1) }
    it "validates presence of body" do
      expect(incomplete_body).not_to be_valid
    end

    let(:incomplete_commentable_type) { Comment.new(body: 'bodybodybody', commentable_id: 1) }
    it "validates presence of commentable_type" do
      expect(incomplete_commentable_type).not_to be_valid
    end

    let(:incomplete_commentable_id) { Comment.new(body: 'bodybodybody', commentable_type: 'user') }
    it "validates presence of body" do
      expect(incomplete_commentable_id).not_to be_valid
    end
  end
end

feature "Comment updating" do
  let(:factory_comment) { FactoryGirl.create(:comment, body: 'bodybodybody', commentable_type: 'user', commentable_id: 1) }

    feature "has an edit comment page" do
      before(:each) do
        visit edit_comment_url(factory_comment.id)
        # save_and_open_page

        fill_in 'Body', :with => "bodybodybodybodybodybodybody"
        click_on "Edit Comment"
      end

    feature "redirects to page it belongs to" do
      before(:each) do
        visit '/#{factory_comment.commentable_type}/#{factory_comment.commentable_id}'
        click_on "Edit Comment"
        fill_in 'Body', :with => "Be a baller"
        click_on "Edit Comment"

        # expect(page).to have_content "Goal 1"
        expect(page).to have_content "Be a baller"
      end

    end

    it "validates presence of body" do
      expect(FactoryGirl.build(:comment, body: '')).not_to be_valid
    end
  end



end
