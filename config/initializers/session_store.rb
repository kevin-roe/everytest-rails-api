if Rails.env == "production"
    Rails.application.config.session_store :cookie_store, key: "_everytest", domain: "still-coast-96203.herokuapp.com"
  else
    Rails.application.config.session_store :cookie_store, key: "_everytest"
  end