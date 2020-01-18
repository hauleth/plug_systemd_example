defmodule PlugSystemdExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  def start(_type, _args) do
    cowboy_opts = [
      scheme: :http,
      plug: PlugSystemdExample.Router
    ]

    children = [
      {Plug.Cowboy, cowboy_opts},
      {Task, fn -> :systemd.notify(:ready) end}
    ]

    :ok = :logger.add_handlers(:systemd)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PlugSystemdExample.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
