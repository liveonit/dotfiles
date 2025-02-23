#!/usr/bin/env bash

## Colours and font styles
## Syntax: echo -e "${FOREGROUND_COLOUR}${BACKGROUND_COLOUR}${STYLE}Hello world!${RESET_ALL}"

# Escape sequence and resets
ESC_SEQ="\x1b["
RESET_ALL="${ESC_SEQ}0m"
RESET_BOLD="${ESC_SEQ}21m"
RESET_UL="${ESC_SEQ}24m"

# Foreground colours
FG_BLACK="${ESC_SEQ}30;"
FG_RED="${ESC_SEQ}31;"
FG_GREEN="${ESC_SEQ}32;"
FG_YELLOW="${ESC_SEQ}33;"
FG_BLUE="${ESC_SEQ}34;"
FG_MAGENTA="${ESC_SEQ}35;"
FG_CYAN="${ESC_SEQ}36;"
FG_WHITE="${ESC_SEQ}37;"
FG_BR_BLACK="${ESC_SEQ}90;"
FG_BR_RED="${ESC_SEQ}91;"
FG_BR_GREEN="${ESC_SEQ}92;"
FG_BR_YELLOW="${ESC_SEQ}93;"
FG_BR_BLUE="${ESC_SEQ}94;"
FG_BR_MAGENTA="${ESC_SEQ}95;"
FG_BR_CYAN="${ESC_SEQ}96;"
FG_BR_WHITE="${ESC_SEQ}97;"

# Background colours (optional)
BG_BLACK="40;"
BG_RED="41;"
BG_GREEN="42;"
BG_YELLOW="43;"
BG_BLUE="44;"
BG_MAGENTA="45;"
BG_CYAN="46;"
BG_WHITE="47;"

# Font styles
FS_REG="21;24m"
FS_BOLD="1m"
FS_UL="4m"

# Print text in Green
green() {
  printf "${FG_GREEN}${FS_REG}$@${RESET_ALL}"
}

# Print text in Yellow
yellow() {
  printf "${FG_YELLOW}${FS_REG}$@${RESET_ALL}"
}

# Print text in Blue
blue() {
  printf "${FG_BR_BLUE}${FS_REG}$@${RESET_ALL}"
}

# Print text in Red
red() {
  printf "${FG_RED}${FS_REG}$@${RESET_ALL}"
}



# Print text in Green
success() {
  printf "✅ ${FG_GREEN}${FS_REG}$@${RESET_ALL} ✅\n"
}

# Print text in Yellow
warn() {
  printf "⚠️ ${FG_YELLOW}${FS_REG}$@${RESET_ALL} ⚠️\n"
}

# Print text in Blue
info() {
  printf "ℹ️ ${FG_BR_BLUE}${FS_REG}$@${RESET_ALL} ℹ️\n"
}

# Print text in Red
error() {
  printf "❌ ${FG_RED}${FS_REG}$@${RESET_ALL} ❌\n"
}
