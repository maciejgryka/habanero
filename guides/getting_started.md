# Getting started

- Install [`habanero`](https://hex.pm/package/habanero)
- Configuration: set `HABANERO_SECRET` to the same random value (e.g. `mix phx.gen.secret`) locally and in your deployment. Then in `config/dev.exs`:

      config :habanero,
        deploy_url: $DEPLOY_URL,
        deploy_endpoint: "/habanero_deploy"

  And in `config/runtime.exs`:

      config :habanero,
        secret: System.get_env("HABANERO_SECRET")

- Add the 🌶️ hot deploy 🌶️ route to your app

        scope "/" do
          pipe_through :api
          post "/habanero_deploy", Habanero.HotDeployController, :update
        end

- Deploy your app, so that the new endpoint is available.
- Set up the local watcher. We'll configure it to only start in development:

      children =
        if System.get_env("MIX_ENV", "dev") == "dev" do
          children ++
            [
              {Habenero.Watcher, [dirs: ["lib/<your_app>/", "lib/<your_app>_web/"], latency: 0]}
            ]
        else
          children
        end

- Now, start your dev server locally, make a change, and see the hot deploy in action 🔥
