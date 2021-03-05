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
      end.to contain_exactly("Log in", "Sign up")
    end

    When "they sign up" do
      page.find("form#new_user").sibling("a", text: "Sign up").click
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

    When "admin invites them to beta" do
      page.find("nav a", text: "Sign out").click

      User.create!(
        email: "mel.gollan@rip.global",
        user_actions: { admin: { can_administer: true } },
        password: "1password",
        password_confirmation: "1password",
      )

      visit admin_users_path

      page.find("form.new_user").fill_in("Email", with: "mel.gollan@rip.global")
      page.find("form.new_user").fill_in("Password", with: "1password")
      page.find("form.new_user").find('input[type="submit"]').click
      wait_for do
        page.find(".flashes .flash").text
      end.to eq "Signed in successfully."
      page.refresh # deal with the flash animating down and next click not working

      page.find("td", text: "whitney.wolfe@bumble.com").click
      page.find(".form-actions a", text: "Send Beta Invitation Email").click

      page.find(".navigation a", text: "Back to app").click
      page.find("nav a", text: "Sign out").click
    end

    Then "user gets email" do
      open_email "whitney.wolfe@bumble.com"
      wait_for do
        current_email.text
      end.to match(/lucky ones to get a Beta invitations to MealX.*next 24 hours.*ACCEPT BETA/)
    end

    When "user is NOT signed in" do
      wait_for do
        page.find_all("nav.navbar .nav-link").map(&:text)
      end.to contain_exactly("Log in", "Sign up")
    end

    And "user accepts beta invite" do
      current_email.click_link "ACCEPT BETA"
    end

    Then "the user is logged in and sees a MealX beta success message" do
      wait_for do
        page.find_all("nav.navbar .nav-link").map(&:text)
      end.to include("whitney.wolfe@bumble.com")
      wait_for do
        page.find('.alert [data-testid="message"]').text
      end.to eq "Congratulations you are now part of the MealX Beta."
    end

    And "all the MealX beta menu items" do
      wait_for do
        page.find_all("nav.navbar .nav-link").map(&:text)
      end.to contain_exactly(
        "Multiplier",
        "Search",
        "Search > Eggs",
        "Search > Duck + chocolate cake",
        "whitney.wolfe@bumble.com",
      )
    end

    When "the user clicks on search" do
      page.find("nav a", text: "Search", match: :prefer_exact).click
    end

    Then "they see the full beta search experience" do
      wait_for do
        page.find_all("input").map { |i| i["placeholder"] }
      end.to contain_exactly(
        "Type a meal: eggs, burger, ...",
        "",
      )
    end
  end
end
