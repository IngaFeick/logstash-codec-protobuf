# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/codecs/protobuf"
require "logstash/event"
require "insist"

require 'google/protobuf' # for protobuf3

# absolute path to the protobuf helpers directory
pb_include_path = File.expand_path(".") + "/spec/helpers"

describe LogStash::Codecs::Protobuf do

  context "#encodePB3-a" do

    #### Test case 3: encode simple protobuf ####################################################################################################################

    require_relative '../helpers/pb3/unicorn_pb.rb'

    subject do
      next LogStash::Codecs::Protobuf.new("class_name" => "Unicorn", "include_path" => [pb_include_path + '/pb3/unicorn_pb.rb'], "protobuf_version" => 3)
    end

    event1 = LogStash::Event.new("name" => "Pinkie", "age" => 18, "is_pegasus" => false, "favourite_numbers" => [1,2,3], "fur_colour" => Colour::PINK, "favourite_colours" => [1,5]      )

    it "should return protobuf encoded data for testcase 1" do

      subject.on_event do |event, data|
        insist { data.is_a? String }

        pb_builder = Google::Protobuf::DescriptorPool.generated_pool.lookup("Unicorn").msgclass
        decoded_data = pb_builder.decode(data)
        expect(decoded_data.name ).to eq(event.get("name") )
        expect(decoded_data.age ).to eq(event.get("age") )
        expect(decoded_data.is_pegasus ).to eq(event.get("is_pegasus") )
        expect(decoded_data.fur_colour ).to eq(:PINK)
        expect(decoded_data.favourite_numbers ).to eq(event.get("favourite_numbers") )
        expect(decoded_data.favourite_colours ).to eq([:BLUE,:WHITE] )
      end # subject.on_event

      subject.encode(event1)
    end # it

  end # context

  context "#encodePB3-b" do

    #### Test case 4: encode nested protobuf ####################################################################################################################

    require_relative '../helpers/pb3/unicorn_pb.rb'

    subject do
      next LogStash::Codecs::Protobuf.new("class_name" => "Unicorn", "include_path" => [pb_include_path + '/pb3/unicorn_pb.rb'], "protobuf_version" => 3)
    end

    event2 = LogStash::Event.new("name" => "Horst", "age" => 23, "is_pegasus" => true, "mother" => \
        {"name" => "Mom", "age" => 47}, "father" => {"name"=> "Daddy", "age"=> 50, "fur_colour" => 3 } # 3 == SILVER
      )

    it "should return protobuf encoded data for testcase 2" do

      subject.on_event do |event, data|
        insist { data.is_a? String }

        pb_builder = Google::Protobuf::DescriptorPool.generated_pool.lookup("Unicorn").msgclass
        decoded_data = pb_builder.decode(data)

        expect(decoded_data.name ).to eq(event.get("name") )
        expect(decoded_data.age ).to eq(event.get("age") )
        expect(decoded_data.is_pegasus ).to eq(event.get("is_pegasus") )
        expect(decoded_data.mother.name ).to eq(event.get("mother")["name"] )
        expect(decoded_data.mother.age ).to eq(event.get("mother")["age"] )
        expect(decoded_data.father.name ).to eq(event.get("father")["name"] )
        expect(decoded_data.father.age ).to eq(event.get("father")["age"] )
        expect(decoded_data.father.fur_colour ).to eq(:SILVER)


      end # subject4.on_event
      subject.encode(event2)
    end # it

  end # context #encodePB3

  context "#encodePB3-c" do

    #### Test case 4: encode nested protobuf ####################################################################################################################

    require_relative '../helpers/pb3/header_pb.rb'
    require_relative '../helpers/pb3/rum_pb.rb'

    subject do
      next LogStash::Codecs::Protobuf.new("class_name" => "ProtoAkamaiRum", "include_path" => [pb_include_path + '/pb3/header_pb.rb', pb_include_path + '/pb3/rum_pb.rb' ], "protobuf_version" => 3)
    end

    event3 = LogStash::Event.new(
      )

    it "should return protobuf encoded data for testcase 3" do

      subject.on_event do |event, data|
        insist { data.is_a? String }

        #pb_builder = Google::Protobuf::DescriptorPool.generated_pool.lookup("ProtoAkamaiRum").msgclass
        #decoded_data = pb_builder.decode(data)




      end # subject4.on_event
      subject.encode(event3)
    end # it

  end # context #encodePB3-c


end # describe
