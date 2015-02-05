# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->



image_cropper = ->
  $("#user_image").change ->
    console.log('change triggered')
    id = $('#user_image').data('id')
    console.log(id)
    session = $('#user_image').data('auth')
    image = $('#user_image')[0].files.toString()
    $('#edit_user_1').submit()
    console.log(session)