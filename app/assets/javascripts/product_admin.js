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
});
