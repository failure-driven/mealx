import React from 'react';
import ReactDOM from 'react-dom';
import Registration from '../src/components/Registration';

const elements = document.getElementsByClassName('registration');

// TODO do we need an event listiner? DOMCOntentLoaded or Turbolinks related?
Array.from(elements).forEach((element) => {
  const options = JSON.parse(element.getAttribute('data-options'));

  ReactDOM.render(
    <Registration options={options} />,
    element,
  );
});
