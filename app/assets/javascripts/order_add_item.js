$(function(){

  var app = window.app = {};

  app.Products = function() {
    this._input_name = $('#products-search-name');
    this._input_id = $('#products-search-id');
    this._initAutocompleteName();
    this._initAutocompleteId();
  };

  app.Products.prototype = {
    _initAutocompleteName: function() {
      this._input_name
        .autocomplete({
          source: function(request, response) {
            $.ajax({
              url: "/orders/search",
              dataType: "json",
              data: {
                name: request.term,
              },
              success: function(data) {
                if (data.length === 0) {
                  console.log("*****1");
                  $('#products-search-name-no-results').empty().append('<span class="no-result"> No result found </span>');
                } else {
                  console.log("*****2");
                  $('#products-search-name-no-results').empty();
                  response(data);
                }
              }
            });
          },
          appendTo: '#products-search-name-results',
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
              url: "/orders/search",
              dataType: "json",
              data: {
                id: request.term,
              },
              success: function(data) {
                if (data.length === 0) {
                  console.log("*****1");
                  $('#products-search-id-no-results').empty().append('<span class="no-result"> No result found </span>');
                } else {
                  console.log("*****2");
                  $('#products-search-id-no-results').empty();
                  response(data);
                }
              },
              messages: {
                noResults: '',
                results: function() {}
              }
            });
          },
          appendTo: '#products-search-id-results',
          select: $.proxy(this._select, this)
        })
        .autocomplete('instance')._renderItem = $.proxy(this._render, this);
    },

    _render: function(ul, item) {
      var markup = [
        '<span class="item-img">',
          item.image_url,
        '</span>',
        '<span class="item-id">' + item.id + '</span>',
        '<span class="item-name">' + item.name + '</span>',
        '<span class="item-price">' + 'NT ' + item.price + '</span>'
      ];
      return $('<li>')
        .append(markup.join(''))
        .appendTo(ul);
    },

    _select: function(e, ui) {
      this._input_name.val(ui.item.name);
      this._input_id.val(ui.item.id);
      $('#products-search-price').text(ui.item.price);
      return false;
    }
  };

});