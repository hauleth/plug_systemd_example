defmodule PlugSystemdExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  def start(_type, _args) do
    case :logger.add_handlers(:systemd) do
      :ok ->
        :logger.remove_handler(:default)
      _ -> :ok
    end

    fds = :systemd.listen_fds()

    cowboy_opts = [
      scheme: :http,
      plug: PlugSystemdExample.Router
    ] ++ socket_opts(fds)

    children = [
      {Plug.Cowboy, cowboy_opts},
      :systemd.ready(),
      {Plug.Cowboy.Drainer, refs: :all}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PlugSystemdExample.Supervisor]

    Supervisor.start_link(children, opts)
  end

  defp socket_opts([socket | _]) do
    fd =
      case socket do
        {fd, _name} when is_integer(fd) and fd > 0 -> fd
        fd when is_integer(fd) and fd > 0 -> fd
      end

    [
      transport_options: [
        socket_opts: [:inet6, fd: fd]
      ],
      port: 0
    ]
  end
end
