# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  $('.show-details').on "click", showForumDetails

  $('.btn-update-forum').on "click", updateForumDetails

showForumDetails = (e)->
  console.log('clickeddedeed')
  e.stopPropagation()
  e.preventDefault()
  details_id = "#"+this.getAttribute('data-class')
  if $(details_id)[0].style.display == 'none'
    $(details_id).show(200,'linear')
  else
    $(details_id).hide(200,'linear')

updateForumDetails = (e)->
  e.stopPropagation()
  e.preventDefault()
  details_id = "#"+this.getAttribute('data-table')
  id = this.parentElement.parentElement.getAttribute('data-id')
  action = this.getAttribute('data-action')
  session = $('#session_key').val()
  $.ajax
    type: "PATCH"
    url: "/forums/" + id
    data:
      _method: "PUT"
      id: id
      what: action
      authenticity_token: session
    success:  (data, textStatus, jqXHR) ->
      $("#forum-" + id + "-update-section").html(data)
      $('.show-details').unbind("click");
      $('.show-details').on "click", showForumDetails
      $('.btn-update-forum').unbind("click");
      $('.btn-update-forum').on "click", updateForumDetails