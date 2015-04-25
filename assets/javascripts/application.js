if("undefined"==typeof jQuery)throw new Error("Bootstrap's Javascript requires jQuery");

/**
 * @preserve
 *
 * The module below provides a jQuery function "dropdownHoverOff" which is the reverse of the "dropdownHover" function
 * provided by the Bootstrap Dropdown Hover plugin (http://cameronspear.com/blog/bootstrap-dropdown-on-hover-plugin/).
 *
 * What it does is simply unbind all of the "hover" event handlers that would have been registered by a call to
 * "dropdownHover". So, a call to:
 *
 * $('.dropdown-toggle').dropdownHoverOff();
 *
 * undoes a call to:
 *
 * $('.dropdown-toggle').dropdownHover();
 *
 * and vice versa.
 */
/*;(function ($, window, undefined) {
    $.fn.dropdownHoverOff = function (options) {

        if('ontouchstart' in document) return this;

        return this.each(function () {
            var $this = $(this), $parent = $this.parent();

            $parent.unbind('mouseenter mouseleave');
            $this.unbind('mouseenter mouseleave');

            $parent.find('.dropdown-submenu').each(function (){
                $this.unbind('mouseenter mouseleave');
            });
        });
    };
})(jQuery, window);*/

//
// File upload control javascript handler.
//
// Used to style a standard HTML file upload element as a Bootstrap button. For explanation see:
//
// http://stackoverflow.com/questions/1491743/how-to-set-a-value-for-a-span-using-jquery
//
$(document).ready( function() {
    $(document).on('change', '.btn-file :file', function() {
        var input = $(this),
            numFiles = input.get(0).files ? input.get(0).files.length : 1,
            file = input.val().replace(/\\/g, '/').replace(/.*\//, '');

        input.trigger('fileselect', [numFiles, file]);
    });

    /*enquire.register("screen and (min-width:768px)", function() {
        $('.dropdown-toggle').dropdownHover();
    });

    enquire.register("screen and (max-width:767px)", function() {
        $('.dropdown-toggle').dropdownHoverOff();
    });*/
});

////////////////////// NOT CURRENTLY USED //////////////////////

//function(G,o,O,g,l){G.GoogleAnalyticsObject=O;G[O]||(G[O]=function(){(G[O].q=G[O].q||[]).push(arguments)});G[O].l=+new Date;g=o.createElement('script'),l=o.scripts[0];g.src='//www.google-analytics.com/analytics.js';l.parentNode.insertBefore(g,l)}(this,document,'ga'));
//ga('create','UA-XXXX-Y');
//ga('send','pageview');

//var _gaq = _gaq || [];
////_gaq.push(['_setAccount', 'UA-21072494-1']);
//_gaq.push(['_setAccount', 'UA-XXXX-Y']);    // REPLACE
//_gaq.push(['_setDomainName', '.domain.com']);
//_gaq.push(['_trackPageview']);
//(function() {
//    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
//    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
//    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
//})();

/*var ready = function() {
 //
 }

 $(document).ready(ready);
 $(document).on('page:load', ready);

 $(document).on('page:change', function() {
 //
 });*/
