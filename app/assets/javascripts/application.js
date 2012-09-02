//= require jquery
//= require jquery_ujs
//= require jquery.Jcrop.min
//= require jquery-ui.min
//= require jquery.tweet.min
//= require jquery.validate.min
//= require ajax
//= require call4paperz
//= require_self

$(function(){
  $('.datepicker').datepicker({
      onClose: function() {
          if($(this).closest('form').validate !== undefined) {
            $(this).closest('form').validate().element($(this));
          }
      }
  });
});

var HandleKeycount = function() {

  this.limit = 0;
  this.hint = null;


  var handler = this;

  this.update = function() {
      var availableChars = handler.limit - $(this).val().length;

      var counter = $(handler.hint).text(availableChars + " characters remaining");
      if(availableChars < 0) {
        $(counter).addClass('red_form');
      } else {
        $(counter).removeClass('red_form');
      }
  };

  this.init = function(limit, hint, container) {
      this.limit = limit;
      this.hint = hint;
      this.update.call(hint);

      container.keydown(this.update).blur(this.update);
  };
};

