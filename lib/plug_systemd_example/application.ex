defmodule PlugSystemdExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  def start(_type, _args) do
    :ok = :logger.add_handlers(:systemd)

    fds = :systemd.listen_fds(false)
    Logger.info(inspect(fds))

    cowboy_opts = [
      scheme: :http,
      plug: PlugSystemdExample.Router
    ] ++ socket_opts(fds)

    children = [
      {Plug.Cowboy, cowboy_opts},
      {Task, fn -> :systemd.notify(:ready) end},
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
        {fd, _name} -> fd
        fd when is_integer(fd) and fd > 0 -> fd
      end

    {:ok, socket} = :gen_tcp.listen(0, [:binary, :local, fd: fd])

    [
      transport_options: [
        socket: socket
      ],
      ip: :local,
      port: 0
    ]
  end
end
