class BookmarkDecorator < Draper::Decorator
  delegate_all

  # タイトルの変換
  def edit_title
    title = object.title.force_encoding('UTF-8')
    max_length = 19

    concat_object(title, max_length)
  end

  # 概要の変換
  def edit_description
    description = object.description.force_encoding('UTF-8')
    max_length = 20

    concat_object(description, max_length)
  end

  private

  # 文字列加工処理
  def concat_object(target_object, max_length)
    length = 0
    result = ''

    target_object.each_char do |char|
      char_length = char.ascii_only? ? 1 : 2
      break if length + char_length > max_length

      result += char
      length += char_length
    end

    result += '...' if result.length < target_object.length
    result
  end
end
