var showForumDetails, updateForumDetails;

$(document).ready(function() {

  var $tabs=$('.table-draggable')
  $( "tbody.connectedSortable" ).sortable({
    handle: ".move-row",
    tolerance: "pointer",
    connectWith: ".connectedSortable",
    items: ".sortable-table-rows",
    appendTo: $tabs,
    helper: fixHelperModified,
    zIndex: 999990,
    stop: function(e, ui) {
      ui.item.removeClass('active-item-shadow');
      return ui.item.children('.forum-center-row').effect('highlight', {color: 'blue'}, 1000);
    },
    update: function(e, ui) {
      if (this === ui.item.parent()[0]) {
        var item_id, position, $grouping_id;
        item_id = ui.item.data('item-id');
        $grouping_id = ui.item.parent().data('grouping-id');
        var tr = ui.item;
        position = ui.item.index();
        return $.ajax({
          type: 'POST',
          url: '/forums/update_row_order',
          beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
          dataType: 'json',
          data: {
            forum_id: item_id,
            grouping_id: $grouping_id,
            row_order_position: position
          },
          success: function(data, textStatus) {
            if ($("#forum-tbody-grouping-"+tr[0].dataset.groupingId).children('tr').length < 1) {
              $("#grouping-"+tr[0].dataset.groupingId+"-main-wrapper").hide();
            }
            if ($grouping_id == '') {
              $grouping_id = 'nil';
            }
            return tr[0].dataset.groupingId =  $grouping_id;
          }
        });
      }
    }
  }).disableSelection();

  $('.forum-groupings').on("change", newGrouping);
  $('.forum-game').on("change", upDateGameInstances);
  $('.new-topic-toggle').on("click", toggleNewForum);
  return $('.update-tf').on("click", updateTfDetails);
});

toggleNewForum = function(e) {
  e.stopPropagation();
  e.preventDefault();
  if ($("#new-topic-forum")[0].style.display == "none" ) {
    $("#new-topic-forum").show();
  } else {
    $("#new-topic-forum").hide();
  }
};

var fixHelperModified = function(e, tr) {
    var $originals = tr.children();
    var $helper = tr.clone();
    $helper.children().each(function(index)
    {
      $(this).width($originals.eq(index).width())
    });
    return $helper;
};

upDateGameInstances = function(e) {
  var id = this.value;
  if (id == "-2") {
    $("#game-instances-form-group").html('');
    $("#game-instances-form-group").hide();
  } else {
    $("#game-instances-form-group").show();
    $.ajax({
      type: "GET",
      url: "/games/" + id +"/get_game_instances",
      success: function(data, textStatus, jqXHR) {
        return $("#game-instances-form-group").html(data);
      }
    });
  }
};

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