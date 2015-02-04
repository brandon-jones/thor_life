# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  $('.show-details').on "click", showForumDetails

showForumDetails = (e)->
  e.stopPropagation()
  e.preventDefault()
  details_id = "#"+this.getAttribute('data-class')
  if $(details_id)[0].style.display == 'none'
    $(details_id).show(200,'linear')
  else
    $(details_id).hide(200,'linear')