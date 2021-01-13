import React from 'react';
import { object } from 'prop-types';

export default function Registration({ options }) {
  if (options === null) return <></>;
  const { name, byline } = options;

  return (
    <>
      <h1>{name}</h1>
      <h3>{byline}</h3>
      <input type="email" />
    </>
  );
}

Registration.propTypes = {
  options: object.isRequired,
};
