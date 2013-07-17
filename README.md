Ophal social module
===================

This module is backed by Socialite.js https://github.com/dbushell/Socialite

###Usage example

Render a twitter button for Ophal.org:

get_social_button('twitter-share', 'http://ophal.org', 'I <3 The Ophal Project', {['data-count'] = 'vertical'}),


###(Optional) configure the language

settings.social = {
  facebook = {lang = 'es_LA'},
  twitter = {lang = 'es'},
  googleplus = {lang = 'es-419'},
}

NOTE: You will need check language codes on the corresponding network docs.
