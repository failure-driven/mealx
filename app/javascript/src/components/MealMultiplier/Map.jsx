import React, { Component } from 'react';
import GoogleMapReact from 'google-map-react';

const AnyReactComponent = ({ text }) => <div>{text}</div>;

export default function Map({ mapKey, locations }) {
  const defaultProps = {
    center: {
      lat: -37.803,
      lng: 144.98,
    },
    zoom: 15,
  };

  return (
    // Important! Always set the container height explicitly
    <div style={{ height: '100vh', width: '100%' }}>
      <GoogleMapReact
        bootstrapURLKeys={{ key: mapKey }}
        defaultCenter={defaultProps.center}
        defaultZoom={defaultProps.zoom}
      >
        {locations.map(({
          id, latitude, longitude, name,
        }) => <AnyReactComponent key={id} text={name} lat={latitude} lng={longitude} />)}
      </GoogleMapReact>
    </div>
  );
}
