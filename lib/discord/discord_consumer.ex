# from https://github.com/Kraigie/nostrum/blob/master/examples/event_consumer.ex

defmodule DiscordConsumer do
  use Nostrum.Consumer

  alias Nostrum.Api

  require Logger

  def start_link do
    Logger.debug "Discord Consumer started"
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    case msg.content do
      "!sleep" ->
        Api.create_message(msg.channel_id, "Going to sleep...")
        # This won't stop other events from being handled.
        Process.sleep(3000)

      "!ping" ->
        Api.create_message(msg.channel_id, "pyongyang!")

      "!raise" ->
        # This won't crash the entire Consumer.
        raise "No problems here!"

      _ ->
        :ignore
    end
  end

  def handle_event(_event) do
    Logger.debug "Received Discord Event"
    :noop
  end
end
