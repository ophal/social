local _M = {
}
ophal.modules.social = _M

local config = settings.social
local add_js, l, render_attributes, url = add_js, l, render_attributes, url
local json, config, tconcat = require 'dkjson', settings.social, table.concat
local theme, add_css = theme, add_css

local debug = debug

local js_added
local css_added

--[[
  Implements hook entity_render().
]]
function _M.entity_render(parent)
  if not config.entities[parent.type] then return end
  parent.social_links = tconcat{
    '<div id="social">',
    theme{'item_list', list = {
      _M.get_social_button('googleplus-one', url(('%s/%s'):format(parent.type, parent.id), {absolute = true}), '', {['data-size'] = 'tall'}),
      _M.get_social_button('twitter-share', url(('%s/%s'):format(parent.type, parent.id), {absolute = true}), parent.title, {['data-related'] = config.twitter['data-related'], ['data-count'] = 'vertical'}),
      _M.get_social_button('facebook-like', '#', '', {['data-layout'] = 'box_count', ['data-width'] = 60, ['data-show-faces'] = 'false', ['data-send'] = 'false'}),
    }},
    '</div>',
  }
end

do
  local share_urls = {
    ['googleplus-one'] = {
      url = 'https://plus.google.com/share?url=%s',
      text = '<span class="vhidden">Share on Google+</span>',
    },
    ['twitter-share'] = {
      url = 'http://twitter.com/share?url=%s',
      text = '<span class="vhidden">Share on Twitter</span>',
    },
    ['facebook-like'] = {
      url = 'http://www.facebook.com/sharer.php?u=%s&t=Socialite.js',
      text = '<span class="vhidden">Share on Facebook</span>',
    },
    ['linkedin-share'] = {
      url = 'http://www.linkedin.com/shareArticle?mini=true&url=%s&title=Socialite.js',
      text = '<span class="vhidden">Share on LinkedIn</span>',
    },
  }
  function get_nojs_data(widget_type)
    return share_urls[widget_type] or {url = ''}
  end
end

function _M.get_social_button(widget_type, url, text, attributes)
  local nojs_data

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

  nojs_data = get_nojs_data(widget_type)

  attributes.class = 'socialite ' .. widget_type
  attributes.rel = 'nofollow'
  attributes['data-url'] = url
  attributes['data-text'] = text
  attributes.href = nojs_data.url:format(url)

  return ('<a %s>%s</a>'):format(render_attributes(attributes), nojs_data.text)
end

return _M
