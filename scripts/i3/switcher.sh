#!/bin/bash

mode_settings="-modi window,windowcd -show windowcd"
display_settings="-lines 3 -eh 2"
color_window="#CC2F343F,#CC2F343F,#2F343F"
color_normal="#002F343F,#676E7D,#002F343F,#002F343F,#F3F4F5"
color_active="#002F343F,#F3F4F5,#002F343F,#002F343F,#F3F4F5"
color_urgent="#002F343F,#F3F4F5,#002F343F,#002F343F,#F3F4F5"
font="System San Francisco Display 14"

rofi $mode_settings $display_settings -color-window "$color_window" -color-normal "$color_normal" -color-active "$color_active" -color-urgent "$color_urgent" -font "$font"
