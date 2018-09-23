#!/usr/bin/env bash

heco() {
    echo -e $1
}

light_red(){
    heco "\033[31m"
}

blue() {
    heco "\033[34m"
}

blue_bg() {
    heco "\033[44m"
}

# Green
green() {
    heco "\033[32m"
}

green_bg() {
    heco "\033[42m"
}

# Light Blue

light_blue() {
    heco "\033[94m"
}

light_blue_bg() {
    heco "\033[104m"
}

yellow() {
    heco "\033[33m"
}

yellow_bg() {
    heco "\033[104m"
}

blink() {
    heco "\033[5m"
}

inverted() {
    heco "\033[7m"
}

dim() {
    heco "\033[2m"
}

clear() {
    heco "\e[0m"
}

