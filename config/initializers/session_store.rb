if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_everytest", domain: "thawing-river-95379.herokuapp.com", tld_length: 
else
  Rails.application.config.session_store :cookie_store, key: "_everytest"
end