var React = window.React = global.React = require('react');
var ReactDOM = window.ReactDOM = global.ReactDOM = require('react-dom');
var PropTypes = window.PropTypes = global.PropTypes = require('prop-types');

window.flash = function(msg, type) {
  document.querySelector("#flash-messages").innerHTML = `<div class="alert ${type}">${msg}</div>`;
  setTimeout(function(){
    document.querySelector("#flash-messages .alert").className = 'alert ${type} hide';
  }, 5000);
};

require('whatwg-fetch');
require('./components');
