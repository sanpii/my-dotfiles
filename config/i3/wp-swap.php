#!/usr/bin/php
<?php

namespace i3
{
    function send($message)
    {
        return json_decode(
            shell_exec("i3-msg $message")
        );
    }

    function getOutputs()
    {
        return send("-t get_outputs");
    }

    function getWorkspaces()
    {
        return send("-t get_workspaces");
    }

    function getActiveWorkspace()
    {
        $workspaces = getWorkspaces();

        foreach ($workspaces as $workspace) {
            if ($workspace->focused === true) {
                $activeWorkspace = $workspace;
                break;
            }
        }

        return $activeWorkspace;
    }

    function getActiveOutput()
    {
        $activeWorkspace = getActiveWorkspace();

        if ($activeWorkspace !== null) {
            $outputs = getOutputs();

            foreach ($outputs as $output) {
                if ($output->current_workspace === $activeWorkspace->name) {
                    $activeOutput = $output;
                    break;
                }
            }
        }

        return $activeOutput;
    }
}

namespace
{
    $activeOutput = \i3\getActiveOutput();
    $outputs = \i3\getOutputs();

    foreach ($outputs as $id => $output) {
        if ($activeOutput->name === $output->name) {
            $activeId = $id;
            break;
        }
    }

    $nextId = ($id + 1) % count($outputs);
    \i3\send("workspace" . $outputs[$nextId]->current_workspace);
}
