// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery
//= require materialize-sprockets
//= require_tree .

$(document).ready(function() {
  chooseCharacter();
  // sellItem();
});

function sellItem(id){
    $(id).toggleClass('hide');
    $(id).toggleClass('show');
}

function buyItem(id){
    $(id).toggleClass('hide');
    $(id).toggleClass('show');
}

function itemExchange(){
  var sold_items = $("ul.character_trades").find(".show")
  var bought_items = $("ul.store_trades").find(".show")

  item_classes = [[],[]]
  // _.map
  $.each(sold_items, function(index, sold_item){
      item_classes[0].push(this.className)
  })
  $.each(bought_items, function(index, sold_item){
      item_classes[1].push(this.className)
  })

  data = {"classes": item_classes}
  $.post("/trades", data)
}

function chooseCharacter(){
  var $avatars = $('.avatar');
  $avatars.each(function(index, avatar){
    var $avatar = $(avatar);
    $('.side-'+(index+1)).on('click',function(){
      $('#introduction').addClass('hide')
      $avatar.removeClass('hide');
      $avatars.each(function(index2, avatar2){
        var $avatar2 = $(avatar2);
        if (index !== index2 ){
          $avatar2.addClass('hide');
        };
      });
    });
  });
}
//
//
// $('.side-'+index).on('click', function(){
//   $('.profile-2').addClass('hide');
//   $('.profile-1').removeClass('hide');
//
//
// });
//
//
// var $developers = $('.developer')
//
// $('#developer_filter_name').on('keyup', function () {
//     var currentName = this.value.toUpperCase();
//     $developers.each(function (index, developer) {
//       var $developer = $(developer);
//       if ($developer.data('name').indexOf(currentName) >= 0) {
//         $developer.show();
//       }
//       else {
//         $developer.hide();
//       }
//     });
//   });
