# from https://github.com/Kraigie/nostrum/blob/master/examples/event_consumer.ex
defmodule DiscordSupervisor do

  require Logger

  def start_link do
    Logger.debug "Discord Supervisor Started"

    import Supervisor.Spec

    children = [DiscordConsumer]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
