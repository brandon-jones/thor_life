var checkAdminLevel, image_cropper;

$(document).ready(function() {
  return $('.admin-user-level').on("change", checkAdminLevel);
});

checkAdminLevel = function(e) {
  var item_id;
  e.stopPropagation();
  e.preventDefault();
  admin_level = this.value;
  if (admin_level === "Forum" || admin_level === "Game" ) {
    $('.admin-obj-id').show(200, 'linear')
  } else {
    $('.admin-obj-id').hide(200, 'linear')
  }
};

image_cropper = function() {
  return $("#user_image").change(function() {
    var id, image, session;
    console.log('change triggered');
    id = $('#user_image').data('id');
    console.log(id);
    session = $('#user_image').data('auth');
    image = $('#user_image')[0].files.toString();
    $('#edit_user_1').submit();
    console.log(session);
    return $.ajax({
      type: "POST",
      url: "/users/" + id + "/image_upload",
      data: {
        _method: "POST",
        id: id,
        authenticity_token: session,
        image: image
      },
      success: function(data, textStatus, jqXHR) {
        console.log('change data');
        return alert(data);
      }
    });
  });
};