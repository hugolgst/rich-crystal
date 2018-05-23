require "json"
require "./ipc"

module RichCrystal
  class Client
    # Creates a new Rich-crystal client used for set rich presence activity
    def initialize(@client_id : UInt64)
      @ipc = RichCrystal::Ipc.new
    end

    # Log the Rich-crystal client by sending a first handshake
    def login
      # Generate a JSON payload with RPC version: 1 and the client id
      payload = JSON.build do |json|
        json.object do
          json.field "v", 1
          json.field "client_id", @client_id.to_s
        end
      end

      # Send the handshake
      @ipc.send(RichCrystal::Ipc::Opcode::Handshake, payload)
    end
  end
end
