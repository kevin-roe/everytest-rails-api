if Rails.env == "production"
    Rails.application.config.session_store :cookie_store, key: "_everytest", domain: "https://thawing-river-95379.herokuapp.com/"
  else
    Rails.application.config.session_store :cookie_store, key: "_everytest"
  end