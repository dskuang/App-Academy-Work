require 'spec_helper'
require 'rails_helper'

feature "Goal creation process" do
  feature "has a new goal page" do
    before(:each) do
      visit new_goal_url
      fill_in 'Title', :with => "Goal 1"
      fill_in 'Body', :with => "Be a baller"
      click_on "Create Goal"
    end

    let(:incomplete_title) { Goal.new(body: "bodybody") }
    it "validates presence of title" do
      expect(incomplete_title).not_to be_valid
    end

    let(:incomplete_body) { Goal.new(title: "titletitle") }
    it "validates presence of body" do
      expect(incomplete_body).not_to be_valid
    end
  end
end

feature "Goal updating" do
  let(:factory_goal) { FactoryGirl.create(:goal, title: 'Goal 1', body: 'Be a baller') }

    feature "has an edit goal page" do
      before(:each) do
        visit edit_goal_url(factory_goal.id)
        save_and_open_page

        fill_in 'Title', :with => "Goal 1"
        fill_in 'Body', :with => "Be a baller"
        click_on "Edit Goal"
      end

    feature "redirects to goal show page" do
      before(:each) do
        visit edit_goal_url(factory_goal.id)
        fill_in 'Title', :with => "Goal 1"
        fill_in 'Body', :with => "Be a baller"
        click_on "Edit Goal"
        expect(page).to have_content "Goal 1"
        expect(page).to have_content "Be a baller"
      end

    end

    let(:incomplete_title) { Goal.new(body: "bodybody") }
    it "validates presence of title" do
      expect(FactoryGirl.build(:goal, title: '')).not_to be_valid
    end

    let(:incomplete_body) { Goal.new(title: "titletitle") }
    it "validates presence of body" do
      expect(FactoryGirl.build(:goal, body: '')).not_to be_valid
    end
  end

end
