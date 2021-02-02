import React from 'react';
import uuid from 'react-uuid';
import { string } from 'prop-types';
import Highlighter from 'react-highlight-words';

export default function LocationResult({
  name, address, menuText, query,
}) {
  const matchingSnippets = () => {
    const offset = 60;
    const snippets = [];
    const whitespace = /\s+/gi;
    query
      .trim()
      .replace(whitespace, ' ')
      .split(' ')
      .forEach((word) => {
        let index = -1;
        let currentIndex = menuText
          .toLowerCase()
          .indexOf(word.toLowerCase(), index + 1);
        while (currentIndex > 0) {
          snippets.push({
            id: uuid(),
            text: menuText.slice(
              currentIndex > offset ? currentIndex - offset : 0,
              currentIndex + offset,
            ),
          });
          index = currentIndex;
          currentIndex = menuText
            .toLowerCase()
            .indexOf(word.toLowerCase(), index + 1);
        }
      });
    return snippets.length === 0 ? [{ id: uuid(), text: menuText }] : snippets;
  };

  return (
    <>
      <div className="row">
        <div className="col-sm-3">{name}</div>
        <div className="col-sm-3" />
        <div className="col-sm-6">{address}</div>
      </div>
      <div className="row">
        <div className="col">
          <ul>
            {matchingSnippets().map(({ text, id }) => (
              <li key={id}>
                <Highlighter
                  highlightStyle={{ backgroundColor: 'yellow' }}
                  searchWords={query.split(' ')}
                  autoEscape
                  textToHighlight={text}
                />
              </li>
            ))}
          </ul>
        </div>
      </div>
    </>
  );
}

LocationResult.propTypes = {
  name: string.isRequired,
  address: string.isRequired,
  menuText: string.isRequired,
  query: string.isRequired,
};
