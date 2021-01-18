import React from 'react';
import ReactDOM from 'react-dom';
import MealMultiplier from '../src/components/MealMultiplier/MealMultiplier';

const elements = document.getElementsByClassName('meal-multiplier');

// TODO do we need an event listiner? DOMCOntentLoaded or Turbolinks related?
Array.from(elements).forEach((element) => {
  const options = JSON.parse(element.getAttribute('data-options'));

  ReactDOM.render(<MealMultiplier options={options} />, element);
});
