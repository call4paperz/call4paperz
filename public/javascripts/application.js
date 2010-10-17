$(function(){
  $('.datepicker').datepicker({
      onClose: function() {
          if($(this).closest('form').validate !== undefined) {
            $(this).closest('form').validate().element($(this));
          }
      }
  });
});
