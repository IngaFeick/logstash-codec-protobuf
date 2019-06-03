# Generated by the protocol buffer compiler.  DO NOT EDIT!


begin; require 'google/protobuf'; rescue LoadError; end

begin; require 'header_pb'; rescue LoadError; end

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "ProtoAkamaiRum" do
    optional :header, :message, 1, "ProtoHeader"

    optional :url, :string, 3
    optional :http_referer, :string, 4
    optional :session_id, :string, 5
    optional :tracking_id, :string, 6
    optional :locale, :string, 7
    optional :user_agent, :message, 8, "ProtoAkamaiRum.ProtoUserAgent"
    optional :geo, :message, 9, "ProtoAkamaiRum.ProtoGeoLocation"
    optional :timers, :message, 10, "ProtoAkamaiRum.ProtoTimers"
    optional :page_group, :string, 11
    repeated :active_ctests, :string, 12
    optional :dom, :message, 13, "ProtoAkamaiRum.ProtoDom"
    optional :domain, :string, 14
  end
  add_message "ProtoAkamaiRum.ProtoUserAgent" do
    optional :family, :string, 1
    optional :major, :string, 2
    optional :manufacturer, :string, 3
    optional :minor, :string, 4
    optional :mobile, :string, 5
    optional :model, :string, 6
    optional :os, :string, 7
    optional :osversion, :string, 8
    optional :raw, :string, 9
    optional :type, :string, 10
  end
  add_message "ProtoAkamaiRum.ProtoGeoLocation" do
    optional :cc, :string, 1
    optional :city, :string, 2
    optional :isp, :string, 3
    optional :lat, :float, 4
    optional :lon, :float, 5
    optional :netspeed, :string, 6
    optional :org, :string, 7
    optional :ovr, :bool, 8
    optional :postalcode, :string, 9
    optional :rg, :string, 10
  end
  add_message "ProtoAkamaiRum.ProtoTimers" do
    optional :t_resp, :int32, 1
    optional :fid, :int32, 2
    optional :fcp, :int32, 3
    optional :tti, :int32, 4
    optional :ttfi, :int32, 5
    optional :ttvr, :int32, 6
    optional :longtasks, :int32, 7
  end
  add_message "ProtoAkamaiRum.ProtoDom" do
    optional :script, :int32, 1
    optional :ext, :int32, 2
    optional :ln, :int32, 3
  end
end

module Trivago
  module RumAkamai
    ProtoAkamaiRum = Google::Protobuf::DescriptorPool.generated_pool.lookup("ProtoAkamaiRum").msgclass
    ProtoAkamaiRum::ProtoUserAgent = Google::Protobuf::DescriptorPool.generated_pool.lookup("ProtoAkamaiRum.ProtoUserAgent").msgclass
    ProtoAkamaiRum::ProtoGeoLocation = Google::Protobuf::DescriptorPool.generated_pool.lookup("ProtoAkamaiRum.ProtoGeoLocation").msgclass
    ProtoAkamaiRum::ProtoTimers = Google::Protobuf::DescriptorPool.generated_pool.lookup("ProtoAkamaiRum.ProtoTimers").msgclass
    ProtoAkamaiRum::ProtoDom = Google::Protobuf::DescriptorPool.generated_pool.lookup("ProtoAkamaiRum.ProtoDom").msgclass
  end
end
