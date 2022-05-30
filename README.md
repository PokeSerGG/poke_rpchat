# VORP RPCHAT!

## 1. Requirements

[VORP-Core](https://github.com/VORPCORE/VORP-Core)

[VORP-Inventory](https://github.com/VORPCORE/VORP-Inventory)

## 2. Installation
- Add ```ensure poke_rpchat``` in your server.cfg

## 3. Config

In config.lua file, you need to configure your server name and webhooks for each command

```lua
Config.ServerName = 'YourServerName'

Config.WebHooks = {
    ['ooc'] = {
        enable = true,
        url = 'YourWeebhookURL',
        color = 16753920 -- (You can get the decimal colors in https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
    },
}
```

## 4. Discord

Join my Discord to get support - [Discord](https://discord.gg/AyfEp8hRUD)
