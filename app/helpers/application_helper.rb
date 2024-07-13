module ApplicationHelper
  def autoredirect(url)
    link = tag.a href: url, style: 'display: none', data: { controller: 'autoclick', turbo_cache: false }
    turbo_steram.prepend('body') { link }
  end

  def default_meta_tags
    {
      site: 'My Dash',
      title: 'My Dash',
      reverse: true,
      charset: 'utf-8',
      description: '視覚的なブックマーク管理',
      keywords: 'ブックマーク,リンク管理,ホーム画面',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :discription,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.jpg'),
        locale: 'ja_JP'
      }
    }
  end
end
