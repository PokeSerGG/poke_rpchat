Config = {}

Config.VersionCheck = true

Config.UseDiscord = true

Config.ServerName = 'YourServerName'

Config.BlipCallTimer = 60 -- Time in seconds before the call blip disappears

Config.ProximityDistance = 5.0 -- Proximity Distance for proximity commands (local ooc, me, do, etc...)

Config.JobNames = {
    ['police'] = 'police',
    ['doctor'] = 'doctor',
}

Config.WebHooks = {
    -- Report
    ['report'] = {
        enable = true,
        url = '',
        color = 16753920,
    },
    -- Proximity OOC
    ['ooc'] = {
        enable = true,
        url = '',
        color = 16753920,
    },
    -- Help/Ayuda Command
    ['help'] = {
        enable = true,
        url = '',
        color = 16753920,
    },

    ['me'] = {
        enable = true,
        url = '',
        color = 16753920,
    },

    ['do'] = {
        enable = true,
        url = '',
        color = 16753920,
    },

    ['commerce'] = {
        enable = true,
        url = '',
        color = 16753920,
    },

    ['pm'] = {
        enable = true,
        url = '',
        color = 16753920,
    },

    ['auxilio'] = {
        enable = true,
        url = '',
        color = 16753920,
    },

    ['testigo'] = {
        enable = true,
        url = '',
        color = 16753920,
    },
}