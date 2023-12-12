defmodule Habanero.HotDeployController do
  use Phoenix.Controller

  def update(conn, _params) do
    json(conn, %{ok: true})
  end
end
