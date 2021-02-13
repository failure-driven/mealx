import React, { useState } from 'react';
import {
  withScriptjs, withGoogleMap, GoogleMap, Marker,
} from 'react-google-maps';
import { string, object } from 'prop-types';
import InfoBox from 'react-google-maps/lib/components/addons/InfoBox';

const Location = ({ name, lat, lng }) => {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <Marker
      text={name}
      position={{ lat: parseFloat(lat), lng: parseFloat(lng) }}
      onClick={() => setIsOpen(!isOpen)}
    >
      {
        isOpen && (
        <InfoBox
          onClickClose={() => setIsOpen(!isOpen)}
        >
          <div style={{
            background: 'yellow', padding: '12px', fontSize: '16px', fontColor: '#08233B',
          }}
          >
            {name}
          </div>
        </InfoBox>
        )
      }
    </Marker>
  );
};

Location.propTypes = {
  name: string.isRequired,
  lat: string.isRequired,
  lng: string.isRequired,
};

const MyMapComponent = withScriptjs(withGoogleMap(({ locations }) => {
  const defaultProps = {
    center: {
      lat: -37.803,
      lng: 144.98,
    },
    zoom: 15,
  };

  return (
    <GoogleMap
      defaultCenter={defaultProps.center}
      defaultZoom={defaultProps.zoom}
    >
      {locations.map(({
        id, latitude, longitude, name,
      }) => <Location key={id} name={name} lat={latitude} lng={longitude} />)}
    </GoogleMap>
  );
}));

export default function Map({ mapKey, locations }) {
  return (
    // Important! Always set the container height explicitly
    <div style={{ height: '100vh', width: '100%' }}>
      <MyMapComponent
        googleMapURL={`https://maps.googleapis.com/maps/api/js?key=${mapKey}&v=3.exp&libraries=geometry,drawing,places`}
        loadingElement={<div style={{ height: '100%' }} />}
        containerElement={<div style={{ height: '400px' }} />}
        mapElement={<div style={{ height: '100%' }} />}
        locations={locations}
      />
    </div>
  );
}

Map.propTypes = {
  mapKey: string.isRequired,
  locations: object.isRequired,
};
