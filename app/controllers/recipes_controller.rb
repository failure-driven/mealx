class RecipesController < ApplicationController
  def index
    @supported_recipes = SUPPORTED_RECIPES
  end

  SUPPORTED_RECIPES = {
    mustard: {
      ingredient: "Mustard",
      name: "creamy dijon chicken",
      image: "https://cafedelites.com/wp-content/uploads/2018/07/Creamy-Dijon-Chicken-IMAGE-34.jpg",
      ingredients: <<~EO_INGREDIENTS,
        For The Chicken:
          2 pounds (1 kg) boneless, skinless chicken thighs
          1 teaspoon seasoning salt (or regular salt)
          1/4 teaspoon pepper
          5 ounces (150 g) bacon
        For The Sauce:
          2 tablespoons butter
          1 onion
          4 cloves garlic, minced (or 1 tablespoon minced garlic)
          1 tablespoon fresh chopped parsley
          1 teaspoon each of dried thyme and dried rosemary
          1/3 cup dry white wine (Pinot Grigio/Gris, Sauv Blanc, Riesling) -- substitute with low-sodium chicken stock or broth
          1 1/2 cups half and half (thickened cream or heavy cream)
          2 tablespoons Dijon mustard
          1/2 teaspoon chicken bouillon powder (substitute with salt or stock powder)
          1/2 teaspoon freshly ground black pepper, to taste
          1/4 cup Parmesan cheese
          2 cups baby spinach leaves
      EO_INGREDIENTS
      link: "https://cafedelites.com/creamy-dijon-chicken/",
    },
    holandise: {
      ingredient: "Holandise sauce",
      name: "Savory Parmesan French Toast with Hollandaise Sauce",
      image: "https://thefoodcharlatan.com/wp-content/uploads/2014/06/IMG_4352-e1402652984657.jpg",
      ingredients: <<~EO_INGREDIENTS,
        For the French toast
          4 large eggs
          1/2 cup whole milk
          1/2 cup heavy cream
          1/2 cup grated Parmesan, plus more for garnish
          1/2 teaspoon dry mustard powder
          1/2 teaspoon hot sauce (I used Tabasco)
          freshly ground black pepper, to taste
          1 large garlic clove, crushed with the side of a knife
          dash salt
          medium-size loaf of good-quality bread, cut 1-inch thick
          butter, for frying
          flat-leaf parsley or chives, for garnish
        For the hollandaise
          3 egg yolks
          1/4 teaspoon dijon mustard
          1 tablespoon lemon juice
          1 dash hot sauce
          1/2 cup butter
      EO_INGREDIENTS
      link: "https://thefoodcharlatan.com/savory-parmesan-french-toast-hollandaise-sauce/",
    },
    herrings: {
      ingredient: "Herrings",
      name: "Herring and dill salad with potatoes",
      image: "http://aucdn.ar-cdn.com/recipes/port250/90f2e204-abf1-4820-9af3-59ab270cf294.jpg",
      ingredients: <<~EO_INGREDIENTS,
        Serves: 4#{' '}
        250 g pickled herring fillets in oil, drained
        2 medium white onions
        2 large dill pickles
        4 potatoes, cooked the previous day and left unpeeled
        herb cream
        1⁄2 cup (125 g) yogurt
        100 g whipping cream
        1 teaspoon grated horseradish paste
        1 to 2 teaspoons lemon juice
        3 tablespoons finely chopped fresh chervil
        4 tablespoons finely chopped fresh dill
        3 tablespoons finely chopped fresh Italian parsley
        salt and ground white pepper
      EO_INGREDIENTS
      link: "http://allrecipes.com.au/recipe/6867/herring-and-dill-salad-with-potatoes.aspx",
    },
    capsicum: {
      ingredient: "Capsicum",
      name: "Greek-style stuffed capsicums",
      image: "https://img.taste.com.au/7wDU4ygF/w720-h480-cfill-q80/taste/2016/11/greek-style-stuffed-capsicums-100614-1.jpeg", # rubocop:disable Layout/LineLength
      ingredients: <<~EO_INGREDIENTS,
        4 large red capsicums
        1/4 cup extra virgin olive oil
        1 large brown onion, finely chopped
        2 garlic cloves, crushed
        300g Coles 5 Star Extra Lean Beef Mince
        1 tablespoon oregano leaves
        1/2 cup fresh flat-leaf parsley leaves, roughly chopped
        1/2 cup fresh mint leaves, roughly chopped
        400g can chopped tomatoes
        1/2 cup white long-grain rice
        Salad leaves, to serve
        Salt flakes, to season
      EO_INGREDIENTS
      link: "https://www.taste.com.au/recipes/greek-style-stuffed-capsicums/e8817b67-da1b-4912-ad47-7dae09b13cb5",
    },
  }.freeze
end
