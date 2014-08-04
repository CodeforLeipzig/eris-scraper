import Ember from 'ember';

var client = new elasticsearch.Client({
  host: 'localhost:9200',
  log: 'trace'
});

export default Ember.Route.extend({
  queryParams: {
    q: {
      refreshModel: true
    }
  },

  model: function(params) {
    if(!Ember.isEmpty(params.q)) {
      return client.search({q: params.q});
    }
  }
});
