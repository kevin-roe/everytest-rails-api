Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins "http://localhost:4200"
      resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    end
  
    allow do
      origins "kevinroe.me"
      resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    end

    allow do
      origins "https://thawing-river-95379.herokuapp.com/"
      resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    end
  end