import Ember from 'ember';

var Router = Ember.Router.extend({
  location: ErisENV.locationType
});

Router.map(function() {
  this.route('search', { path: '/'});
});

export default Router;
