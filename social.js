(function($) {

$(document).ready(function() {
  Socialite.setup({
    facebook: {
      lang: Ophal.settings.social.facebook.lang,
      appId: null
    },
    twitter: {
      lang: Ophal.settings.social.twitter.lang,
    },
    googleplus: {
      lang: Ophal.settings.social.googleplus.lang
    },
  });
  Socialite.load();
});

})(jQuery);