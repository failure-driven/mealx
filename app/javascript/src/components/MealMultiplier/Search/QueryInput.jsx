import React from 'react';
import { array, func, string } from 'prop-types';
import Autosuggest from 'react-autosuggest';

const renderSuggestion = (suggestion) => <div>{suggestion.text}</div>;
export default function QueryInput({
  query,
  handleKeyDown,
  handleOnChange,
  setQueryInput,
  suggestions,
}) {
  const inputProps = {
    className: 'form-control',
    placeholder: 'Type a meal: eggs, burger, ...',
    value: query,
    onChange: handleOnChange,
    onKeyDown: handleKeyDown,
  };
  return (
    <form>
      <Autosuggest
        suggestions={suggestions}
        onSuggestionsFetchRequested={({ value }) => {
          setQueryInput(value);
        }}
        onSuggestionsClearRequested={() => {}}
        getSuggestionValue={(suggestion) => suggestion.text}
        renderSuggestion={renderSuggestion}
        inputProps={inputProps}
      />
    </form>
  );
}

QueryInput.propTypes = {
  query: string.isRequired,
  handleKeyDown: func.isRequired,
  handleOnChange: func.isRequired,
  setQueryInput: func.isRequired,
  suggestions: array.isRequired,
};
