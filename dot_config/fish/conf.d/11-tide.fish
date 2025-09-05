# return if not interactive
if not status is-interactive
    return
end

# return if already initialized
if set -q __tide_user_initialized
    return
end

# initialization
tide configure --auto \
    --style=Lean \
    --prompt_colors='True color' \
    --show_time=No \
    --lean_prompt_height='Two lines' \
    --prompt_connection=Disconnected \
    --prompt_spacing=Sparse \
    --icons='Few icons' \
    --transient=Yes

# TokyoNight Color Palette
set -l comment 565f89
set -l red f7768e
set -l green 9ece6a
set -l cyan 7dcfff
set -l purple 9d7cd8
set -l blue 7aa2f7
set -l orange ff9e64
set -l yellow e0af68

# character
set -U tide_character_color $green
set -U tide_character_color_failure $red

# pwd
set -U tide_pwd_color_anchors $cyan
set -U tide_pwd_color_dirs $blue
set -U tide_pwd_color_truncated_dirs $purple

# git
set -U tide_git_color_branch $green
set -U tide_git_color_conflicted $red
set -U tide_git_color_dirty $yellow
set -U tide_git_color_operation $orange
set -U tide_git_color_staged $yellow
set -U tide_git_color_stash $purple
set -U tide_git_color_untracked $blue
set -U tide_git_color_upstream $green
set -U tide_git_icon 
set -U tide_git_truncation_length 36 # the length to truncate the branch name to
set -U tide_git_truncation_strategy l # git branch truncation strategy: left

# status
set -U tide_status_color $green
set -U tide_status_color_failure $red

# mark as initialized
set -U __tide_user_initialized true

# Reload tide
tide reload
