require File.dirname(__FILE__) + '/spec_helper'

describe "FeatherSlice (module)" do
  
  it "should have proper specs"
  
  # Feel free to remove the specs below
  
  before :all do
    Merb::Router.prepare { |r| r.add_slice(:FeatherSlice) } if standalone?
  end
  
  after :all do
    Merb::Router.reset! if standalone?
  end
  
  it "should be registered in Merb::Slices.slices" do
    Merb::Slices.slices.should include(FeatherSlice)
  end
  
  it "should be registered in Merb::Slices.paths" do
    Merb::Slices.paths[FeatherSlice.name].should == current_slice_root
  end
  
  it "should have an :identifier property" do
    FeatherSlice.identifier.should == "feather-slice"
  end
  
  it "should have an :identifier_sym property" do
    FeatherSlice.identifier_sym.should == :feather_slice
  end
  
  it "should have a :root property" do
    FeatherSlice.root.should == Merb::Slices.paths[FeatherSlice.name]
    FeatherSlice.root_path('app').should == current_slice_root / 'app'
  end
  
  it "should have a :file property" do
    FeatherSlice.file.should == current_slice_root / 'lib' / 'feather-slice.rb'
  end
  
  it "should have metadata properties" do
    FeatherSlice.description.should == "FeatherSlice is a chunky Merb slice!"
    FeatherSlice.version.should == "0.0.1"
    FeatherSlice.author.should == "YOUR NAME"
  end
  
  it "should have :routes and :named_routes properties" do
    FeatherSlice.routes.should_not be_empty
    FeatherSlice.named_routes[:feather_slice_index].should be_kind_of(Merb::Router::Route)
  end

  it "should have an url helper method for slice-specific routes" do
    FeatherSlice.url(:controller => 'main', :action => 'show', :format => 'html').should == "/feather-slice/main/show.html"
    FeatherSlice.url(:feather_slice_index, :format => 'html').should == "/feather-slice/index.html"
  end
  
  it "should have a config property (Hash)" do
    FeatherSlice.config.should be_kind_of(Hash)
  end
  
  it "should have bracket accessors as shortcuts to the config" do
    FeatherSlice[:foo] = 'bar'
    FeatherSlice[:foo].should == 'bar'
    FeatherSlice[:foo].should == FeatherSlice.config[:foo]
  end
  
  it "should have a :layout config option set" do
    FeatherSlice.config[:layout].should == :feather_slice
  end
  
  it "should have a dir_for method" do
    app_path = FeatherSlice.dir_for(:application)
    app_path.should == current_slice_root / 'app'
    [:view, :model, :controller, :helper, :mailer, :part].each do |type|
      FeatherSlice.dir_for(type).should == app_path / "#{type}s"
    end
    public_path = FeatherSlice.dir_for(:public)
    public_path.should == current_slice_root / 'public'
    [:stylesheet, :javascript, :image].each do |type|
      FeatherSlice.dir_for(type).should == public_path / "#{type}s"
    end
  end
  
  it "should have a app_dir_for method" do
    root_path = FeatherSlice.app_dir_for(:root)
    root_path.should == Merb.root / 'slices' / 'feather-slice'
    app_path = FeatherSlice.app_dir_for(:application)
    app_path.should == root_path / 'app'
    [:view, :model, :controller, :helper, :mailer, :part].each do |type|
      FeatherSlice.app_dir_for(type).should == app_path / "#{type}s"
    end
    public_path = FeatherSlice.app_dir_for(:public)
    public_path.should == Merb.dir_for(:public) / 'slices' / 'feather-slice'
    [:stylesheet, :javascript, :image].each do |type|
      FeatherSlice.app_dir_for(type).should == public_path / "#{type}s"
    end
  end
  
  it "should have a public_dir_for method" do
    public_path = FeatherSlice.public_dir_for(:public)
    public_path.should == '/slices' / 'feather-slice'
    [:stylesheet, :javascript, :image].each do |type|
      FeatherSlice.public_dir_for(type).should == public_path / "#{type}s"
    end
  end
  
  it "should have a public_path_for method" do
    public_path = FeatherSlice.public_dir_for(:public)
    FeatherSlice.public_path_for("path", "to", "file").should == public_path / "path" / "to" / "file"
    [:stylesheet, :javascript, :image].each do |type|
      FeatherSlice.public_path_for(type, "path", "to", "file").should == public_path / "#{type}s" / "path" / "to" / "file"
    end
  end
  
  it "should have a app_path_for method" do
    FeatherSlice.app_path_for("path", "to", "file").should == FeatherSlice.app_dir_for(:root) / "path" / "to" / "file"
    FeatherSlice.app_path_for(:controller, "path", "to", "file").should == FeatherSlice.app_dir_for(:controller) / "path" / "to" / "file"
  end
  
  it "should have a slice_path_for method" do
    FeatherSlice.slice_path_for("path", "to", "file").should == FeatherSlice.dir_for(:root) / "path" / "to" / "file"
    FeatherSlice.slice_path_for(:controller, "path", "to", "file").should == FeatherSlice.dir_for(:controller) / "path" / "to" / "file"
  end
  
  it "should keep a list of path component types to use when copying files" do
    (FeatherSlice.mirrored_components & FeatherSlice.slice_paths.keys).length.should == FeatherSlice.mirrored_components.length
  end
  
end