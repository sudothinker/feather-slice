if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  load_dependency 'merb-slices'
  Merb::Plugins.add_rakefiles "feather-slice/merbtasks", "feather-slice/slicetasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :feather_slice
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:feather_slice][:layout] ||= :feather_slice
  
  # All Slice code is expected to be namespaced inside a module
  module FeatherSlice
    
    # Slice metadata
    self.description = "feather-slice is a slice of the merb blog feather"
    self.version = "0.0.1"
    self.author = "Michael Murray"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(FeatherSlice)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :feather_slice_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      # example of a named route
      scope.match('/index.:format').to(:controller => 'main', :action => 'index').name(:feather_slice_index)
    end
    
  end
  
  # Setup the slice layout for FeatherSlice
  #
  # Use FeatherSlice.push_path and FeatherSlice.push_app_path
  # to set paths to feather-slice-level and app-level paths. Example:
  #
  # FeatherSlice.push_path(:application, FeatherSlice.root)
  # FeatherSlice.push_app_path(:application, Merb.root / 'slices' / 'feather-slice')
  # ...
  #
  # Any component path that hasn't been set will default to FeatherSlice.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  FeatherSlice.setup_default_structure!
  
  # Add dependencies for other FeatherSlice classes below. Example:
  # dependency "feather-slice/other"
  
end