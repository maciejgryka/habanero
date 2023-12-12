# Getting started

- Install [`habanero`](https://hex.pm/package/habanero)
- Add the 🌶️ hot deploy 🌶️ route to your app

    post "/habanero_deploy", HotDeployController, :update

- Set up the secret locally and on your running instance
- Set up the local watcher (including config). Locally:

    config :habanero,
      deploy_url: $DEPLOY_URL,
      deploy_endpoint: "/habanero_deploy"

  And then in your runtime config:

    config :habanero,
      secret: System.get_env("HABANERO_SECRET")

- Deploy your app
- Make a change locally, see the hit deploy in action
