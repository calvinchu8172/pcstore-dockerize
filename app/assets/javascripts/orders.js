$(function(){
  $('.item-quantity-field').on('input', '.quantity', function(){
    sum_caculator();
  });
});

$(function(){
  $('#add-item').appendTo('#order-items > tbody')
});

$(function(){

  var inputs = $('.order-items-fields').find(".nested-fields-product-name");
  var input_ids = $('.order-items-fields').find(".nested-fields-product-id"); 
  inputs.each(function(index, elem){
    change_value(`#${elem.id}`);
  });
  input_ids.each(function(index, elem){
    change_value2(`#${elem.id}`);
  });  

});

$(document).on('click', '#add-nested-form-button', function() {
  
  var inputs = $('.order-items-fields').find(".nested-fields-product-name");
  var input_ids = $('.order-items-fields').find(".nested-fields-product-id");
  inputs.each(function(index, elem){
    change_value(`#${elem.id}`);
  });
  input_ids.each(function(index, elem){
    change_value2(`#${elem.id}`);
  });  
  $('.item-quantity-field').on('input', '.quantity', function(){
    sum_caculator();
  });

});

function change_value(input_id) {
  $(input_id).bind('railsAutocomplete.select', function(event, data){
    $(input_id).parents('.nested-fields').find('.nested-fields-product-id').val(data.item.id);
    $(input_id).parents('.nested-fields').find('.price').text(data.item.price);
    sum_caculator();
  });
};

function change_value2(input_id) {
  $(input_id).bind('railsAutocomplete.select', function(event, data){
    $(input_id).parents('.nested-fields').find('.nested-fields-product-name').val(data.item.name);
    $(input_id).parents('.nested-fields').find('.price').text(data.item.price);
    sum_caculator();
  });
};


function sum_caculator(){

  var quantity = [];
  var price = [];
  var sum = 0;

  $('.item-quantity-field .quantity').each(function(i){
    quantity.push(parseInt($(this).val(), 10));
  });
  console.log(quantity);

  $('.price').each(function(i){
    price.push(parseInt($(this).text(), 10));
  });
  console.log(price);
  

  for( var i = 0; i < price.length; i++ ) {
    sum += price[i] * quantity[i];
  }
  console.log(sum);

  if($.isNumeric(sum)){
    $('#total').text(sum);
  } else {
    $('#total').text('0');
  }
  
  quantity = [];
  price = [];
  sum = 0;

};




