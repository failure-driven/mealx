import React from 'react';
import GoogleMapReact from 'google-map-react';
import { string, object } from 'prop-types';

const AnyReactComponent = ({ text }) => <div>{text}</div>;
AnyReactComponent.propTypes = {
  text: string.isRequired,
};

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

Map.propTypes = {
  mapKey: string.isRequired,
  locations: object.isRequired,
};
