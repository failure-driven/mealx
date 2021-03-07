require "rails_helper"

feature "Enable beta search flip", js: true do
  scenario "enable beta search flip" do
    When "Whitney WOlve of bumble visits Meal X to multiply her meals" do
      visit root_path
    end

    Then "the see a sign up call to action" do
      wait_for do
        page.find_all(".pre-container .jumbotron a").map(&:text)
      end.to eq(["Register for early beta"])
    end

    When "Whiteny registers" do
      page.find(".pre-container .jumbotron a", text: "Register for early beta").click
      page.find("form.new_user").fill_in("Email", with: "whitney.wolfe@bumble.com")
      page.find("form.new_user").find('input[type="submit"]').click
    end

    Then "she sees a notification that she should check her email for a link to activate her account" do
      wait_for do
        page.find('.alert [data-testid="message"]').text
      end.to eq "A message with a confirmation link has been sent to your email address. " \
        "Please follow the link to activate your account."
    end

    But "she is still on the landing page and is NOT logged in" do
      wait_for do
        page.find_all("nav.navbar .nav-link").map(&:text)
      end.to contain_exactly("Log in", "Sign up")
    end

    When "she activates her account via the email" do
      open_email "whitney.wolfe@bumble.com"
      wait_for do
        current_email.text
      end.to match(/Welcome whitney.wolfe@bumble.com!.*confirm.*link below: Confirm my account.*/)
      current_email.click_link "Confirm my account"
      clear_emails
    end

    Then "she sees she is on the preview and signed in" do
      expect(page).to have_current_path("/preview")
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
        confirmed_at: DateTime.now,
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
