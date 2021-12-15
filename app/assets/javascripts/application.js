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
      $('#page-top').fadeIn('slow');
    }else{
      $('#page-top').fadeOut('slow');
    }
  }
);
$(function() {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});