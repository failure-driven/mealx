import React from 'react';
import { func, string } from 'prop-types';

export default function QueryInput({ query, setQuery, handleKeyDown }) {
  return (
    <form>
      <input
        className="form-control"
        placeholder="Type a meal: eggs, burger, ..."
        value={query}
        onChange={(event) => setQuery(event.target.value)}
        onKeyDown={handleKeyDown}
      />
    </form>
  );
}

QueryInput.propTypes = {
  query: string.isRequired,
  setQuery: func.isRequired,
  handleKeyDown: func.isRequired,
};
