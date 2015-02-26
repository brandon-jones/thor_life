
$(document).ready(function() {
  return $('#create-new-comment').on("click", createNewComment);
});

createNewComment = function(e) {
	var body = $('#comment_body').val();
	if (body.length < 1) {
		$('#comment_body').parent().addClass('has-error');
	} else {
		$('#comment_body').parent().removeClass('has-error');
		return $.ajax({
      type: 'POST',
      url: '/comments',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      dataType: 'html',
      data: {
        comment: {
        	topic_id: $('#comment-topic-id').val(),
        	body: body
        },
        ajax: true
      },
      success: function(data, textStatus) {
        $('#comment_body').val("");
        $('#comments-table').prepend(data)
      }
    });
	}
};