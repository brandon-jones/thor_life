# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  $('.remove-from-cart').on "click", removeFromCart

removeFromCart = (e) ->
  e.stopPropagation()
  e.preventDefault()
  item_id = this.getAttribute('data-item-id')
  tr = this.parentElement.parentElement
  session = $('#session_key').val()
  $.ajax
    type: "POST"
    dataType: 'text'
    url: "/remove_from_cart"
    data:
      _method: "delete"
      item_id: item_id
      authenticity_token: session
    complete:  (data, textStatus) ->
      console.log data
      $('.total-price').html(data.responseText)
      tr.style.display = 'none'