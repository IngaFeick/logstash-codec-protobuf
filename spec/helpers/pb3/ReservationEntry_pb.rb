require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "bk.sk.pk.reservations.proto.types.v0.ReservationEntry" do
    optional :id, :string, 1
    optional :internalAccountId, :string, 2
    optional :state, :enum, 3, "bk.sk.pk.reservations.proto.types.v0.ReservationState"
    optional :instructedAmount, :message, 4, "bk.sk.pk.reservations.proto.types.v0.InstructedAmount"
    optional :lifetime, :message, 5, "bk.sk.pk.reservations.proto.types.v0.Lifetime"
    optional :requestor, :message, 6, "bk.sk.pk.reservations.proto.types.v0.Requestor"
    optional :description, :message, 7, "bk.sk.pk.reservations.proto.types.v0.Description"
    optional :forceMarker, :bool, 8
    optional :creationTimestamp, :string, 9
  end
  add_message "bk.sk.pk.reservations.proto.types.v0.Requestor" do
    optional :productCode, :string, 1
    optional :systemCode, :string, 2
    optional :init, :string, 3
  end
  add_message "bk.sk.pk.reservations.proto.types.v0.Lifetime" do
    optional :startDateTime, :string, 1
    optional :endDateTime, :string, 2
  end
  add_message "bk.sk.pk.reservations.proto.types.v0.InstructedAmount" do
    optional :amount, :message, 1, "bk.sk.pk.reservations.proto.types.v0.DecimalNumber"
    optional :currency, :string, 2
  end
  add_message "bk.sk.pk.reservations.proto.types.v0.DecimalNumber" do
    optional :unscaledValue, :int64, 1
    optional :scale, :int32, 2
  end
  add_message "bk.sk.pk.reservations.proto.types.v0.Description" do
    optional :text1, :string, 1
    optional :text2, :string, 2
  end
  add_enum "bk.sk.pk.reservations.proto.types.v0.ReservationState" do
    value :RESERVED, 0
    value :CANCELED, 1
    value :CONSUMED, 2
    value :EXPIRED, 3
  end
end

module Bk
  module Sk
    module Pk
      module Reservations
        module Proto
          module Types
            module V0
              ReservationEntry = Google::Protobuf::DescriptorPool.generated_pool.lookup("bk.sk.pk.reservations.proto.types.v0.ReservationEntry").msgclass
              Requestor = Google::Protobuf::DescriptorPool.generated_pool.lookup("bk.sk.pk.reservations.proto.types.v0.Requestor").msgclass
              Lifetime = Google::Protobuf::DescriptorPool.generated_pool.lookup("bk.sk.pk.reservations.proto.types.v0.Lifetime").msgclass
              InstructedAmount = Google::Protobuf::DescriptorPool.generated_pool.lookup("bk.sk.pk.reservations.proto.types.v0.InstructedAmount").msgclass
              DecimalNumber = Google::Protobuf::DescriptorPool.generated_pool.lookup("bk.sk.pk.reservations.proto.types.v0.DecimalNumber").msgclass
              Description = Google::Protobuf::DescriptorPool.generated_pool.lookup("bk.sk.pk.reservations.proto.types.v0.Description").msgclass
              ReservationState = Google::Protobuf::DescriptorPool.generated_pool.lookup("bk.sk.pk.reservations.proto.types.v0.ReservationState").enummodule
            end
          end
        end
      end
    end
  end
end