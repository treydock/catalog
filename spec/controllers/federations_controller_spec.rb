require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe FederationsController do

  def mock_federation(stubs={})
    @mock_federation ||= mock_model(Federation, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all federations as @federations" do
      Federation.stub(:all) { [mock_federation] }
      get :index
      assigns(:federations).should eq([mock_federation])
    end
  end

  describe "GET show" do
    it "assigns the requested federation as @federation" do
      Federation.stub(:find).with("37") { mock_federation }
      get :show, :id => "37"
      assigns(:federation).should be(mock_federation)
    end
  end

  describe "GET new" do
    it "assigns a new federation as @federation" do
      Federation.stub(:new) { mock_federation }
      get :new
      assigns(:federation).should be(mock_federation)
    end
  end

  describe "GET edit" do
    it "assigns the requested federation as @federation" do
      Federation.stub(:find).with("37") { mock_federation }
      get :edit, :id => "37"
      assigns(:federation).should be(mock_federation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created federation as @federation" do
        Federation.stub(:new).with({'these' => 'params'}) { mock_federation(:save => true) }
        post :create, :federation => {'these' => 'params'}
        assigns(:federation).should be(mock_federation)
      end

      it "redirects to the created federation" do
        Federation.stub(:new) { mock_federation(:save => true) }
        post :create, :federation => {}
        response.should redirect_to(federation_url(mock_federation))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved federation as @federation" do
        Federation.stub(:new).with({'these' => 'params'}) { mock_federation(:save => false) }
        post :create, :federation => {'these' => 'params'}
        assigns(:federation).should be(mock_federation)
      end

      it "re-renders the 'new' template" do
        Federation.stub(:new) { mock_federation(:save => false) }
        post :create, :federation => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested federation" do
        Federation.stub(:find).with("37") { mock_federation }
        mock_federation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :federation => {'these' => 'params'}
      end

      it "assigns the requested federation as @federation" do
        Federation.stub(:find) { mock_federation(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:federation).should be(mock_federation)
      end

      it "redirects to the federation" do
        Federation.stub(:find) { mock_federation(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(federation_url(mock_federation))
      end
    end

    describe "with invalid params" do
      it "assigns the federation as @federation" do
        Federation.stub(:find) { mock_federation(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:federation).should be(mock_federation)
      end

      it "re-renders the 'edit' template" do
        Federation.stub(:find) { mock_federation(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested federation" do
      Federation.stub(:find).with("37") { mock_federation }
      mock_federation.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the federations list" do
      Federation.stub(:find) { mock_federation }
      delete :destroy, :id => "1"
      response.should redirect_to(federations_url)
    end
  end

end
