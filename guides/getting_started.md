# Getting started

- Install [`habanero`](https://hex.pm/package/habanero)
- Coonfiguration: set `HABANERO_SECRET` to the same random value (e.g. `mix phx.gen.secret`) locally and in your deployment. Then in `config/dev.exs`:

      config :habanero,
        deploy_url: $DEPLOY_URL,
        deploy_endpoint: "/habanero_deploy"

  And in `config/runtime.exs`:

      config :habanero,
        secret: System.get_env("HABANERO_SECRET")

- Add the 🌶️ hot deploy 🌶️ route to your app

      post "/habanero_deploy", Habanero.HotDeployController, :update

- Deploy your app
- Set up the local watcher.
- Make a change locally, see the hit deploy in action
