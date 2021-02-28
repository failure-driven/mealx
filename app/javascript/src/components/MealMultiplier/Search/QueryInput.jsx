import React from 'react';
import { array, func, string } from 'prop-types';
import { AsyncTypeahead } from 'react-bootstrap-typeahead';

export default function QueryInput({
  query,
  performMapLocationSearch,
  suggestions,
  typeAheadSearch,
}) {
  const inputProps = {
    autoFocus: true,
    placeholder: 'Type a meal: eggs, burger, ...',
    value: query,
  };
  return (
    <form>
      <AsyncTypeahead
        id="meal-typeahead"
        inputProps={inputProps}
        minLength={0}
        onChange={performMapLocationSearch}
        onSearch={typeAheadSearch}
        // onInputChange={(text) => {console.log("reset for blank if text.length === 0")}}
        options={suggestions.map((suggestion) => suggestion.text)}
      />
    </form>
  );
}

QueryInput.propTypes = {
  query: string.isRequired,
  performMapLocationSearch: func.isRequired,
  suggestions: array.isRequired,
  typeAheadSearch: func.isRequired,
};
