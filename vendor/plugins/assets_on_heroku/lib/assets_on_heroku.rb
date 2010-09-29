module AssetsOnHeroku
  class Rack < ::Rack::Static
    def initialize(app, options = { :urls => ["/stylesheets", "/javascripts"], :root => "tmp/public" })
      @root = options[:root]
      setup

      super(app, options)
    end
    
    private 

    def setup
      unless defined?(@@setup_finished)
        setup_heroku
        setup_sass
        setup_rails
        setup_merb
      end
      @@setup_finished = true
    end
    
    def setup_heroku
      require "fileutils"
      FileUtils.mkdir_p(@root)
    end
    
    def setup_sass
      if defined?(Sass::Plugin)
        Sass::Plugin.options[:css_location] = "#{@root}/stylesheets"
        Sass::Plugin.options[:template_location] ||= "public/stylesheets/sass" # Make template_location overridable
      end
    end
    
    def setup_rails
      ActionView::Helpers::AssetTagHelper.module_eval %{
        def write_asset_file_contents_with_heroku(broken_joined_asset_path, asset_paths)
          fixed_joined_asset_path = broken_joined_asset_path.sub("public", "#{@root}")
          write_asset_file_contents_without_heroku(fixed_joined_asset_path, asset_paths)
        end
        alias_method_chain :write_asset_file_contents, :heroku
      } if defined?(ActionView::Helpers::AssetTagHelper)
    end
    
    def setup_merb
      # Coming soon!
    end
  end
end
