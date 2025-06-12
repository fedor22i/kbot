# kbot
t.me/inMediaMAM_Clients_bot \

Telegram bot has the ability to process messages from users and respond to them.

Golang language \
Frameworks github.com/spf13/cobra and gopkg.in/telebot.v4 \
Implemented message handlers for the bot that respond to messages in Telegram. \
Created message handlers for the bot. \
Added these functions to the methods of the telebot.Bot object. \
Processes messages according to their type and content.

Currently responds to the command "/start hello"

```
                      ┌────────────────────────────┐
                      │        GitHub Push         │
                      │     (to branch develop)    │
                      └────────────┬───────────────┘
                                   │
                                   ▼
                    ┌──────────────────────────────┐
                    │             CI               │
                    │     (Continuous Integration) │
                    └──────────────────────────────┘
                                  │
     ┌────────────────────────────┼────────────────────────────┐
     ▼                            ▼                            ▼
┌─────────────┐        ┌────────────────────┐        ┌────────────────────┐
│   Checkout  │        │      Run tests     │        │   Docker login to  │
│ (pull repo) │        │   `make test`      │        │     ghcr.io        │
└─────────────┘        └────────────────────┘        └────────────────────┘
                                                            │
                                                            ▼
                                                ┌───────────────────────┐
                                                │  Build & Push Docker  │
                                                │ `make image push`     │
                                                └───────────────────────┘
                                                            │
                                                            ▼
                                        ┌────────────────────────────────┐
                                        │              CD                │
                                        │   (Continuous Deployment)      │
                                        └────────────────────────────────┘
                                                            │
                      ┌────────────────────────────┬────────┼────────────┬──────────────────────────┐
                      ▼                            ▼        ▼            ▼                          ▼
             ┌─────────────┐        ┌────────────────────┐   │   ┌────────────────────┐   ┌────────────────────┐
             │   Checkout  │        │  Install k3d CLI   │   │   │  Create k3d cluster│   │  Install ArgoCD    │
             └─────────────┘        │ via curl script    │   │   └────────────────────┘   └────────────────────┘
                                    └────────────────────┘   │
                                                             ▼
                                               ┌─────────────────────────────┐
                                               │ Deploy via ArgoCD           │
                                               │ `kubectl apply ...`         │
                                               │ (argocd-app.yaml)           │
                                               └─────────────────────────────┘
```
