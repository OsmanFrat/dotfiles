config.load_autoconfig(False)  # Otomatik yapılandırmayı kapat
c.url.searchengines = {
    'DEFAULT': 'https://www.google.com/search?q={}'
}
c.url.start_pages = "file:///home/ozu/GitHub/ozu-web/index.html"
c.content.javascript.clipboard = 'access'
config.bind('jk', 'mode-leave', mode='insert')


c.content.blocking.method = 'adblock'
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
]
