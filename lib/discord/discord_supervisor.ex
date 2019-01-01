# from https://github.com/Kraigie/nostrum/blob/master/examples/event_consumer.ex
defmodule Discord.Supervisor do

  require Logger

  def start_link do
    Logger.debug "Discord Supervisor Started"

    import Supervisor.Spec

    children = [Discord.Consumer]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
