config.load_autoconfig(False)  # Otomatik yapılandırmayı kapat
c.url.searchengines = {
    'DEFAULT': 'https://www.google.com/search?q={}'
}
c.url.start_pages = "file:///home/ozu/GitHub/ozu-web/index.html"
c.content.javascript.clipboard = 'access'
config.bind('jk', 'mode-leave', mode='insert')
