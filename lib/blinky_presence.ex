defmodule BlinkyPresence do
  use Application
  alias Nerves.IO.Ethernet
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    System.get_env("NERVES_TARGET")
    |> nerves_start

    children = [
      supervisor(Phoenix.PubSub.PG2, [BlinkyPresence.PubSub, [pool_size: 1]]),
      worker(BlinkyPresence.Service, [[pubsub_server: BlinkyPresence.PubSub]]),
      worker(BlinkyPresence.Device, [[pubsub_server: BlinkyPresence.PubSub]]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BlinkyPresence.Supervisor]
    Supervisor.start_link(children, opts)
  end


  def nerves_start(nil), do: nil
  def nerves_start(_) do
    {:ok, _} = Ethernet.setup :eth0, hostname: "rpi2.local"
  end

end
