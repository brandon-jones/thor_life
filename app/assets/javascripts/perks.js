var addToCart, packageDetails, perkRowFlash, sortTable;

$(document).ready(function() {
  $('.add-to-cart').on("click", addToCart);
  $('.perk-sort').on("click", sortTable);
  $('.package-details').on("click", packageDetails);
  return $('.perk-row-flash').on("click", perkRowFlash);
});

perkRowFlash = function(e) {
  var perk_id, run;
  perk_id = this.dataset.perkId;
  $('#perk-' + perk_id).addClass('flasher');
  run = function() {
    return $('#perk-' + perk_id).removeClass('flasher');
  };
  return setTimeout(run, 1000);
};

sortTable = function(e) {
  e.stopPropagation();
  e.preventDefault();
  console.log($('#order').val());
  console.log(this.dataset.type);
  return $.ajax({
    type: "GET",
    url: "/perks",
    data: {
      order: $('#order').val(),
      type: this.dataset.type,
      ajax: true
    },
    success: function(data, textStatus) {
      $('#perk-table').html(data);
      $('.add-to-cart').on("click", addToCart);
      return $('.perk-sort').on("click", sortTable);
    },
    error: function(data, textStatus) {
      return alert(data.responseText);
    }
  });
};

addToCart = function(e) {
  var item_id, item_type, session, flash_id;
  e.stopPropagation();
  e.preventDefault();
  item_type = this.getAttribute('data-item-type');
  item_id = this.getAttribute('data-item-id');
  flash_id = "#"+item_type+"-"+item_id
  session = $('#session_key').val();
  $.ajax({
    type: "POST",
    dataType: 'text',
    url: "/add_to_cart",
    data: {
      dataType: 'text',
      item_type: item_type,
      item_id: item_id,
      authenticity_token: session
    },
    success: function(data, textStatus) {
      var run;
      console.log($(flash_id));
      $('.total-price').html(data);

      $(flash_id).addClass('green-flasher');
      run = function() {
        return $(flash_id).removeClass('green-flasher');
      };
      return setTimeout(run, 1000);
    },
    error: function(data, textStatus) {
      return alert(data.responseText);
    }
  });
};

packageDetails = function(e) {
  var details_id;
  console.log(this.getAttribute('data-package-id'));
  details_id = ".package-perks-" + this.getAttribute('data-package-id');
  if ($(details_id)[0].style.display === 'table') {
    return $(details_id).hide(200, 'linear');
  } else {
    return $(details_id).show(200, 'linear');
  }
};