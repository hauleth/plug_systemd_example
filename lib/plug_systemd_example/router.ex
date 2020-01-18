defmodule PlugSystemdExample.Router do
  use Plug.Router

  plug(:match)
  plug(Plug.Logger)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, [:os.getpid(), "\n"])
  end

  get "/hello" do
    send_resp(conn, 200, "world\n")
  end

  get "/stop" do
    :systemd.watchdog(:trigger)

    send_resp(conn, 204, "")
  end

  get "/reload" do
    :systemd.notify(:reloading)

    Task.start(fn ->
      Process.sleep(10_000)
      :systemd.notify(:ready)
    end)

    send_resp(conn, 204, "")
  end

  get "/slow" do
    Process.sleep(5_000)

    send_resp(conn, 200, "I am sloooooow\n")
  end
end
