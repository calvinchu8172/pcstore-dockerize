$(function(){
  var quantity = [];
  var price = [];
  var sum = 0;

  $('.item-quantity-field').on('input', '.quantity',function(){
    
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

  });
});

$(function(){
  $('#add-item').appendTo('#order-items > tbody')
});
