# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: app/service/service.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "courier.TranslateRequest" do
    optional :content_html, :string, 1
  end
  add_message "courier.TranslatedTweet" do
    optional :body, :string, 1
  end
end

module Courier
  TranslateRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("courier.TranslateRequest").msgclass
  TranslatedTweet = Google::Protobuf::DescriptorPool.generated_pool.lookup("courier.TranslatedTweet").msgclass
end
