# TODO

Multiplier ui
- [ ] map reload is now an issue again?
- [ ] autosuggest needs to work properly - ie pre fill, search and hit enter to work
- [ ] style menu + map + search - preview menu
- [ ] click on map & show restaurant working
- [ ] fix the typeahead resolver using multisearch table?
  mealx/app/graphql/resolvers/search_suggestion.rb
- [ ] lock down http://localhost:3000/flipper
Data
- [ ] MM  re fetch data, allow images of menu items to be shown - confirm what we
  do and don't have menu items for
Beta signup
- [ ] password optional
- [ ] secure flipper
- [ ] custom sign up screen
- [ ] JWT for acccepting beta single use - reset the reset_token
- [ ] confirmable
- [ ] remove unfinished elements
- [ ] move the flash message to hover over the pre-container
- [ ] MM seo of likely terms
- [ ] domain name
- [ ] MM/SS landing page + signup with locaiton
- ** $$$ for ads to see who signs up
- [ ] what do they get straight away?
- [ ] eamil signups more info
- [ ] setup beta customers
- [ ] user testing with paid service
- [ ] auto record some user sessions automatically
- [ ] decide what next

**MM**

- [ ] beta toggle enable
  ```
  JWT.encode({id: User.first.id, exp: 1.day.from_now.to_i}, Rails.application.secrets.secret_key_base)

  pp Flipper::Adapters::ActiveRecord::Feature.all
  pp Flipper::Adapters::ActiveRecord::Gate.all
  ```

- [ ] how do we want this to break with no google? no internet?
- [ ] System Time data
  - [x] generate
  - [ ] db:seeds to deploy and build
- [ ] input some demo data
  - Not convinced on Meal and Food Type split
  - should be title, description, link to all food items in descrpition and those placed in a hierarchy
- [ ] data for meal and location hierarchies
- [ ] location as a hierarchy using closure tree gem?
- [ ] secure flipper for feature flipping
  - https://medium.com/@ppbruna/feature-flags-using-ruby-on-rails-59ca93195309
- [ ] autocomplete
  naive data set
  ```
  Location.all.map{|l| l.menu_text }.join("\n").scan(/\w+|\W/).map(&:downcase).uniq.sort.filter{|w| w =~ /we/}
  ```

**SS**

- [ ] meal location model for manual data entry
  - meal
    - location_id,
    - meal_id
    - title,
    - description,
    - cost,
    - has_many food elements,
    - has_many hours served
    - TODO
      - location
        - website
        - opening hours
        - established
        - closed - to hold onto historical data
      - menu
        - location_id
        - images
        - date input
        - date published
        - associate meal items that were scanned from this menu
  - location hierarchy
  - food element hierarchy
  - hours in a week
  - calendar
  - meal taxonomy

---

- [ ] landing page

  - https://medium.com/@LoganTjm/9-tactics-of-pre-launch-app-landing-pages-that-get-thousands-of-signups-477905a0ed22
    - market 2-3 months before launch to get a pre-launch database
    - include
      - screenshots/visuals
      - description
      - lint to more info
      - call to action to get email
      - network growth
      - social links
    - front page should make it obvious to what you are signing up to
    - emotional and problem focused copy
      - emotion
      - urgency
      - makes a promise
      - drives action
    - obvious call to action NOT "sign up"
    - just email, maybe location?
    - incentive - exclusive, early access, free trial, complimentary
    - be creative with the sign up success email
    - social shares after signup
  - https://www.hongkiat.com/blog/mobile-app-landing-pages/
    - example images
  - https://geekflare.com/create-prelaunch-landing-page/
    - 3rd parties to build landing page
    - like https://landerapp.com/landing-page-templates/coming-soon
  - more inspiration
    - https://gleam.io/blog/launch-page/
    - https://www.shopify.com.au/blog/coming-soon-page
    - https://startupfashion.com/5-great-pre-launch-landing-pages-to-inspire-you/
    - https://designli.co/blog/how-to-build-the-perfect-pre-launch-landing-page/
  - RAILS SPECIFIC
    - https://www.plymouthsoftware.com/articles/ruby-on-rails-5-checks-before-launching-your-app
      - [ ] customise 404 and 500 pages
      - [ ] enfoce ssl
      - [x] use UUID
    - https://github.com/codelitt/launchpage-rails
      - sample app

- [ ] money
  - https://techcrunch.com/2020/12/01/announcing-techcrunchs-2021-event-calendar/
  - https://www.snowflake.com/startupchallenge/

- [ ] A/B test landing pages
- [ ] google analytics
- [ ] location directory for SEO
- [ ] js prettier
- [ ] upgrade to Ruby 3.0.0
- [ ] search page
- [ ] result page
- [ ] find restaurants job
- [ ] find restaurant menu job
  - [ ] or an API like https://documenu.com/
  - [ ] http://openmenu.com/api/
  - [ ] https://www.programmableweb.com/category/restaurants/api
  - [ ] https://developers.google.com/my-business/content/update-food-menus
  - [ ] https://developers.zomato.com/api
  - [ ] https://developer.foursquare.com/developer/
- [ ] restaurant menu digitization
  - [ ] https://nanonets.com/blog/menu-digitization-ocr-deep-learning/
  - [ ] https://menuparser.com/?ref=producthunt
  - [ ] https://www.klippa.com/en/blog/information/automatically-scan-menu-cards-with-ocr-ml-for-market-research-and-competitor-analyses/
  - [ ] https://aws.amazon.com/blogs/machine-learning/zomato-digitizes-menus-using-amazon-textract-and-amazon-sagemaker/
    - zomato - search for specific dishes
    - Amazon Textract
    - Amazon Sagemaker - menu structure detector
  - [ ] https://www.outsource2india.com/DataManagement/data-entry-restaurant-menu-digitization.asp
  - [ ] https://engineering.fb.com/2018/09/11/ai-research/rosetta-understanding-text-in-images-and-videos-with-machine-learning/
- [ ] realted products
  - [ ] https://pickeasy.ca/
  - [ ] https://yeppar.com/augmented-reality-restaurants.html

## Done

- [x] mailer.scss is being used on the web page?
- [x] user model and devise
- [x] admin priveleges
- [x] email and email framework
- [x] administrate or similar for backend pages
- [x] feature framework
  - [ ] https://launchdarkly.com/
  - [ ] https://split.io/
  - [x] https://www.flippercloud.io/
    - https://github.com/jnunemaker/flipper
    - https://medium.com/@ppbruna/feature-flags-using-ruby-on-rails-59ca93195309
- [x] bootstrap working in production
- [x] linting
- [x] react
