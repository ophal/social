local add_js, l, render_attributes, url = add_js, l, render_attributes, url
local json, config, tconcat = require 'dkjson', settings.social, table.concat
local theme, add_css = theme, add_css

local debug = debug

module 'ophal.modules.social'

local js_added
local css_added

function get_social_button(widget, url, text, attributes)
  if attributes == nil then
    attributes = {}
  end

  if not js_added then
    add_js 'libraries/jquery.min.js'
    add_js 'modules/social/socialite.min.js'
    add_js 'modules/social/social.js'

    if config then
      add_js{'social', type = 'inline', content = 'Ophal = ' .. json.encode({settings = {social = config}})}
    end

    js_added = true
  end

  if not css_added then
    add_css 'modules/social/social.css'
    css_added = true
  end

  attributes.class = 'socialite ' .. widget
  attributes.rel = 'nofollow'
  attributes['data-url'] = url
  attributes['data-text'] = text

  return ('<a href="https://twitter.com/share" %s ></a>'):format(render_attributes(attributes))
end
