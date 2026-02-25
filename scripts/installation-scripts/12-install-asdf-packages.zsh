#!/usr/bin/env zsh

set -euo pipefail

add_asdf_plugin_with_system_default() {
    local plugin="$1"
    asdf plugin add "$plugin" 2>/dev/null || true
    asdf set -u "$plugin" system 2>/dev/null || true
}

add_asdf_plugin_with_system_default nodejs
add_asdf_plugin_with_system_default yarn
add_asdf_plugin_with_system_default ruby
add_asdf_plugin_with_system_default python
add_asdf_plugin_with_system_default flutter
add_asdf_plugin_with_system_default java
add_asdf_plugin_with_system_default kotlin
add_asdf_plugin_with_system_default cmake
