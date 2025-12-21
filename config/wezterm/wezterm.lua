local wezterm = require 'wezterm';

wezterm.on("format-window-title", function(tab, tabs, panes, config)
    return 'wezterm - ' .. tab.active_pane.title
end)

local keys = {
    {key="phys:F", mods="LEADER|CTRL", action=wezterm.action{SendString="\x05"}},
    {key="phys:J", mods="LEADER|CTRL", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="phys:E", mods="LEADER|CTRL", action=wezterm.action{ActivateTabRelative=-1}},
    {key="n", mods="LEADER|CTRL", action=wezterm.action{ActivateTabRelative=1}},
    {key="phys:H", mods="LEADER|CTRL", action=wezterm.action{MoveTabRelative=-1}},
    {key="phys:L", mods="LEADER|CTRL", action=wezterm.action{MoveTabRelative=1}},
    {key="phys:B", mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="phys:U", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="phys:H", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="phys:J", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Down"}},
    {key="phys:K", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="phys:L", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="mapped:-", mods="CTRL", action="DecreaseFontSize"},
    {key="mapped:+", mods="CTRL", action="IncreaseFontSize"},
    {key="mapped:=", mods="CTRL", action="ResetFontSize"},
    {key="Insert", mods="SHIFT", action=wezterm.action{PasteFrom="Clipboard"}},
    {key="PageUp", mods="SHIFT", action=wezterm.action{ScrollByPage=-1}},
    {key="PageDown", mods="SHIFT", action=wezterm.action{ScrollByPage=1}},
    {key="f", mods="LEADER", action=wezterm.action.Search{CaseSensitiveString=""}},
};

for x = 1, 9 do
    table.insert(keys, {
        key = tostring(x),
        mods = "LEADER|SHIFT",
        action = wezterm.action{ActivateTab = x - 1},
    });
end

return {
    check_for_updates = false,
    default_prog = { "/bin/bash" },
    harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
    warn_about_missing_glyphs = false,
    color_scheme = "Builtin Tango Dark",
    exit_behavior = "Close",
    font = wezterm.font("Hack Nerd Font"),
    font_size = 12.0,
    disable_default_key_bindings = true,
    leader = { key="phys:F", mods="CTRL", timeout_milliseconds=1000 },
    keys = keys,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
}
