// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

// jquery3 => jqueryに変更（本番環境にてjscrollが動作しないため）
//= require jquery
//= require jquery.jscroll.min.js
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

// 無限スクロールの処理
$(document).on('turbolinks:load', function() {
  $(window).on('scroll', function() {
      scrollHeight = $(document).height();
      scrollPosition = $(window).height() + $(window).scrollTop();
      // スクロールの位置が下部5%の範囲に来た場合
      if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
        $('.jscroll').jscroll({
          contentSelector: '.scroll-list',
          nextSelector: 'span.next:last a'
        });
      }
  });
});

// TOPに戻るボタン
$(window).scroll(
  function(){
    var now = $(window).scrollTop();
    if(now > 500){
      $("#page-top").fadeIn("slow");
    }else{
      $("#page-top").fadeOut("slow");
    }
  }
);
$("#move-page-top").click(
  function(){
    $("html,body").animate({scrollTop:0},"slow");
  }
);