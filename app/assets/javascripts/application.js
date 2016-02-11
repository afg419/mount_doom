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
//= require lodash
//= require materialize-sprockets
//= require travelling_game/p5.js
//= require travelling_game/p5.dom.js
//= require travelling_game/entity.js
//= require travelling_game/enemy_melee.js
//= require travelling_game/arrow.js
//= require travelling_game/enemy_ranged.js
//= require travelling_game/fire_ball.js
//= require travelling_game/player.js
//= require travelling_game/obstacle.js
//= require_tree .


$(document).ready(function() {
  chooseCharacter();
});

function sellItem(id){
    $(id).toggleClass('hide');
    $(id).toggleClass('show');
    $('.hide-sell').children().removeClass('mdi-content-add').addClass('mdi-content-clear');
    findSellTotal();
    updateTotal();
}

function findSellTotal(){
  var sold_items = $("ul.character_trades").find(".show")
  items_total = [0]

  $.each(sold_items, function(index, sold_item){
      items_total.push(parseInt($(this).find('.price').text()))
  })
  total = _.sum(items_total);
  $( ".sold_value" ).text( total );
}

function buyItem(id){
    $(id).toggleClass('hide');
    $(id).toggleClass('show');
    $('.hide-buy').children().removeClass('mdi-content-add').addClass('mdi-content-clear');
    findBoughtTotal();
    updateTotal();
}

function findBoughtTotal(){
  var bought_items = $("ul.store_trades").find(".show")
  items_total = [0]
  $.each(bought_items, function(index, bought_item){
      items_total.push(parseInt($(this).find('.price').text()))
  })
  total =  _.sum(items_total);
  $( ".bought_value" ).text( total );
}

function updateTotal(){
  total =  parseInt($('.sold_value').text()) - parseInt($('.bought_value').text())
  $( ".total_value" ).text( total );
}

function itemExchange(id, char_id, character_total, location_slug, store_slug){
  console.log(total)
  console.log(character_total)
  if ((-1 * total) > character_total){
    alert("You don't have enought money!")
    return
  }

  var sold_items = $("ul.character_trades").find(".show")
  var bought_items = $("ul.store_trades").find(".show")

  item_classes = [[],[]]

  $.each(sold_items, function(index, sold_item){
      item_classes[0].push(this.className)
  })
  $.each(bought_items, function(index, sold_item){
      item_classes[1].push(this.className)
  })
  total = parseInt($('.total_value').text())
  data = {"classes": item_classes, "total": total, "store_id": id}

  $.post("/trades", data).success(function(){
     $(location).attr('href', '/characters/' + char_id);
  })
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
