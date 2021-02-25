import React from 'react';
import { func, string } from 'prop-types';

export default function QueryInput({
  query,
  handleKeyDown,
  handleOnChange,
}) {
  return (
    <form>
      <input
        className="form-control"
        placeholder="Type a meal: eggs, burger, ..."
        value={query}
        onChange={handleOnChange}
        onKeyDown={handleKeyDown}
      />
    </form>
  );
}

QueryInput.propTypes = {
  query: string.isRequired,
  handleKeyDown: func.isRequired,
  handleOnChange: func.isRequired,
};
