$(function(){

  // var app = window.app = {};

  app.Users = function() {
    this._input_email = $('#users-search-email');
    this._input_id = $('#users-search-id');
    this._initAutocompleteName();
    this._initAutocompleteId();
  };

  app.Users.prototype = {
    _initAutocompleteName: function() {
      this._input_email
        .autocomplete({
          source: function(request, response) {
            $.ajax({
              url: "/users/search",
              dataType: "json",
              data: {
                email: request.term,
              },
              success: function(data) {
                if (data.length === 0) {
                  console.log("*****1");
                  $('#users-search-email-no-results').empty().append('<span class="no-result"> No result found </span>');
                } else {
                  console.log("*****2");
                  $('#users-search-email-no-results').empty();
                  response(data);
                }
              }
            });
          },
          appendTo: '#users-search-email-results',
          select: $.proxy(this._select, this),
          messages: {
            noResults: '',
            results: function() {}
          }
        })
        .autocomplete('instance')._renderItem = $.proxy(this._render, this);
    },

    _initAutocompleteId: function() {
      this._input_id
        .autocomplete({
          source: function(request, response) {
            $.ajax({
              url: "/users/search",
              dataType: "json",
              data: {
                id: request.term,
              },
              success: function(data) {
                if (data.length === 0) {
                  console.log("*****1");
                  $('#users-search-id-no-results').empty().append('<span class="no-result"> No result found </span>');
                } else {
                  console.log("*****2");
                  $('#users-search-id-no-results').empty();
                  response(data);
                }
              },
              messages: {
                noResults: '',
                results: function() {}
              }
            });
          },
          appendTo: '#users-search-id-results',
          select: $.proxy(this._select, this)
        })
        .autocomplete('instance')._renderItem = $.proxy(this._render, this);
    },

    _render: function(ul, item) {
      var markup = [
        '<span class="item-id">' + item.id + '</span>',
        '<span class="item-name">' + item.email + '</span>'
      ];
      return $('<li>')
        .append(markup.join(''))
        .appendTo(ul);
    },

    _select: function(e, ui) {
      this._input_email.val(ui.item.email);
      this._input_id.val(ui.item.id);
      return false;
    }
  };

});