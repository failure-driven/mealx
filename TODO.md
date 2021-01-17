# TODO

**MM**

- [ ] input some demo data
- [ ] data for meal and location hierarchies
- [ ] location as a hierarchy using closure tree gem?
- [ ] secure flipper for feature flipping
  - https://medium.com/@ppbruna/feature-flags-using-ruby-on-rails-59ca93195309

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
    - emotional and  problem focused copy
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
- [ ] restaurant menu job reader

## Done

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
