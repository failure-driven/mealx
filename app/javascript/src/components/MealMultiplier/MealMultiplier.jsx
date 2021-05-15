import React, { useState } from 'react';
import { object } from 'prop-types';
import { Router, useNavigate } from '@reach/router';
import { ApolloProvider, Query } from 'react-apollo';
import { gql } from 'apollo-boost';

import ApolloClient from '../../api/ApolloClient';
import Search from './Search';

const GET_MEALS = gql`
  query Meals($query: String!) {
    meals(query: $query) {
      id
      name
    }
  }
`;

const GET_LOCATIONS = gql`
  query Locations($mealNames: [String!]!) {
    locations(mealNames: $mealNames) {
      id
      name
      address
      latitude
      longitude
    }
  }
`;

function Meals({ meal }) {
  const navigate = useNavigate();
  const [query, setQuery] = useState('');
  const [mealNames, setMealNames] = useState(
    meal
      ? meal
        .split('+')
        .map((mealString) => ({ id: mealString, name: mealString }))
      : [],
  );

  return (
    <ApolloProvider client={ApolloClient}>
      <div className="row">
        <div className="col-sm-2" />
        <div className="col-sm-8">
          <form>
            <input
              className="form-control"
              placeholder="Type a meal: eggs, burger, ..."
              value={query}
              onChange={(event) => setQuery(event.target.value)}
            />
          </form>
        </div>
      </div>
      <div className="row mt-2">
        <div className="col-sm-2" />
        <div className="col-sm-8">
          <Query query={GET_MEALS} variables={{ query }}>
            {({ loading, error, data }) => {
              if (loading) return 'loading ...';
              if (error) return `Error! ${query} ${error.message}`;
              return data.meals.map(({ id, name }) => (
                <div key={id} className="mb-2">
                  <button
                    type="button"
                    className="btn btn-secondary"
                    onClick={() => {
                      setMealNames([...mealNames, { id, name }]);
                      setQuery('');
                      navigate(
                        `/multiplier/${[
                          ...mealNames.map((mealName) => mealName.name),
                          name,
                        ]
                          .map((str) => str.toLowerCase())
                          .join('+')}`,
                      );
                    }}
                  >
                    {name}
                    &nbsp;
                    <i className="fas fa-plus" />
                  </button>
                </div>
              ));
            }}
          </Query>
        </div>
      </div>
      <div className="row mt-2">
        <div className="col-sm-2" />
        <div className="col-sm-8">
          {mealNames.map(({ id, name }) => (
            <React.Fragment key={id}>
              <button
                type="button"
                className="btn btn-outline-secondary mr-2"
                onClick={() => {
                  setMealNames(
                    mealNames.filter((element) => element.id !== id),
                  );
                  navigate(
                    `/multiplier/${mealNames
                      .filter((element) => element.id !== id)
                      .map((mealName) => mealName.name)
                      .map((str) => str.toLowerCase())
                      .join('+')}`,
                  );
                }}
              >
                {name}
                {' '}
                <i className="fas fa-times" />
              </button>
              <i className="fas fa-plus mr-2" />
            </React.Fragment>
          ))}
        </div>
      </div>
      <hr />
      <div className="row">
        <div className="col-sm-12">
          <button type="button" className="btn btn-outline-info float-right">
            <i className="fas fa-map" />
          </button>
          <button
            type="button"
            className="btn btn-outline-info float-right mr-2"
          >
            <i className="fas fa-list" />
          </button>
        </div>
      </div>
      <div className="row">
        <div className="col-sm-1" />
        <div className="col-sm-10">
          <Query
            query={GET_LOCATIONS}
            variables={{ mealNames: mealNames.map(({ name }) => name) }}
          >
            {({ loading, error, data }) => {
              if (mealNames.length === 0) return '...';
              if (loading) return 'loading ...';
              if (error) return `Error! ${query} ${error.message}`;
              return data.locations.map(({ id, name, address }) => (
                <div key={id} className="row">
                  <div className="col-sm-3">{name}</div>
                  <div className="col-sm-3" />
                  <div className="col-sm-6">{address}</div>
                </div>
              ));
            }}
          </Query>
        </div>
      </div>
    </ApolloProvider>
  );
}

Meals.propTypes = {
  meal: object,
};

Meals.defaultProps = {
  meal: {},
};

export default function MealMultiplier({ options: { googleApiKey } }) {
  return (
    <Router>
      <Meals path="multiplier" />
      <Search path="multiplier/search" mapKey={googleApiKey} />
      <Search path="multiplier/search/:query" mapKey={googleApiKey} />
      <Meals path="multiplier/:meal" />
    </Router>
  );
}

MealMultiplier.propTypes = {
  options: object.isRequired,
};
