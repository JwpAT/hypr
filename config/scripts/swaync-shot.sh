#!/bin/bash

swaync-client --close-panel && sleep 0.7 && grim -g "$(slurp -d)" "$HOME/Pictures/$(date +'%Y%m%d_%Hh%Mm%Ss')_grim.png"