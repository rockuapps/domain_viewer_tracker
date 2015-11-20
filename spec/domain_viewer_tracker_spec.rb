require 'spec_helper'

describe DomainViewerTracker do
  let(:testModel) do
    class TestModel
      include DomainViewerTracker
    end
    allow_any_instance_of(TestModel).to receive(:cookies).and_return(test_cookie)
    TestModel.new
  end
  let(:test_cookie) { ActionDispatch::Cookies::CookieJar.new(nil) }

  describe "#set_viewer_id" do
    subject { testModel.send(:set_viewer_id) }

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

  describe "#store_viewer_id" do
    subject { testModel.send(:store_viewer_id, user_id) }

    context "cookie and user_id exist" do
      let(:user_id) { 1 }
      before do
        test_cookie[:viewer_id] = "hoge"
      end

      it "Creates viewer record." do
        expect { subject }.to change { Viewer.count }.by 1
        expect(Viewer.exists?(uuid: "hoge", user_id: user_id)).to be true
      end
    end

    context "cookie is missing" do
      let(:user_id) { 1 }

      it "Creates viewer record." do
        expect { subject }.to change { Viewer.count }.by 1
        expect(Viewer.exists?(user_id: user_id)).to be true
      end

      it "genarates viewer_id" do
        subject
        expect(Viewer.find_by(user_id: user_id).uuid).to match /^.{36}$/
      end
    end

    context "user_id is missing" do
      let(:user_id) { nil }

      before do
        test_cookie[:viewer_id] = "hoge"
      end

      it "Creates viewer record." do
        expect { subject }.to change { Viewer.count }.by 1
        expect(Viewer.exists?(uuid: "hoge", user_id: nil)).to be true
      end
    end

    context "Viewer record already exist" do
      let(:user_id) { 1 }

      before do
        test_cookie[:viewer_id] = "hoge"
        Viewer.create!(uuid: "hoge", user_id: 1)
      end

      it "does not create viewer record." do
        expect { subject }.not_to change { Viewer.count }
      end
    end
  end

  after do
    Viewer.delete_all
  end
end
