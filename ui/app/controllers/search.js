import Ember from 'ember';

export default Ember.Controller.extend({
  queryParams: ['q'],

  hits: Ember.computed.alias('model.hits'),

  updateSearchTerm: Ember.observer('q', function() {
    this.set('searchTerm', this.get('q'));
  }),

  actions: {
    search: function() {
      this.set('q', this.get('searchTerm'));
    }
  }
});
