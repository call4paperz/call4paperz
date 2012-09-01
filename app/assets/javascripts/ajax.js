var FetchWithAjax = function ($) {
    return {
        fetch: function(params) {
            var settings = $.extend({
                url:        '',
                spinner:    undefined,
                dataType:   'html',
                cache:      false,
                success:    function() {},
                beforeSend: function() {
                    $(settings.spinner).show();
                }
            }, params);

            $.ajax({
                beforeSend: settings.beforeSend,
                url: settings.url,
                dataType: settings.dataType,
                success: settings.success,
                complete: function() {
                    $(settings.spinner).hide();
                }
            });
        }
    };
}(jQuery);
