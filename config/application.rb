require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # view
    config.action_view.form_with_generates_remote_forms = true

    # generator 設定
    config.generators do |g|
      g.assets false
      g.helper false
      # helperファイルの設定
      g.helper = false
      # testファイルの設定
      g.test_framework = false
      # ルーティングの記述の設定
      g.skip_routes = true

      g.test_framework :rspec,
                       fixtures: false, # テストDBにレコードを作るfixtureの作成をスキップ(FactoryBotを使用するため)
                       view_specs: false, # ビューファイル用のスペックを作成しない
                       helper_specs: false, # ヘルパーファイル用のスペックを作成しない
                       routing_specs: false # routes.rb用のスペックファイル作成しない
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # デフォルトのlocaleを日本語(:ja)にする
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  end
end
