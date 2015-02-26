var showForumDetails, updateForumDetails;

$(document).ready(function() {
  $(document).on("keypress", 'form', function (e) {
    var code = e.keyCode || e.which;
    if (code == 13) {
      console.log(this)
      e.preventDefault();
      return false;
    }
  });
  sortableRows();
  setSortable();
  $('.forum-groupings').on("change", newGrouping);
  $('.forum-game').on("change", upDateGameInstances);
  $('#create-new-topic').on("click", createNewTopic);
  $('.create-new-forum').on("click", createNewForum);
  $('#create-new-group').on("click", createNewGroup);
  $('.new-forum-toggle').on("click", toggleNewForum);
  $('.new-topic-toggle').on("click", toggleNewTopic);
  $('.new-group-toggle').on("click", toggleNewGroup);
  $('.remove-grouping').on("click", removeGrouping);
  return $('.update-tf').on("click", updateTfDetails);
});

function sortableRows(){
    var tr  = document.createElement('tr');
    tr.classList.add("sortable-table-rows");
    tr.classList.add("empty-forum-row");
    var td = tr.insertCell();
    td.classList.add("empty-forum-col");
    return tr;
}sortableRows();

setSortable = function(e) {
  var $tabs=$('.table-draggable')
  $( "tbody.connectedSortable" ).sortable({
    handle: ".move-row",
    axis: "y",
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
              // $("#grouping-"+tr[0].dataset.groupingId+"-main-wrapper").hide();
              $("#forum-tbody-grouping-"+tr[0].dataset.groupingId).append(sortableRows());
            }

            jQuery.each($("#forum-tbody-grouping-"+$grouping_id).children('tr'), function(index, value) {
              if (this.classList.contains("empty-forum-row")) {
                this.remove();
              }
            });
            if ($grouping_id == '') {
              $grouping_id = 'nil';
            }
            return tr[0].dataset.groupingId =  $grouping_id;
          }
        });
      }
    }
  }).disableSelection();
};

removeGrouping = function(e) {
  console.log('hi');
  e.stopPropagation();
  e.preventDefault();
  var grouping_id = this.dataset.groupingId;
  var forum_children = $('#forum-tbody-grouping-'+grouping_id).children();
  var del = false;
  if (forum_children.length > 0) {
    if (forum_children[0].classList.contains("empty-forum-row") && forum_children.length == 1) {
      del = true;
    } else {
      strconfirm = confirm("Are you sure you want to delete? Forums will be moved to ungrouped");
      if (strconfirm == true) {
        del = true;
      }
    }
  }
  if (del == true) {
    return $.ajax({
      type: 'DELETE',
      url: '/groupings/'+grouping_id,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: {
        ajax: true
      },
      success: function(data, textStatus) {
        var trs = $('#forum-tbody-grouping-'+grouping_id).children();
        $('.main-tr-grouping-'+grouping_id).remove();
        jQuery.each(trs, function(index, value) {
          console.log(this);
          this.dataset.groupingId = 'nil';
          if (this.classList.contains("empty-forum-row")) {
            $('#forum-tbody-grouping-nil').append(this);
          }
        });
        return ;
      }
    });
  }
};

createNewForum = function(e) {
  var topic = {};
  var parent_id = this.dataset.parentId;
  var grouping_id = this.dataset.groupingId;
  if ($("#title-"+parent_id+"-"+grouping_id).val().length > 0) {
    topic['grouping_id'] = grouping_id;
    topic['title'] = $("#title-"+parent_id+"-"+grouping_id).val();
    topic['game_id'] = $("#game-id-"+parent_id+"-"+grouping_id).val();
    if (topic['game_id'] != "-2") {
      topic['game_instance_id'] = $("#game-instance-id-"+parent_id+"-"+grouping_id).val();
    }

    topic['locked'] = $("#game-instance-id-"+parent_id+"-"+grouping_id).is(":checked");
    topic['admin_only'] = $("#game-instance-id-"+parent_id+"-"+grouping_id).is(":checked");
    topic['main_feed'] = $("#main-feed-"+parent_id+"-"+grouping_id).is(":checked");
    topic['parent_id'] = parent_id;
    
    return $.ajax({
      type: 'POST',
      url: '/forums',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: {
        forum: topic,
        ajax: true
      },
      success: function(data, textStatus) {
        $("#title-"+parent_id+"-"+grouping_id).val("");
        $("#grouping-id-"+parent_id+"-"+grouping_id).value = "-1";
        $("#new-grouping-title-"+parent_id+"-"+grouping_id).val("");
        $("#game-id-"+parent_id+"-"+grouping_id);
        $("#locked-"+parent_id+"-"+grouping_id).checked = false;;
        $("#admin-only-"+parent_id+"-"+grouping_id).checked = false;;
        $("#main-feed-"+parent_id+"-"+grouping_id).checked = false;;
        $("#new-forum-"+grouping_id).hide( "blind", { direction: "up" }, 'slow');
        if ($('#forum-tbody-grouping-'+grouping_id).children('tr').length == 1) {
          if ($('#forum-tbody-grouping-'+grouping_id).children('tr')[0].classList.contains("empty-forum-row")) {
            $('#forum-tbody-grouping-'+grouping_id).children('tr')[0].remove();
          }
        }
        $('#forum-group-'+grouping_id).append(data);
        $('.update-tf').unbind("click");
        $('.update-tf').on("click", updateTfDetails);
        return ;
      }
    });
  } else {
    $("#title-"+parent_id+"-"+grouping_id).parent().addClass('field_with_errors');
  }
}

toggleNewForum = function(e) {
  var forum = "#new-forum-" + this.dataset.groupingId;
  if ($(forum)[0].style.display == "none" || $(forum)[0].style.display == "") {
    $(forum).show( "blind", { direction: "up" }, 'slow');
  } else {
    $(forum).hide( "blind", { direction: "up" }, 'slow');
  }
};

toggleNewGroup = function(e) {
  if ($('#new-group-forum')[0].style.display == "none" || $('#new-group-forum')[0].style.display == "") {
    $('#new-group-forum').show( "slide", { direction: "left" }, 'slow');
  } else {
    $('#new-group-forum').hide( "slide", { direction: "left" }, 'slow');
  }
};

createNewGroup = function(e) {
  var forum_id = this.dataset.forumId
  if ($('#new-group-title').val().length < 1) {
    $('#new-group-title').parent().addClass('field_with_errors');
  } else {
    return $.ajax({
      type: 'POST',
      url: '/groupings',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: {
        grouping: {
          title: $('#new-group-title').val(),
          forum_id: forum_id
        },
        ajax: true
      },
      success: function(data, textStatus) {
        $('#new-group-title').val("");

        $('#main-table tr.add-new-above:last ').before(data);
        $('.remove-grouping').unbind("click");
        $('.remove-grouping').on("click", removeGrouping);
        $('.create-new-forum').unbind("click");
        $('.create-new-forum').on("click", createNewForum);
        $('.new-forum-toggle').unbind("click");
        return $('.new-forum-toggle').on("click", toggleNewForum);
      }
    });
  }
};
createNewTopic = function(e) {
  var passes = false;
  if ($('#topic_title').val().length < 1) {
    $('#topic_title').parent().addClass('field_with_errors');
  } else {
    passes = true;
  }
  if (passes == true) {
    return $.ajax({
      type: 'POST',
      url: '/topics',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: {
        topic: {
          title: $('#topic_title').val(),
          locked: $('#topic_locked').is(":checked"),
          sticky: $('#topic_sticky').is(":checked"),
          body: $('#topic_body').val(),
          forum_id: $('#forum_id').val()
        },
        ajax: true
      },
      success: function(data, textStatus) {
        $('.update-tf').unbind("click");
        $('#topic_title').val("");
        $('#topic_locked').attr("checked", false);
        $('#topic_sticky').attr("checked", false);
        $('#topic_body').val("");
        $("#new-topic-forum").hide( "blind", { direction: "up" }, 'slow');
        $('#topic-table').html(data);
        return $('.update-tf').on("click", updateTfDetails);
      }
    });
  }
}

toggleNewTopic = function(e) {
  if ($("#new-topic-forum")[0].style.display == "none" || $("#new-topic-forum")[0].style.display == "") {
    $("#new-topic-forum").show( "blind", { direction: "up" }, 'slow');
  } else {
    $("#new-topic-forum").hide( "blind", { direction: "up" }, 'slow');
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
  console.log("hi");
  var temp = this.id.split("-");
  var game_list = "#game-instances-form-group-"+temp[temp.length-1];
  if (id == "-2") {
    $(game_list).html('');
    $(game_list)[0].disabled = true;
  } else {
    $(game_list)[0].disabled = false;
    $.ajax({
      type: "GET",
      url: "/games/" + id +"/get_game_instances?parent_id="+temp[temp.length-2]+"&grouping_id="+temp[temp.length-1],
      success: function(data, textStatus, jqXHR) {
        return $(game_list).html(data);
      }
    });
  }
};

newGrouping = function(e) {
  if (this.value == "-1") {
    $('#new-grouping-forum')[0].disabled = false;
  } else {   
    $('#forum_new_grouping').val("");
    $('#new-grouping-forum')[0].disabled = true;
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
    strconfirm = confirm("Are you sure you want to delete? This can not be undone!");
  }
  if ((action == 'destroy' && strconfirm == true) || action != 'destroy') {
    return $.ajax({
      type: "PATCH",
      url: "/" + item + "s/" + id,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: {
        _method: "PUT",
        id: id,
        what: action,
        authenticity_token: session
      },
      success: function(data, textStatus, jqXHR) {
        if (action == 'stick' || action == 'un_stick') {
          $('#topic-table').html(data);
        } else {
          $("#" + item + "-" + id + "-update-section").html(data);
        }
        $('.update-tf').unbind("click");
        return $('.update-tf').on("click", updateTfDetails);
      }
    });
  }
  return this.parentElement.parentElement.parentElement.className = 'btn-group'
};