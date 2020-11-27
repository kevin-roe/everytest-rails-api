if Rails.env == "production"
    Rails.application.config.session_store :cookie_store, key: "_everytest", domain: "kevinroe.me"
  else
    Rails.application.config.session_store :cookie_store, key: "_everytest"
  end