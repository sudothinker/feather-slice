require File.dirname(__FILE__) + '/../spec_helper'

describe "FeatherSlice::Main (controller)" do
  
  # Feel free to remove the specs below
  
  before :all do
    Merb::Router.prepare { |r| r.add_slice(:FeatherSlice) } if standalone?
  end
  
  after :all do
    Merb::Router.reset! if standalone?
  end
  
  it "should have access to the slice module" do
    controller = dispatch_to(FeatherSlice::Main, :index)
    controller.slice.should == FeatherSlice
    controller.slice.should == FeatherSlice::Main.slice
  end
  
  it "should have an index action" do
    controller = dispatch_to(FeatherSlice::Main, :index)
    controller.status.should == 200
    controller.body.should contain('FeatherSlice')
  end
  
  it "should work with the default route" do
    controller = get("/feather-slice/main/index")
    controller.should be_kind_of(FeatherSlice::Main)
    controller.action_name.should == 'index'
  end
  
  it "should work with the example named route" do
    controller = get("/feather-slice/index.html")
    controller.should be_kind_of(FeatherSlice::Main)
    controller.action_name.should == 'index'
  end
  
  it "should have routes in FeatherSlice.routes" do
    FeatherSlice.routes.should_not be_empty
  end
  
  it "should have a slice_url helper method for slice-specific routes" do
    controller = dispatch_to(FeatherSlice::Main, 'index')
    controller.slice_url(:action => 'show', :format => 'html').should == "/feather-slice/main/show.html"
    controller.slice_url(:feather_slice_index, :format => 'html').should == "/feather-slice/index.html"
  end
  
  it "should have helper methods for dealing with public paths" do
    controller = dispatch_to(FeatherSlice::Main, :index)
    controller.public_path_for(:image).should == "/slices/feather-slice/images"
    controller.public_path_for(:javascript).should == "/slices/feather-slice/javascripts"
    controller.public_path_for(:stylesheet).should == "/slices/feather-slice/stylesheets"
  end
  
  it "should have a slice-specific _template_root" do
    FeatherSlice::Main._template_root.should == FeatherSlice.dir_for(:view)
    FeatherSlice::Main._template_root.should == FeatherSlice::Application._template_root
  end

end