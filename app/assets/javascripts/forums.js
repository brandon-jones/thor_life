var showForumDetails, updateForumDetails;

$(function() {
  return $('.btn-update-forum').on("click", updateForumDetails);
});

updateForumDetails = function(e) {
  var action, details_id, id, session;
  e.stopPropagation();
  e.preventDefault();
  details_id = "#" + this.getAttribute('data-table');
  id = this.getAttribute('data-forum-id');
  console.log('hi')
  action = this.getAttribute('data-action');
  session = $('#session_key').val();
  var strconfirm = false
  if (action == 'destroy') {
    strconfirm = confirm("Are you sure you want to delete?");
  }
  if ((action == 'destroy' && strconfirm == true) || action != 'destroy') {
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
  }
  return this.parentElement.parentElement.parentElement.className = 'btn-group'
};