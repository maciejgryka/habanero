defmodule Habanero.HotDeployController do
  require Logger

  use Phoenix.Controller

  def update(conn, %{"updates" => updates} = _params) do
    [secret] = Plug.Conn.get_req_header(conn, "x-habanero-secret")

    if secret == Application.get_env(:habanero, :secret) do
      Enum.map(updates, fn %{"body" => body, "path" => path} ->
        filename = Path.basename(path)
        compile(filename, body)
      end)

      json(conn, %{ok: true})
    else
      Logger.info("invalid token")

      conn
      |> put_status(401)
      |> json(%{error: :unathorized})
    end
  end

  defp compile(filename, body) do
    if String.ends_with?(filename, ".ex") do
      {:ok, tmp_path} = Briefly.create()
      :ok = File.write!(tmp_path, body)
      Code.compile_file(tmp_path)
    end
  end
end
