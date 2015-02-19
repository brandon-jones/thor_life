var showForumDetails, updateForumDetails;

$(document).ready(function() {

  var $tabs=$('.table-draggable')
  $( "tbody.connectedSortable" ).sortable({
          connectWith: ".connectedSortable",
          items: "> tr",
          appendTo: $tabs,
          helper:"clone",
          zIndex: 999990
      })
      .disableSelection()
  ;
  
  var $tab_items = $( ".nav-tabs > li", $tabs ).droppable({
    accept: ".connectedSortable tr",
    hoverClass: "ui-state-hover",
    
    drop: function( event, ui ) {
      console.log('dropped')
      return false;
    }
  });


  $('.forum-groupings').on("change", newGrouping);
  $('.forum-game').on("change", upDateGameInstances);
  return $('.update-tf').on("click", updateTfDetails);
});

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