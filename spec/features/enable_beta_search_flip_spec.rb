require "rails_helper"

feature "Enable beta search flip", js: true do
  scenario "enable beta search flip" do
    When "user visits the app" do
      # TODO: change to root_path and a sign up flow from home page
      visit user_session_path
    end

    Then "see invite page" do
      # TODO: an actual invite page, not just a page with no nav-links
      wait_for do
        page.find_all("nav.navbar .nav-link").map(&:text)
      end.to be_empty
    end

    When "they sign up" do
      page.find("a", text: "Sign up").click
      page.find("form.new_user").fill_in("Email", with: "whitney.wolfe@bumble.com")
      page.find("form.new_user").fill_in("Password", with: "1password")
      page.find("form.new_user").fill_in("Password confirmation", with: "1password")
      page.find("form.new_user").find('input[type="submit"]').click
      wait_for do
        page.find('.alert [data-testid="message"]').text
      end.to eq "Welcome! You have signed up successfully."
    end

    Then "see awaiting beta page" do
      # TODO: a different page not just that they are signed in
      wait_for do
        page.find_all("nav.navbar .nav-link").map(&:text)
      end.to eq ["whitney.wolfe@bumble.com"]
    end

    When "admin invites them to beta"
    Then "user gets email"
    When "user is NOT signed in"
    And "user accepts beta invite"
    Then "the see the invite page"
    When "user is logged in"
    And "user accepts beta invite"
    Then "they see the full beta search experience"
    When "they share the beta"
    Then "their friend DOES NOT get to join the beta"
  end
end
