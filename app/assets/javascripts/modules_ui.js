//jQuery(function ($) {
//
//    function setHeightTabs(panel, navTabs) {
//        if ($(window).width() > (BREAK.SM - 1)) {
//            var nav = navTabs.parents('.ui-tabs-nav'),
//                contentHeight = panel.height(),
//                navHeight = nav.height();
//            if (navHeight > contentHeight) {
//                panel.css('min-height', navHeight + 'px');
//            }
//        }
//    }
//
//    var uiWidgets = {
//        init: function () {
//            var me = this;
//            me.tabs();
//            me.accordion();
//            me.tooltip();
//            me.datePicker();
//            me.resize();
//        },
//        tabs: function () {
//            var me = this,
//                activeTab = 1,
//                tabsGroup = [];
//
//            // Jquery UI Tabs
//            $('.j-tabs').tabs();
//
//            // Vertical tabs
//            $('.j-tabs-vertical').each(function () {
//                var vTabs = $(this);
//                if (vTabs.attr('data-active')) {
//                    activeTab = vTabs.attr('data-active');
//                } else {
//                    activeTab = 1;
//                }
//                vTabs.tabs({
//                    active: activeTab - 1,
//                    create: function (event, ui) {
//                        setHeightTabs(ui.panel, ui.tab);
//                    },
//                    beforeActivate: function (event, ui) {
//                        setHeightTabs(ui.newPanel, ui.newTab);
//                    }
//                }).addClass("ui-tabs-vertical ui-helper-clearfix");
//                vTabs.find('li').removeClass("ui-corner-top").addClass("ui-corner-left");
//            });
//        },
//        // Jquery UI accordion
//        accordion: function () {
//            $(".j-accordion").accordion({
//                heightStyle: "content",
//                collapsible: true
//            });
//        },
//        // Bootstrap Tooltip
//        tooltip: function () {
//            $('.j-tooltip').tooltip().on('click', function (e) {
//                $(this).tooltip('toggle');
//            });
//        },
//        // Jquery UI Datepicker
//        datePicker: function () {
//            $(".datepicker").datepicker();
//        },
//        resize: function () {
//            $(window).on('resize', function () {
//                if ($(window).width() < (BREAK.SM - 1)) {
//                    $('.j-tabs-vertical .ui-tabs-panel').css('min-height','');
//                }
//            });
//        }
//    };
//    uiWidgets.init();
//});
