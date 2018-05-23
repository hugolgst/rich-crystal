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
      # Generate the handshake JSON payload
      payload = JSON.build do |json|
        json.object do
          # Discord RPC setted to 1
          json.field "v", 1
          json.field "client_id", @client_id.to_s
          # Set the current timestamp
          json.field "nonce", Time.now.to_s("%s")
        end
      end

      # Send the handshake
      @ipc.send(RichCrystal::Ipc::Opcode::Handshake, payload)
    end

    # Set the rich presence activity with activity arugments
    def activity(**activity)
      # Generate the frame JSON payload
      payload = JSON.build do |json|
        json.object do
          # Set cmd as SET_ACTIVITY for set Rich Presence activity
          json.field "cmd", "SET_ACTIVITY"
          json.field "args" do
            payload_args(json, activity)
          end
          # Set the current timestamp
          json.field "nonce", Time.now.to_s("%s")
        end
      end
      @ipc.send(RichCrystal::Ipc::Opcode::Frame, payload)
    end

    # Create activity arguments as JSON
    private def payload_args(json, activity : NamedTuple)
      json.object do
        # Set the process pid
        json.field "pid", Process.pid
        # Here are the activity arguments
        json.field "activity" do
          json.object do
            json.field "state", activity[:state] unless activity[:state].nil?
            json.field "details", activity[:details] unless activity[:details].nil?
          end
        end
      end
    end
  end
end
