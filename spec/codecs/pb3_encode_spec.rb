



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

    #### Test case 1: encode simple protobuf ####################################################################################################################

    require_relative '../helpers/pb3/unicorn_pb.rb'

    subject do
      next LogStash::Codecs::Protobuf.new("class_name" => "Unicorn", "include_path" => [pb_include_path + '/pb3/unicorn_pb.rb'], "protobuf_version" => 3)
    end

    event1 = LogStash::Event.new("name" => "Pinkie", "age" => 18, "is_pegasus" => false, "favourite_numbers" => [1,2,3], "fur_colour" => Colour::PINK, "favourite_colours" => [1,5] )

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

    #### Test case 2: encode nested protobuf ####################################################################################################################

    require_relative '../helpers/pb3/unicorn_pb.rb'

    subject do
      next LogStash::Codecs::Protobuf.new("class_name" => "Unicorn", "include_path" => [pb_include_path + '/pb3/unicorn_pb.rb'], "protobuf_version" => 3)
    end

    event = LogStash::Event.new("name" => "Horst", "age" => 23, "is_pegasus" => true, "mother" => \
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
      subject.encode(event)
    end # it

  end # context #encodePB3

  context "encodePB3-c" do

    #### Test case 3: encode nested protobuf ####################################################################################################################

    require_relative '../helpers/pb3/rum_pb.rb'

    subject do
      next LogStash::Codecs::Protobuf.new("class_name" => "something.rum_akamai.ProtoAkamaiRum", "include_path" => [pb_include_path + '/pb3/rum_pb.rb' ], "protobuf_version" => 3)
    end

    event = LogStash::Event.new(
    "user_agent"=>{"os"=>"Android OS", "family"=>"Chrome Mobile", "major"=>74, "mobile"=>"1", "minor"=>0, "manufacturer"=>"Samsung", "osversion"=>"8", "model"=>"Galaxy S7 Edge", "type"=>"Mobile", "raw"=>"Mozilla/5.0 (Linux; Android 8.0.0; SM-G935F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Mobile Safari/537.36"}, "dom"=>{"script"=>65, "ln"=>2063, "ext"=>47}, "page_group"=>"SEO-Pages", "active_ctests"=>["1443703219", "1459869632", "1461246749", "1472826866", "25798", "27291", "32046", "35446", "38216", "39578", "40428", "40402", "42320", "42304", "43759", "42164", "42280", "42673", "44629", "44964", "45265", "45465", "38217", "45104", "45172", "45433", "39875", "45749", "45839", "45398", "45399", "46136", "46164", "46395", "46378", "46411", "46480", "46534", "46587", "42107", "46429", "46234", "46355", "46690", "46691", "46918", "46839", "46897", "46610", "46363", "46630", "46846", "46876", "45123", "46977", "47121", "47048", "46906"], "timestamp"=>"1559566982508", "geo"=>{"isp"=>"Telecom Italia Mobile", "lat"=>45.4643, "postalcode"=>"20123", "netspeed"=>"Cellular", "rg"=>"MI", "cc"=>"IT", "org"=>"Telecom Italia Mobile", "ovr"=>false, "city"=>"Milan", "lon"=>9.1895}, "header"=>{"sender_id"=>"0"}, "domain"=>"something.com", "url"=>"https://www.something.it/", "timers"=>{"tti"=>4544, "ttvr"=>3657, "fcp"=>2683, "ttfi"=>4280, "fid"=>31, "longtasks"=>2519, "t_resp"=>1748}
    )

    it "should return protobuf encoded data for testcase 3" do

      subject.on_event do |event, data|
        insist { data.is_a? String }

        pb_builder = Google::Protobuf::DescriptorPool.generated_pool.lookup("something.rum_akamai.ProtoAkamaiRum").msgclass
        decoded_data = pb_builder.decode(data)

        expect(decoded_data.domain ).to eq(event.get("domain") )
        expect(decoded_data.dom.ext ).to eq(event.get("dom")["ext"] )
        expect(decoded_data.user_agent.type ).to eq(event.get("user_agent")["type"] )
        expect(decoded_data.geo.rg ).to eq(event.get("geo")["rg"] )


      end # subject4.on_event
      subject.encode(event)
    end # it
  end # context #encodePB3-c

  context "encodePB3-d" do

    #### Test case 3: autoconvert data types ####################################################################################################################

    require_relative '../helpers/pb3/rum_pb.rb'

    subject do
      next LogStash::Codecs::Protobuf.new("class_name" => "something.rum_akamai.ProtoAkamaiRum",
        "pb3_encoder_autoconvert_types" => true,
        "include_path" => [pb_include_path + '/pb3/rum_pb.rb' ], "protobuf_version" => 3)
    end

    event = LogStash::Event.new(
      "user_agent"=>{"minor"=>0,"major"=>"74"}, # major should autoconvert to float
      "dom"=>{"script"=>65, "ln"=>2063, "ext"=>47.0}, # ext should autoconvert to int
      "geo"=>{"ovr"=>"false"}, # ovr should autoconvert to Boolean
      "header"=>{"sender_id"=>1} # sender_id should autoconvert to string
    )

    it "should fix datatypes to match the protobuf definition" do

      subject.on_event do |event, data|
        insist { data.is_a? String }

        pb_builder = Google::Protobuf::DescriptorPool.generated_pool.lookup("something.rum_akamai.ProtoAkamaiRum").msgclass
        decoded_data = pb_builder.decode(data)
        # expect(true).to eq(false) # Force failure to check if this test is being executed
        expect(decoded_data.user_agent.minor ).to eq(event.get("user_agent")["minor"] ) # only test fields which have not been converted
        # if this ^ works, then the convertion works aswell because otherwise there would have been an exception
      end
      subject.encode(event)
    end # it

  end # context #encodePB3-d


end # describe