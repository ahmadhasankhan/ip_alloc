require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  describe "POST #assign" do
    ip_address = "1.2.3.#{rand(255)}"
    device_name = 'device123'

    #TODO: Clean up the codes

    context 'with valid params' do
      it "assigns ip to device" do
        post :assign, :ip => ip_address, :device => device_name, :format => :json
        expect(response).to have_http_status(:created)
        expect(response).to render_template(:assign)
        #expect(response.body).to eq(expected)
      end
    end

    context 'with invalid params' do
      it 're-renders #new form' do
        ip_address = '1.2.256.256'
        post :assign, :ip => ip_address, :device => device_name, :format => :json
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "GET search/:ip" do
    ip_address = "1.2.3.#{rand(255)}"
    device_name = "device#{rand(255)}"
    before(:each) do
      post :assign, :ip => ip_address, :device => device_name, :format => :json
    end

    context 'search the associated devices' do
      it 'is an action' do
        get 'search', :ip => ip_address, :format => :json
        expect(response).to have_http_status(:ok)
      end

      it 'renders the JSON template' do
        get 'search', :ip => ip_address, :format => :json
        expect(response).to render_template(:search)
      end

      it 'has no device associated with this IP' do
        param = "3.3.3.3"
        expected = {
            :error => "NotFound",
            :ip => param
        }.to_json

        get 'search', :ip => param, :format => :json
        expect(response.body).to eq(expected)
      end
    end
  end

end
