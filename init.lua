local add_js, l, render_attributes = add_js, l, render_attributes
local json, config = require 'dkjson', settings.social

module 'ophal.modules.social'

local js_added

function get_social_button(widget, url, text, attributes)
  if attributes == nil then
    attributes = {}
  end

  if not js_added then
    add_js 'misc/jquery.js'
    add_js 'modules/social/socialite.min.js'
    add_js 'modules/social/social.js'

    if config then
      add_js('social', {type = 'inline', content = 'Ophal = ' .. json.encode({settings = {social = config}})})
    end

    js_added = true
  end

  attributes.class = 'socialite ' .. widget
  attributes.rel = 'nofollow'
  attributes['data-url'] = url
  attributes['data-text'] = text

  return ('<a href="https://twitter.com/share" %s ></a>'):format(render_attributes(attributes))
end
