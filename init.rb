require_dependency 'shoo_hook_listener'
Redmine::Plugin.register :shoo do
  name 'Shoo plugin'
  author 'rghost'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'https://github.com/miarhost/shoo/README.git'
  settings default: { public_key: '', member_token: '', api_secret: '', webhook_url: '' }, partial: 'settings/shoo/config'
end
