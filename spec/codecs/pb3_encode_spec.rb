



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

    #### Test case 3: encode nested protobuf ####################################################################################################################

    require_relative '../helpers/pb3/header_pb.rb'
    require_relative '../helpers/pb3/rum_pb.rb'

    subject do
      next LogStash::Codecs::Protobuf.new("class_name" => "trivago.rum_akamai.ProtoAkamaiRum", "include_path" => [pb_include_path + '/pb3/rum_pb.rb' ], "protobuf_version" => 3)
    end

    event3 = LogStash::Event.new(
       "url"=>"https://hs-graphql.dus.tcs.test.cloud/",
       "domain"=>"test.sth",
       "dom"=>{
          "script"=>60,
          "ext"=>43,
          "ln"=>2885
        },
        "user_agent"=>{
          "type"=>"Desktop",
          "minor"=>0,
          "osversion"=>"10",
          "os"=>"Windows",
          "raw"=>"Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko",
          "family"=>"IE",
          "mobile"=>"0",
          "major"=>11
        },
         "page_group"=>"Homepage",
        "header"=>{
          "sender_id"=>"0"
        },
        "timers"=>{
        "t_resp"=>482,
        "ttvr"=>2468,
        "fid"=>4,
        "fcp"=>20,
        "tti"=>21,
        "ttfi"=>23,
        "longtasks"=>99.7
      },
      "active_ctests"=>[
        "1443703219",
        "1454413382",
        "46364",
        "43806"
      ],
      "geo"=>{
        "ovr"=>false,
        "rg"=>"25",
        "org"=>"Orange",
        "city"=>"Pontarlier",
        "lon"=>6.3554,
        "isp"=>"Orange",
        "postalcode"=>"25300",
        "cc"=>"FR",
        "netspeed"=>"Cable/DSL",
        "lat"=>46.9035
      },
    )

    event3 = LogStash::Event.new(
      "user_agent"=>{
        "type"=>"Mobile",
        "os"=>"Android OS",
        "minor"=>0,
        "osversion"=>"7",
        "manufacturer"=>"Samsung",
        "raw"=>"Mozilla/5.0 (Linux; Android 7.0; SAMSUNG SM-A510F Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/9.2 Chrome/67.0.3396.87 Mobile Safari/537.36",
        "family"=>"Chrome Mobile",
        "major"=>67,
        "model"=>"Galaxy A5 2016 Duos",
        "mobile"=>"1"
      },
      "geo"=>{
        "netspeed"=>"Cellular",
        "rg"=>"TA",
        "cc"=>"RU",
        "lat"=>55.7679,
        "org"=>"MTS PJSC",
        "lon"=>49.1631,
        "postalcode"=>"422528",
        "isp"=>"MTS PJSC",
        "ovr"=>false,
        "city"=>"Kazan’"
      },
      "timestamp"=>"1559566617303",
      "timers"=>{
        "ttfi"=>17289,
        "t_resp"=>2851,
        "fid"=>5
      },
      "url"=>"https://mc.yandex.ru/",
      "active_ctests"=>[
        "1443703219",
        "1459869632",
         "47123"
      ],
      "header"=>{
        "sender_id"=>"0"
      },
      "dom"=>{
        "ext"=>40,
        "ln"=>2183,
        "script"=>59
      },
      "page_group"=>"Homepage",
      "domain"=>"trivago.com"
    )

    event3 = LogStash::Event.new(
    "geo"=>{"org"=>"NET Virtua", "postalcode"=>"09700", "lat"=>-23.7, "city"=>"São Bernardo do Campo", "rg"=>"SP", "netspeed"=>"Cable/DSL", "cc"=>"BR", "lon"=>-46.55, "isp"=>"NET Virtua", "ovr"=>false}, "dom"=>{"script"=>62, "ext"=>43, "ln"=>686}, "domain"=>"trivago.com", "timers"=>{"fid"=>161, "ttfi"=>5038, "t_resp"=>198}, "page_group"=>"NSP Backend us GCP region", "user_agent"=>{"os"=>"Android OS", "osversion"=>"7", "minor"=>0, "manufacturer"=>"Xiaomi", "family"=>"Chrome Mobile", "mobile"=>"1", "major"=>74, "raw"=>"Mozilla/5.0 (Linux; Android 7.1.2; Redmi Note 5A Prime) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Mobile Safari/537.36", "model"=>"Redmi Note 5A Prime", "type"=>"Mobile"}, "active_ctests"=>["1443703219", "1446032213", "1459869632", "25798", "27291", "32046", "35446", "39578", "40428", "40402", "42320", "42304", "43759", "42164", "42280", "42673", "44629", "44964", "43316", "38213", "45265", "45465", "38217", "45104", "45172", "45433", "39875", "45360", "45749", "45839", "45399", "46136", "46138", "46164", "46395", "46378", "46411", "46480", "46534", "46587", "42107", "46429", "46234", "45550", "46355", "46690", "46691", "46918", "46839", "46897", "46610", "46363", "46735", "46734", "46876", "45123", "46977", "47121", "47134", "47123"], "timestamp"=>"1559566581306", "header"=>{"sender_id"=>"0"}, "url"=>"https://hsg-prod-us.nsp.trv.cloud/"
    )

    it "should return protobuf encoded data for testcase 3" do

      subject.on_event do |event, data|
        insist { data.is_a? String }

        pb_builder = Google::Protobuf::DescriptorPool.generated_pool.lookup("trivago.rum_akamai.ProtoAkamaiRum").msgclass
        decoded_data = pb_builder.decode(data)

        expect(decoded_data.domain ).to eq(event.get("domain") )
        expect(decoded_data.dom.ext ).to eq(event.get("dom")["ext"] )
        expect(decoded_data.user_agent.type ).to eq(event.get("user_agent")["type"] )
        expect(decoded_data.geo.rg ).to eq(event.get("geo")["rg"] )


      end # subject4.on_event
      subject.encode(event3)
    end # it

  end # context #encodePB3-c


end # describe