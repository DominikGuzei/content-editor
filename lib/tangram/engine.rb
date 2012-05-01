module Tangram
  class Engine < ::Rails::Engine
    initializer 'tangram.load_static_assets' do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/vendor"
    end
  end
end