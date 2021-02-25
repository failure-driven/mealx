import React, { useState } from 'react';
import { useNavigate } from '@reach/router';
import { string } from 'prop-types';
import { ApolloProvider, Query } from 'react-apollo';
import { gql } from 'apollo-boost';

import ApolloClient from '../../api/ApolloClient';
import QueryInput from './Search/QueryInput';
import LocationResult from './Search/LocationResult';
import Map from './Map';

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

const SEARCH_SUGGESTIONS = gql`
  query SearchSuggestions($searchText: String!) {
    searchSuggestions(searchText: $searchText) {
      text
    }
  }
`;

export default function Search({ query: inputQuery, mapKey }) {
  const navigate = useNavigate();
  const [showList, setShowList] = useState(false);
  const [queryInput, setQueryInput] = useState(
    inputQuery.replaceAll('+', ' ').replace(/\s+/, ' '),
  );
  const [query, setQuery] = useState(
    inputQuery.replaceAll('+', ' ').replace(/\s+/, ' '),
  );
  const [locations, setLocations] = useState([]);
  const [suggestions, setSuggestions] = useState([]);

  const handleKeyDown = (event) => {
    if (event.key === 'Enter') {
      const whitespace = /\s+/gi;
      navigate(
        `/multiplier/search/${queryInput.trim().replaceAll(whitespace, '+')}`,
      );
      event.preventDefault();
    }
  };

  const handleOnChange = (event) => {
    setQuery(queryInput);
    setQueryInput(event.target.value);
  };

  return (
    <ApolloProvider client={ApolloClient}>
      <div className="row">
        <div className="col-sm-2" />
        <div className="col-sm-8">
          <QueryInput
            query={queryInput}
            handleKeyDown={handleKeyDown}
            handleOnChange={handleOnChange}
            setQueryInput={setQueryInput}
            suggestions={suggestions}
          />
          <small>hit enter to perform search</small>
        </div>
      </div>
      <hr />
      <div className="row">
        <div className="col-sm-12">
          <button
            type="button"
            className={`btn btn${showList ? '-outline' : ''}-info float-right`}
            onClick={() => setShowList(false)}
          >
            <i className="fas fa-map" />
          </button>
          <button
            type="button"
            className={`btn btn${
              showList ? '' : '-outline'
            }-info float-right mr-2`}
            onClick={() => setShowList(true)}
          >
            <i className="fas fa-list" />
          </button>
        </div>
      </div>
      <div className="row">
        <div className="col-sm-10 offset-sm-1">
          <Map mapKey={mapKey} locations={locations} />
          ;
        </div>
      </div>
      <div className="row">
        <div className="col-sm-10 offset-sm-1">
          {showList
            && locations.map(({
              id, name, address, menuText,
            }) => (
              <LocationResult
                key={id}
                id={id}
                name={name}
                address={address}
                menuText={menuText}
                query={query}
              />
            ))}
        </div>
      </div>
      <Query query={MENU_SEARCH} variables={{ query: query || '' }}>
        {({ loading, error, data }) => {
          if (loading) return 'loading ...';
          if (error) return `Error! ${query} ${error.message}`;
          setLocations(data.menuSearch.locations);
          return <></>;
        }}
      </Query>
      <Query query={SEARCH_SUGGESTIONS} variables={{ searchText: query }}>
        {({ loading, error, data }) => {
          if (loading) return 'loading ...';
          if (error) return `Error! ${query} ${error.message}`;
          setSuggestions(data.searchSuggestions);
          return <></>;
        }}
      </Query>
    </ApolloProvider>
  );
}

Search.propTypes = {
  query: string,
  mapKey: string.isRequired,
};
Search.defaultProps = {
  query: '',
};
