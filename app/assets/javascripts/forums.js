var showForumDetails, updateForumDetails;

$(function() {
  $('.show-details').on("click", showForumDetails);
  return $('.btn-update-forum').on("click", updateForumDetails);
});

showForumDetails = function(e) {
  var details_id;
  console.log('clickeddedeed');
  e.stopPropagation();
  e.preventDefault();
  details_id = "#" + this.getAttribute('data-class');
  if ($(details_id)[0].style.display === 'none') {
    return $(details_id).show(200, 'linear');
  } else {
    return $(details_id).hide(200, 'linear');
  }
};

updateForumDetails = function(e) {
  var action, details_id, id, session;
  e.stopPropagation();
  e.preventDefault();
  details_id = "#" + this.getAttribute('data-table');
  id = this.parentElement.parentElement.getAttribute('data-id');
  action = this.getAttribute('data-action');
  session = $('#session_key').val();
  return $.ajax({
    type: "PATCH",
    url: "/forums/" + id,
    data: {
      _method: "PUT",
      id: id,
      what: action,
      authenticity_token: session
    },
    success: function(data, textStatus, jqXHR) {
      $("#forum-" + id + "-update-section").html(data);
      $('.show-details').unbind("click");
      $('.show-details').on("click", showForumDetails);
      $('.btn-update-forum').unbind("click");
      return $('.btn-update-forum').on("click", updateForumDetails);
    }
  });
};