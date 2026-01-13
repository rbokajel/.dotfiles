local naughty = require("naughty")

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Hey man, there was an error when starting ...",
        text = "To help you out: " .. awesome.startup_errors
    })
end

-- Runtime Errors
do
    local in_error = false
    awesome.connect_signal(
        "debug::error", 
        function (err)
            if in_error then return end
            in_error = true

            naughty.notify({
                preset = naughty.config.presets.critical,
                title = "Oof .. this is awkward",
                text = "To help you out: " .. tostring(err)
            })
        end
    )
end
