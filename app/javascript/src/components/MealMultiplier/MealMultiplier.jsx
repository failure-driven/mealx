import React from 'react';
import uuid from 'react-uuid';

export default function MealMultiplier() {
  const filters = [
    { id: uuid(), name: 'Eggs' },
    { id: uuid(), name: 'Burger' },
    { id: uuid(), name: 'Chocolate Cake' },
  ];
  const results = [
    {
      id: uuid(),
      name: 'Cafe 1',
      hours: '7am-4pm',
      address: '1 High Street',
      distance: '3km',
    },
    {
      id: uuid(),
      name: 'Cafe 2',
      hours: '7am-4pm',
      address: '2 Station Street',
      distance: '3km',
    },
    {
      id: uuid(),
      name: 'Restaurant 15',
      hours: '2pm-8pm',
      address: '15 Springfield Street',
      distance: '3km',
    },
  ];

  return (
    <>
      <div className="row">
        <div className="col-sm-2" />
        <div className="col-sm-8">
          <form>
            <input
              className="form-control"
              placeholder="Type a meal: eggs, burger, ..."
            />
          </form>
        </div>
      </div>
      <div className="row mt-2">
        <div className="col-sm-2" />
        <div className="col-sm-8">
          {filters.map((filter) => (
            <>
              <button
                key={filter.id}
                type="button"
                className="btn btn-secondary mr-2"
              >
                {filter.name}
                {' '}
&nbsp;
                <i className="fas fa-times" />
              </button>
              <i className="fas fa-plus mr-2" />
            </>
          ))}
        </div>
      </div>
      <hr />
      <div className="row">
        <div className="col-sm-1" />
        <div className="col-sm-9" />
        <div className="col-sm-1">
          <button type="button" className="btn">
            <i className="fas fa-map" />
          </button>
        </div>
        <div className="col-sm-1">
          <button type="button" className="btn">
            <i className="fas fa-list" />
          </button>
        </div>
      </div>
      <div className="row">
        <div className="col-sm-1" />
        <div className="col-sm-10">
          <div className="row">
            <div className="col">
              <i>Results</i>
            </div>
          </div>
          {results.map((location) => (
            <div key={location.id} className="row">
              <div className="col-sm-3">{location.name}</div>
              <div className="col-sm-3">{location.hours}</div>
              <div className="col-sm-3">{location.distance}</div>
              <div className="col-sm-3">{location.address}</div>
            </div>
          ))}
          <div className="row">
            <div className="col">...</div>
          </div>
        </div>
      </div>
    </>
  );
}
