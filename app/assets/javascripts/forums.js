var showForumDetails, updateForumDetails;

$(function() {
  $('.forum-groupings').on("change", newGrouping);
  return $('.update-tf').on("click", updateTfDetails);
});

newGrouping = function(e) {
  if (this.value == "-1") {
    console.log('hi');
    $('#new-grouping-forum').show();
  } else {   
    $('#forum_new_grouping').val("");
    $('#new-grouping-forum').hide();
  }
};

updateTfDetails = function(e) {
  var action, id, session;
  e.stopPropagation();
  e.preventDefault();
  item = this.getAttribute('data-item-type');
  id = this.getAttribute('data-item-id');
  action = this.getAttribute('data-action');
  session = $('#session_key').val();
  var strconfirm = false
  if (action == 'destroy') {
    strconfirm = confirm("Are you sure you want to delete?");
  }
  if ((action == 'destroy' && strconfirm == true) || action != 'destroy') {
    return $.ajax({
      type: "PATCH",
      url: "/" + item + "s/" + id,
      data: {
        _method: "PUT",
        id: id,
        what: action,
        authenticity_token: session
      },
      success: function(data, textStatus, jqXHR) {
        $("#" + item + "-" + id + "-update-section").html(data);
        $('.update-tf').unbind("click");
        return $('.update-tf').on("click", updateTfDetails);
      }
    });
  }
  return this.parentElement.parentElement.parentElement.className = 'btn-group'
};