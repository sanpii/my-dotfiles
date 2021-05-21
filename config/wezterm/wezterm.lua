local wezterm = require 'wezterm';

wezterm.on("format-window-title", function(tab, tabs, panes, config)
    return tab.active_pane.title
end)

local keys = {
    {key="e", mods="LEADER|CTRL", action=wezterm.action{SendString="\x05"}},
    {key="t", mods="LEADER|CTRL", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="p", mods="LEADER|CTRL", action=wezterm.action{ActivateTabRelative=-1}},
    {key="n", mods="LEADER|CTRL", action=wezterm.action{ActivateTabRelative=1}},
    {key="c", mods="LEADER|CTRL", action=wezterm.action{MoveTabRelative=-1}},
    {key="r", mods="LEADER|CTRL", action=wezterm.action{MoveTabRelative=1}},
    {key="k", mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="v", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="c", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="t", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Down"}},
    {key="s", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="r", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="-", mods="CTRL", action="DecreaseFontSize"},
    {key="+", mods="CTRL", action="IncreaseFontSize"},
    {key="=", mods="CTRL", action="ResetFontSize"},
    {key="Insert", mods="SHIFT", action="Paste"},
    {key="PageUp", mods="SHIFT", action=wezterm.action{ScrollByPage=-1}},
    {key="PageDown", mods="SHIFT", action=wezterm.action{ScrollByPage=1}},
};

for x = 1, 9 do
    table.insert(keys, {
        key = tostring(x),
        mods = "LEADER",
        action = wezterm.action{ActivateTab = x - 1},
    });
end

return {
    harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
    warn_about_missing_glyphs = false,
    color_scheme = "Builtin Tango Dark",
    exit_behavior = "Close",
    font = wezterm.font("Hack Nerd Font"),
    font_size = 12.0,
    disable_default_key_bindings = true,
    leader = { key="e", mods="CTRL", timeout_milliseconds=1000 },
    keys = keys,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    colors = {
        tab_bar = {
            background = "#000000",
            active_tab = {
                bg_color = "#000000",
                fg_color = "#ffffff",
                intensity = "Bold",
            },
            inactive_tab = {
                bg_color = "#000000",
                fg_color = "#d3d7cf",
                intensity = "Half",
            },
            inactive_tab_hover = {
                bg_color = "#b4d5ff",
                fg_color = "#000000",
            },
        },
    },
}
