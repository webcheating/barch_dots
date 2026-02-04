#!/bin/bash

get_workspaces() {
    wmctrl -d | awk '
    {
        id = $1
        focused = ($2 == "*") ? "true" : "false"
        name = $NF

        printf("{\"num\":%d,\"name\":\"%s\",\"focused\":%s,\"urgent\":false,\"visible\":%s,\"output\":\"X\"}\n",
               id+1, name, focused, focused)
    }' | jq -cs .
}
get_workspaces
while true; do
    sleep 0.2
    get_workspaces
done
