;(function($) {

   'use strict'

    var headerFixed = function() {
        if ( $('body').hasClass('header-sticky') ) {
            var nav = $('.header');

            if ( nav.size() != 0 ) {
                var offsetTop = $('.header').offset().top,
                    headerHeight = $('.header').height(),
                    injectSpace = $('<div />', { height: headerHeight }).insertAfter(nav);
                    injectSpace.hide();

                $(window).on('load scroll', function(){
                    if ( $(window).scrollTop() > 0 ) {
                        $('.header').addClass('header-fix');
                        injectSpace.show();
                    } else {
                        $('.header').removeClass('header-fix');
                        injectSpace.hide();
                    }
                })
            }
        }
    };



    var portfolioIsotope = function() {
        if ( $().isotope ) {
            var $container = $('.projects-items');
            $container.imagesLoaded(function(){
                $container.isotope({
                    itemSelector: '.projects',
                    transitionDuration: '1s'
                });
            });

            $('.projects-filter li').on('click',function() {

                var selector = $(this).find("a").attr('data-filter');
                $('.projects-filter li').removeClass('active');
                $(this).addClass('active');
                $container.isotope({ filter: selector });
                return false;
            });
        };
    };

   	// Dom Ready
	$(document).on('turbolinks:load', function() {
        if ( matchMedia( 'only screen and (min-width: 991px)' ).matches ) {
            headerFixed();
        }
        portfolioIsotope();
   	});

})(jQuery);
