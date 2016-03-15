source 'https://rubygems.org'
source 'https://rails-assets.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.3.20'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# slack-apiを使うためのgem
gem 'slack-api'
# slackのOOuth用のgem
gem 'omniauth-slack'
# jqueryイベントが発火しなくなる問題を解決するgem
gem 'jquery-turbolinks'
# material-designを使う
gem 'bootstrap-material-design'
gem 'bootstrap3-rails'
# decorators層導入のため
gem 'draper', '~> 1.3'
# vue.js使用のため
gem 'rails-assets-vue'
# markdownをhtml変換するため
gem 'slack_markdown'
# jquery-ui使用のため
gem 'jquery-ui-rails'
# 送信中のアニメーション追加のため
gem 'ladda-rails', :git => 'git://github.com/Promptus/ladda-rails.git'
# ブログレスバー実装のため
gem 'nprogress-rails'
# htmlからmarkdownを生成するため
gem 'html2markdown'
# 日付入力のgem
gem 'momentjs-rails'
gem 'bootstrap3-datetimepicker-rails'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'fluent-logger'

# 絵文字のセット
gem 'gemoji'
# Use Unicorn as the app server
gem 'unicorn'
gem 'whenever', require: false
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # 表示整形関連(ログなど見やすくなる)
  gem 'hirb'         # モデルの出力結果を表形式で表示する
  gem 'hirb-unicode' # hirbの日本語などマルチバイト文字の出力時の出力結果がすれる問題に対応
  gem 'rails-flog', require: 'flog' # HashとSQLのログを見やすく整形
  gem 'better_errors'     # 開発中のエラー画面をリッチにする
  gem 'binding_of_caller' # 開発中のエラー画面にさらに変数の値を表示する
  gem 'awesome_print'     # Rubyオブジェクトに色をつけて表示して見やすくなる
  gem 'quiet_assets'      # ログのassetsを表示しないようにし、ログを見やすくしてくれる

  # テスト関連
  gem "rspec-rails"        # rspec本体
  gem "shoulda-matchers"   # モデルのテストを簡易にかけるmatcherが使える
  gem "factory_girl_rails" # テストデータ作成
  gem "capybara"           # エンドツーエンドテスト
  gem "capybara-webkit"    # エンドツーエンドテスト(javascript含む)
  gem 'launchy'            # capybaraのsave_and_open_pageメソッドの実行時に画面を開いてくれる
  gem "database_cleaner"   # エンドツーエンドテスト時のDBをクリーンにする
  gem "test-queue"         # テストを並列で実行する
  gem 'faker'              # 本物っぽいテストデータの作成
  gem 'faker-japanese'     # 本物っぽいテストデータの作成（日本語対応）))
  # サンプルデータ作成関連
  gem "seed-fu", "~> 2.3"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # pryを使うgem
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'

  # ソース修正時にブラウザ自動ロード
  gem 'guard-livereload', require: false
  # rake-erb コマンドでActiveRecordからER図を作成
  gem 'rails-erd'
  # bin/rspecコマンドを使えるようにする
  gem 'spring-commands-rspec'
  # コーティング規約の自動チェック
  gem 'bullet'


  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

