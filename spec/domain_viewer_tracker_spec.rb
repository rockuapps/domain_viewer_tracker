require 'spec_helper'

describe DomainViewerTracker do
  describe "#set_viewer_id" do
    subject { testModel.send(:set_viewer_id) }

    let(:testModel) do
      class TestModel
        include DomainViewerTracker
      end
      allow_any_instance_of(TestModel).to receive(:cookies).and_return(test_cookie)
      TestModel.new
    end
    let(:test_cookie) { ActionDispatch::Cookies::CookieJar.new(nil) }

    it "should save cookie with uuid" do
      subject
      expect(test_cookie[:viewer_id]).to match /^.{36}$/
    end

    context "key name is changed" do
      before do
        DomainViewerTracker.configure do |config|
          config.cookie_key_name = "sushi"
        end
      end

      it "should save cookie with changed key" do
        subject
        expect(test_cookie[:viewer_id]).to be_nil
        expect(test_cookie[:sushi]).to match /^.{36}$/
      end

      after do
        DomainViewerTracker.configure do |config|
          config.cookie_key_name = "viewer_id"
        end
      end
    end

    context "domain is changed" do
      before do
        DomainViewerTracker.configure do |config|
          config.cookie_domain = ".sushi.example.com"
        end
      end

      it "should save cookie with changed key" do
        subject
        expect(test_cookie[:viewer_id]).to match /^.{36}$/
        expect(test_cookie.instance_eval("@set_cookies")["viewer_id"][:domain]).to eq ".sushi.example.com"
      end

      after do
        DomainViewerTracker.configure do |config|
          config.cookie_domain = ""
        end
      end
    end
  end
end
