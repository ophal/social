local config = settings.social
local add_js, l, render_attributes, url = add_js, l, render_attributes, url
local json, config, tconcat = require 'dkjson', settings.social, table.concat
local theme, add_css = theme, add_css

local debug = debug

module 'ophal.modules.social'

local js_added
local css_added

--[[
  Implements hook entity_render().
]]
function entity_render(parent)
  if not config.entities[parent.type] then return end
  parent.social_links = tconcat{
    '<div id="social">',
    theme{'item_list', list = {
      get_social_button('googleplus-one', url(('%s/%s'):format(parent.type, parent.id), {absolute = true}), '', {['data-size'] = 'tall'}),
      get_social_button('twitter-share', url(('%s/%s'):format(parent.type, parent.id), {absolute = true}), parent.title, {['data-related'] = config.twitter['data-related'], ['data-count'] = 'vertical'}),
      get_social_button('facebook-like', '#', '', {['data-layout'] = 'box_count', ['data-width'] = 60, ['data-show-faces'] = 'false', ['data-send'] = 'false'}),
    }},
    '</div>',
  }
end

function get_social_button(widget, url, text, attributes)
  if attributes == nil then
    attributes = {}
  end

  if not js_added then
    add_js 'modules/social/socialite.min.js'
    add_js 'modules/social/social.js'

    if config then
      add_js{type = 'settings', namespace = 'social', config}
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

  return ('<div %s></div>'):format(render_attributes(attributes))
end
