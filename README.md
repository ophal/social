Ophal social module
===================

This module is backed by Socialite.js https://github.com/dbushell/Socialite

### Usage example

Render a twitter button for Ophal.org:

```lua
get_social_button(
  'twitter-share',
  'http://ophal.org',
  'I <3 The Ophal Project',
  {['data-count'] = 'vertical'}
)
```

### Configuration settings

```lua
settings.social = {
  -- List of entities that will get the social buttons on
  -- entity_render().
  entities = {
    content = true,
  },

  -- (Optional) Configure the language
  facebook = {lang = 'es_LA'},
  twitter = {lang = 'es'},
  googleplus = {lang = 'es-419'},
}
```

NOTE: You will need grab the language codes from the corresponding social
network documentation pages.
