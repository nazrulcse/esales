//var bxsliderArray = [];
//var bxDynamicCarouselArray = [];
//
//var sliderSettings = {
//    mode: 'fade',
//    auto: true,
//    pager: false
//};
//
//var carouselSettings = {
//    controls: true,
//    maxSlides: document.body.clientWidth >= BREAK.SM ? 3 : 1,
//    minSlides: 1,
//    moveSlides: document.body.clientWidth >= BREAK.SM ? 2 : 1,
//    pager: false,
//    slideMargin: 0,
//    nextText: '',
//    prevText: ''
//};
//
//// FlexSlider custom params
//var flexCarouselSettings = {
//    animation: "slide",
//    controlNav: false,
//    animationLoop: false,
//    slideshow: false,
//    itemWidth: 78,
//    itemMargin: 20
//};
//
//jQuery(function ($) {
//
//    var bxSlidersCustomer = {
//        customSlider: function (selector, slider_settings) {
//            var self = this;
//            $(selector).each(function () {
//                var slider = $(this);
//                slider.bxSlider($.extend({}, sliderSettings, slider_settings));
//                self.addSliderToArray(slider);
//            });
//        },
//        customCarousel: function (selector, carousel_settings, type) {
//            var self = this;
//            $(selector).each(function () {
//                var slider = $(this);
//                slider.bxSlider($.extend({}, carouselSettings, carousel_settings));
//                if (type == 'dynamic') {
//                    self.addCarouselToArray(slider, carousel_settings);
//                } else {
//                    self.addSliderToArray(slider);
//                }
//            });
//
//        },
//        addSliderToArray: function (sliderSelector) {
//            bxsliderArray.push(sliderSelector);
//        },
//        addCarouselToArray: function (sliderSelector, slider_settings) {
//            var CurrentSlider = {
//                slider: sliderSelector,
//                settings: slider_settings
//            };
//            bxDynamicCarouselArray.push(CurrentSlider);
//            bxsliderArray.push(sliderSelector);
//        }
//    };
//
//    bxSlidersCustomer.customSlider($('.j-slider-primary'), {
//        controls: false,
//        pager: true
//    });
//
//    bxSlidersCustomer.customCarousel($('.j-carousel-primary'), {
//        controls: false,
//        slideMargin: 30,
//        slideWidth: 568,
//        pager: true
//    });
//
//    bxSlidersCustomer.customCarousel($('.j-carousel-secondary'), {
//        slideMargin: 28,
//        slideWidth: 370
//    }, 'dynamic');
//
//    bxSlidersCustomer.customCarousel($('.j-carousel-sidebar'), {
//        slideMargin: 28,
//        slideWidth: 270
//    }, 'dynamic');
//
//    bxSlidersCustomer.customCarousel($('.j-logo-slider:visible'), {
//        auto: true,
//        maxSlides: 5,
//        moveSlides: 3,
//        slideWidth: 208
//    });
//
//    bxSlidersCustomer.customCarousel($('.j-slider-images'), {
//        maxSlides: 1,
//        moveSlides: 1
//    });
//
//    bxSlidersCustomer.customCarousel($('.j-slider-in-carousel'), {
//        maxSlides: 1,
//        moveSlides: 1,
//        pager: true
//    });
//
//    $(window).on('resize', function () {
//        for (var i = 0, l = bxDynamicCarouselArray.length; i < l; i++) {
//            if (bxDynamicCarouselArray[i].slider.reloadSlider) {
//
//                var slider = bxDynamicCarouselArray[i].slider,
//                    settings = bxDynamicCarouselArray[i].settings;
//
//                slider.reloadSlider($.extend({}, carouselSettings, settings, {
//                    maxSlides: document.body.clientWidth >= BREAK.SM ? 3 : 1,
//                    moveSlides: document.body.clientWidth >= BREAK.SM ? 2 : 1
//                }));
//            }
//        }
//    });
//
//    var maxSlidesCarousel = 3;
//    for (var i = 0, l = bxsliderArray.length; i < l; i++) {
//        if (bxsliderArray[i].getSlideCount) {
//            if (bxsliderArray[i].getSlideCount() < maxSlidesCarousel) {
//                bxsliderArray[i].parents('.bx-wrapper').addClass('is-full-l');
//            }
//        }
//    }
//
//    // Multiple flexSlider with thumbnail slider
//    var $carousel = $('.flexslider-thumbnail'); // Img pagination
//    var $sliderBig = $('.flexslider-zoom'); // Big image slider
//
//    $carousel.each(function (index) {
//
//        if ($carousel.eq(index).length) {
//            // SM version
//            if ($(this).hasClass('carousel-sm')) {
//                $(this).flexslider($.extend({}, flexCarouselSettings, {
//                    asNavFor: '.flexslider-zoom:eq(' + index + ')'
//                }));
//            }
//            // MD version
//            else if ($(this).hasClass('carousel-md')) {
//                $(this).flexslider($.extend({}, flexCarouselSettings, {
//                    itemWidth: 107,
//                    asNavFor: '.flexslider-zoom:eq(' + index + ')'
//                }));
//            }
//        }
//
//        if ($sliderBig.eq(index).length) {
//            $sliderBig.eq(index).flexslider({
//                animation: "slide",
//                controlNav: false,
//                animationLoop: false,
//                slideshow: true,
//                sync: '.flexslider-thumbnail:eq(' + index + ')',
//                after: function (slider) {
//                    /* auto-restart player if paused after action */
//                    if (!slider.playing) {
//                        slider.play();
//                    }
//                }
//            })
//        }
//    });
//
//    function imgPreload($collection, $elEvent) {
//        var colLenght = $collection.length;
//        var counter = 0;
//        $collection.each(function () {
//            var src = $(this).attr('src');
//            var img = new Image();
//            img.src = src;
//            img.onload = function () {
//                counter++;
//                if (counter >= colLenght) {
//                    $elEvent.trigger('imgsLoaded');
//                    return false;
//                }
//            };
//        });
//    }
//
//    if ($('.slider-carousel-roundabout').length) {
//        var $carouselData = $('.carousel-roundabout-data');
//        imgPreload($('.roundabout-slide').find('img'), $('.slider-carousel-roundabout'));
//        var curSize;
//        $('.slider-carousel-roundabout').on('imgsLoaded', function () {
//            $carouselData.css('display', 'none');
//            $carouselData.clone()
//                .prependTo('.b-carousel-roundabout-wrap')
//                .removeClass('carousel-roundabout-data')
//                .addClass('b-carousel-roundabout')
//                .css('display', 'block');
//            $(window).on('resize', function () {
//                windowSize();
//            });
//            reloadSlider();
//        });
//
//        function reloadSlider() {
//            $('.b-carousel-roundabout').remove();
//            $carouselData.clone()
//                .prependTo('.b-carousel-roundabout-wrap')
//                .removeClass('carousel-roundabout-data')
//                .addClass('b-carousel-roundabout')
//                .css('display', 'block');
//            carouselInit();
//        }
//
//        function windowSize() {
//            if ($(window).width() > 768 && curSize != 'desktop') {
//                reloadSlider();
//                curSize = 'desktop';
//            }
//            else if ($(window).width() > 480 && $(window).width() <= 768 && curSize != 'tablet') {
//                reloadSlider();
//                curSize = 'tablet';
//            } else if ($(window).width() <= 480 && curSize != 'mobile') {
//                reloadSlider();
//                curSize = 'mobile';
//            }
//        }
//
//        function carouselInit() {
//            setTimeout(function () {
//                var $carou = $('.b-carousel-roundabout');
//                $carou.roundabout({
//                    childSelector: ".roundabout-slide",
//                    minOpacity: 1,
//                    autoplay: true,
//                    autoplayDuration: 4166,
//                    autoplayPauseOnHover: true,
//                    tilt: 5,
//                    minScale: 0.1,
//                    reflect: false
//                });
//                $carou.roundabout('animateToNextChild');
//            }, 50);
//        }
//
//    }
//});
