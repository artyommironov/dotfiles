import os

config.load_autoconfig()
config.bind(';', 'set-cmd-text :')
config.bind(',t', 'spawn --userscript translate')
config.bind('ge', 'scroll-to-perc')
config.unbind('G')
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version} Edg/{upstream_browser_version}', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'qute://*/*')

c.auto_save.session = True
c.colors.completion.fg = '#808080'
c.colors.completion.odd.bg = '#202020'
c.colors.completion.even.bg = '#202020'
c.colors.completion.category.bg = '#404040'
c.colors.completion.category.border.top = '#404040'
c.colors.completion.category.border.bottom = '#404040'
c.colors.completion.item.selected.bg = '#202020'
c.colors.completion.item.selected.fg = '#FFFFFF'
c.colors.completion.item.selected.border.top = '#202020'
c.colors.completion.item.selected.border.bottom = '#202020'
c.colors.completion.item.selected.match.fg = '#FF4000'
c.colors.completion.match.fg = '#FF4000'
c.colors.hints.bg = '#C0C000'
c.colors.hints.fg = '#000000'
c.colors.hints.match.fg = '#008040'
c.colors.messages.error.border = '#000000'
c.colors.messages.info.border = '#000000'
c.colors.messages.warning.border = '#000000'
c.colors.statusbar.url.fg = "#808080"
c.colors.statusbar.url.hover.fg = "#0080ff"
c.colors.statusbar.url.success.http.fg = "#C0C000"
c.colors.statusbar.url.success.https.fg = "#00ff80"
c.colors.tabs.bar.bg = '#202020'
c.colors.tabs.odd.bg = '#202020'
c.colors.tabs.odd.fg = '#808080'
c.colors.tabs.even.bg = '#202020'
c.colors.tabs.even.fg = '#808080'
c.colors.tabs.pinned.odd.bg = '#202020'
c.colors.tabs.pinned.odd.fg = '#008040'
c.colors.tabs.pinned.even.bg = '#202020'
c.colors.tabs.pinned.even.fg = '#008040'
c.colors.tabs.pinned.selected.odd.bg = '#202020'
c.colors.tabs.pinned.selected.odd.fg = '#00ff80'
c.colors.tabs.pinned.selected.even.bg = '#202020'
c.colors.tabs.pinned.selected.even.fg = '#00ff80'
c.colors.tabs.selected.odd.bg = '#202020'
c.colors.tabs.selected.odd.fg = '#FFFFFF'
c.colors.tabs.selected.even.bg = '#202020'
c.colors.tabs.selected.even.fg = '#FFFFFF'
# c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = 'dark'
c.editor.command = [os.getenv('TERMINAL'), '--command', 'fish', '--command', 'pass > {file}']
c.fonts.default_size = '14pt'
c.hints.border = 'none'
c.input.insert_mode.auto_load = True
c.tabs.position = 'left'
