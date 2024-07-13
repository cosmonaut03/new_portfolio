module BookmarkMacros
    def open_bookmark_modal(category)
            # ブックマークモーダルを開く
        find("#add-btn-c#{category.id}").hover
        link = find("#new-link-#{category.id}", visible: false)
        page.execute_script("arguments[0].click()", link)
    end

end