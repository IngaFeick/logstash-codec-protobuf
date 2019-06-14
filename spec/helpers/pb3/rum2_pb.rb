# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: something/rum_akamai/AkamaiRum.proto

begin; require 'google/protobuf'; rescue LoadError; end

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "something.logging.ProtoHeader" do
    optional :unix_timestamp, :int64, 1
    optional :sender_id, :string, 2
  end
end

module Something
  module Logging
    ProtoHeader = Google::Protobuf::DescriptorPool.generated_pool.lookup("something.logging.ProtoHeader").msgclass
  end
end



Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "something.rum_akamai.ProtoAkamai2Rum" do
    optional :header, :message, 1, "something.logging.ProtoHeader"
    optional :version, :string, 2
    optional :url, :string, 3
    optional :http_referer, :string, 4
    optional :session_id, :string, 5
    optional :tracking_id, :string, 6
    optional :locale, :string, 7
    optional :user_agent, :message, 8, "something.rum_akamai.ProtoAkamai2Rum.ProtoUserAgent"
    optional :geo, :message, 9, "something.rum_akamai.ProtoAkamai2Rum.ProtoGeoLocation"
    optional :timers, :message, 10, "something.rum_akamai.ProtoAkamai2Rum.ProtoTimers"
    optional :page_group, :string, 11
    repeated :active_ctests, :string, 12
    optional :dom, :message, 13, "something.rum_akamai.ProtoAkamai2Rum.ProtoDom"
    optional :domain, :string, 14
    optional :timestamp, :string, 15
  end
  add_message "something.rum_akamai.ProtoAkamai2Rum.ProtoUserAgent" do
    optional :family, :string, 1
    optional :major, :float, 2
    optional :manufacturer, :string, 3
    optional :minor, :float, 4
    optional :mobile, :string, 5
    optional :model, :string, 6
    optional :os, :string, 7
    optional :osversion, :string, 8
    optional :raw, :string, 9
    optional :type, :string, 10
  end
  add_message "something.rum_akamai.ProtoAkamai2Rum.ProtoGeoLocation" do
    optional :cc, :string, 1
    optional :city, :string, 2
    optional :isp, :string, 3
    optional :lat, :float, 4
    optional :lon, :float, 5
    optional :netspeed, :string, 6
    optional :organisation, :string, 7
    optional :ovr, :bool, 8
    optional :postalcode, :string, 9
    optional :rg, :string, 10
  end
  add_message "something.rum_akamai.ProtoAkamai2Rum.ProtoTimers" do
    optional :t_resp, :int32, 1
    optional :fid, :int32, 2
    optional :fcp, :int32, 3
    optional :tti, :int32, 4
    optional :ttfi, :int32, 5
    optional :ttvr, :int32, 6
    optional :longtasks, :float, 7
  end
  add_message "something.rum_akamai.ProtoAkamai2Rum.ProtoDom" do
    optional :script, :int32, 1
    optional :ext, :int32, 2
    optional :ln, :int32, 3
  end
end

module Something
  module RumAkamai
    ProtoAkamai2Rum = Google::Protobuf::DescriptorPool.generated_pool.lookup("something.rum_akamai.ProtoAkamai2Rum").msgclass
    ProtoAkamai2Rum::ProtoUserAgent = Google::Protobuf::DescriptorPool.generated_pool.lookup("something.rum_akamai.ProtoAkamai2Rum.ProtoUserAgent").msgclass
    ProtoAkamai2Rum::ProtoGeoLocation = Google::Protobuf::DescriptorPool.generated_pool.lookup("something.rum_akamai.ProtoAkamai2Rum.ProtoGeoLocation").msgclass
    ProtoAkamai2Rum::ProtoTimers = Google::Protobuf::DescriptorPool.generated_pool.lookup("something.rum_akamai.ProtoAkamai2Rum.ProtoTimers").msgclass
    ProtoAkamai2Rum::ProtoDom = Google::Protobuf::DescriptorPool.generated_pool.lookup("something.rum_akamai.ProtoAkamai2Rum.ProtoDom").msgclass
  end
end
