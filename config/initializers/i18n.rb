# 利用可能なロケールを設定
I18n.available_locales = [:ja, :en]

# デフォルトロケールを日本語に設定
I18n.default_locale = :ja

# エラーがあった場合の通知設定（オプション）
I18n.exception_handler = ->(exception, locale, key, options) {
  Rails.logger.error "Translation missing: #{locale}.#{key}"
}