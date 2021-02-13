import React, { useState } from 'react';
import uuid from 'react-uuid';
import { string } from 'prop-types';
import Highlighter from 'react-highlight-words';
import {
  Button, Modal, ModalHeader, ModalBody, ModalFooter, Tooltip,
} from 'reactstrap';

export default function LocationResult({
  id: locationId, name, address, menuText, query,
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

  const [modal, setModal] = useState(false);
  const toggle = (event) => { setModal(!modal); event.preventDefault(); };

  const [tooltipOpen, setTooltipOpen] = useState(false);
  const toggleMenuToolTip = () => setTooltipOpen(!tooltipOpen);
  return (
    <>
      <div className="row">
        <div className="col-sm-3">{name}</div>
        <div className="col-sm-2" />
        <div className="col-sm-6">{address}</div>
        <div className="col-sm-1">
          <button type="button" className="btn btn-outline-secondary" onClick={toggle} id={`showMenu${locationId}`}>
            <i className="fas fa-th-list" />
          </button>
          <Tooltip placement="right" isOpen={tooltipOpen} target={`showMenu${locationId}`} toggle={toggleMenuToolTip}>
            Show Menu
          </Tooltip>
        </div>
      </div>
      <Modal isOpen={modal} toggle={toggle}>
        <ModalHeader toggle={toggle}>Menu</ModalHeader>
        <ModalBody>
          <pre>
            {menuText}
          </pre>
        </ModalBody>
        <ModalFooter>
          <Button color="primary" onClick={toggle}>Close</Button>
        </ModalFooter>
      </Modal>
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
  id: string.isRequired,
  name: string.isRequired,
  address: string.isRequired,
  menuText: string.isRequired,
  query: string.isRequired,
};
