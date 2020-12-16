Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:4200", "https://thawing-river-95379.herokuapp.com", "http://www.kevinroe.me", "http://www.kevinroe.me"
    resource "*", 
      headers: :any, 
      methods: [:get, :post, :put, :patch, :delete, :options, :head], 
      credentials: true
  end
end