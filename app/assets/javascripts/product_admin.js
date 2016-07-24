$( document ).ready(function() {
    $("#product_product_type").change(function () {
       var product_type = this.value;
        if (product_type == 'service')
        {
            $('.service-input').show();
            $('.products-input').hide();
        }
        else
        {
            $('.service-input').hide();
            $('.products-input').show();
        }
    });
    $('.accept-transaction').click(function() {
        $('#myModal').modal('show');
        var url = $(this).attr("data-url");
        var chanel = $(this).attr("data-chanel");
        $('#collection_selection').attr('action', url);
        $('#collection_selection').attr("enctype","multipart/form-data");
        if (chanel == 'Bkash') {
          $('.bkash').show();
          $('.bank').hide();
        }
        else {
            $('.bkash').hide();
            $('.bank').show();
        }
        $('.close').hide();
    });
});


