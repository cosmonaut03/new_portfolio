module ApplicationHelper
  def autoredirect(url)
    link = tag.a href: url, style: 'display: none', data: { controller: 'autoclick', turbo_cache: false }
    turbo_steram.prepend('body') { link }
  end
end
