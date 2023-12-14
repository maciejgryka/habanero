defmodule Habenero.Watcher do
  use GenServer

  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(args) do
    {:ok, watcher_pid} = FileSystem.start_link(args)
    deploy_url = Application.get_env(:habanero, :deploy_url)
    deploy_endpoint = Application.get_env(:habanero, :deploy_endpoint)

    if deploy_url != nil and deploy_endpoint != nil do
      FileSystem.subscribe(watcher_pid)
      {:ok, %{watcher_pid: watcher_pid, deploy_url: deploy_url, deploy_endpoint: deploy_endpoint}}
    else
      {:ok, %{}}
    end
  end

  def handle_info(
        {:file_event, watcher_pid, {path, _events}},
        %{watcher_pid: watcher_pid, deploy_url: deploy_url, deploy_endpoint: deploy_endpoint} = state
      ) do
    if String.ends_with?(path, ".ex") do
      {:ok, body} = File.read(path)
      relative_path = String.replace(path, File.cwd!(), "")
      Logger.info("deploying #{relative_path}")
      post_update("#{deploy_url}#{deploy_endpoint}", relative_path, body)
    end

    {:noreply, state}
  end

  def handle_info({:file_event, watcher_pid, :stop}, %{watcher_pid: watcher_pid} = state) do
    Logger.info("file watcher stopped")
    {:noreply, state}
  end

  defp post_update(url, path, body) do
    [method: :post, url: url, json: %{updates: [%{path: path, body: body}]}]
    |> Req.new()
    |> Req.Request.put_header("x-habanero-secret", secret())
    |> Req.Request.run_request()
  end

  defp secret, do: System.get_env("HABANERO_SECRET")
end
