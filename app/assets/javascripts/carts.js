var iDelivered, removeFromCart;

$(document).ready(function() {
  $('.remove-from-cart').on("click", removeFromCart);
  return $('.i-delivered').on("click", iDelivered);
});

removeFromCart = function(e) {
  var item_id, session, tr;
  e.stopPropagation();
  e.preventDefault();
  item_id = this.getAttribute('data-item-id');
  tr = this.parentElement.parentElement;
  session = $('#session_key').val();
  return $.ajax({
    type: "POST",
    url: "/remove_from_cart",
    data: {
      dataType: 'text',
      _method: "delete",
      item_id: item_id,
      authenticity_token: session
    },
    success: function(data, textStatus) {
      console.log(data);
      $('.total-price').html(data);
      return tr.style.display = 'none';
    }
  });
};

iDelivered = function(e) {
  var cart_id, session;
  e.stopPropagation();
  e.preventDefault();
  cart_id = this.getAttribute('data-cart-id');
  session = $('#session_key').val();
  return $.ajax({
    type: "POST",
    url: "cart/" + cart_id + "/delivered",
    data: {
      dataType: 'text',
      cart_id: cart_id,
      authenticity_token: session
    },
    success: function(data, textStatus) {
      console.log(data);
      return $('#cart-' + cart_id + '-tr').html(data);
    }
  });
};

// ---
// generated by coffee-script 1.9.0