# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  $('.add-to-cart').on "click", addToCart

addToCart = (e) ->
  e.stopPropagation()
  e.preventDefault()
  item_type = this.getAttribute('data-item-type')
  item_id = this.getAttribute('data-item-id')
  session = $('#session_key').val()
  $.ajax
    type: "POST"
    dataType: 'text'
    url: "/add_to_cart"
    data:
      dataType: 'text'
      item_type: item_type
      item_id: item_id
      authenticity_token: session
    success:  (data, textStatus) ->
      console.log data
      $('.total-price').html(data)
    error: (data, textStatus) ->
      alert data.responseText