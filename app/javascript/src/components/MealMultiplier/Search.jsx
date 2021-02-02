import React, { useState } from 'react';
import { useNavigate } from '@reach/router';
import { string } from 'prop-types';
import { ApolloProvider, Query } from 'react-apollo';
import { gql } from 'apollo-boost';

import ApolloClient from '../../api/ApolloClient';
import QueryInput from './Search/QueryInput';
import LocationResult from './Search/LocationResult';

const MENU_SEARCH = gql`
  query MenuSearch($query: String!) {
    menuSearch(query: $query) {
      locations {
        id
        name
        address
        latitude
        longitude
        menuText
      }
    }
  }
`;

export default function Search({ query: inputQuery }) {
  const navigate = useNavigate();
  const [queryInput, setQueryInput] = useState(
    inputQuery.replaceAll('+', ' ').replace(/\s+/, ' '),
  );
  const [query, setQuery] = useState(
    inputQuery.replaceAll('+', ' ').replace(/\s+/, ' '),
  );

  const handleKeyDown = (event) => {
    if (event.key === 'Enter') {
      setQueryInput(queryInput.trim());
      setQuery(queryInput.trim());
      const whitespace = /\s+/gi;
      navigate(
        `/multiplier/search/${queryInput.trim().replaceAll(whitespace, '+')}`,
      );
      event.preventDefault();
    }
  };

  return (
    <ApolloProvider client={ApolloClient}>
      <div className="row">
        <div className="col-sm-2" />
        <div className="col-sm-8">
          <QueryInput
            query={queryInput}
            setQuery={setQueryInput}
            handleKeyDown={handleKeyDown}
          />
          <small>hit enter to pefrom search</small>
        </div>
      </div>
      <hr />
      <div className="row">
        <div className="col-sm-1" />
        <div className="col-sm-10">
          <Query query={MENU_SEARCH} variables={{ query: query || '' }}>
            {({ loading, error, data }) => {
              if (loading) return 'loading ...';
              if (error) return `Error! ${query} ${error.message}`;
              return data.menuSearch.locations.map(
                ({
                  id, name, address, menuText,
                }) => (
                  <LocationResult
                    key={id}
                    name={name}
                    address={address}
                    menuText={menuText}
                    query={query}
                  />
                ),
              );
            }}
          </Query>
        </div>
      </div>
    </ApolloProvider>
  );
}

Search.propTypes = {
  query: string,
};
Search.defaultProps = {
  query: '',
};
