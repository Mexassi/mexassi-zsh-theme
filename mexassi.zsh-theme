
() {

local PR_USER PR_USER_OP PR_PROMPT PR_HOST

# Colors
# to customise colors use spectrum method to replace value inside the square brackets
# see bottom of the script
user_host=${FG[110]}
prompt_indicator=${FG[118]}
date_time=${FG[110]}
folders=${FG[060]}
extra_color=${FG[060]}

# # Check the UID
if [[ $UID -ne 0 ]]; then # normal user
 PR_USER="%{$user_host%n%f"
 PR_USER_OP='%F{green}%#%f'
 PR_PROMPT='%f$prompt_indicator %f'
else # root
 PR_USER='%F{red}%n%f'
 PR_USER_OP='%F{red}%#%f'
 PR_PROMPT='%F{red} %f'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
 PR_HOST='%F{red}%M%f' # SSH
else
 PR_HOST='%F{green}%M%f' # no SSH
fi


# local return_code="%(?..%F{red}%? ↵%f)"

local user_host="${PR_USER}%F"
local current_dir="%B%{$folders%}%~%f%b"
local git_branch='$(git_prompt_info)'
# works on any laptop with Manjaro installed. Does not work on desktop computers
local battery_indicator='🔋$(acpi | grep -o "[0-9]*"%)';
local desktop='💻'
local extra

#if [ -d "/sys/class/power_supply" ]; then
#    # display battery life
#    extra=${battery_indicator}
#else
#    # display computer
#    extra=${desktop}
#fi


PROMPT="$prompt_indicator ${date_time}[%D{%c}]$extra_color ${desktop}%  ${user_host} ${current_dir} ${git_branch}"$'\e[0m%}'" 
$prompt_indicator ⮞$PR_PROMPT "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[117]%}git:(%{$FG[013]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[117]%}) %{$fg[yellow]%}${bold}uncommitted changes ❗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[117]%}) %{$fg[118]%}${bold}✔"

}

# typeset -AHg FX FG BG

# FX=(
#     reset     "%{[00m%}"
#     bold      "%{[01m%}" no-bold      "%{[22m%}"
#     italic    "%{[03m%}" no-italic    "%{[23m%}"
#     underline "%{[04m%}" no-underline "%{[24m%}"
#     blink     "%{[05m%}" no-blink     "%{[25m%}"
#     reverse   "%{[07m%}" no-reverse   "%{[27m%}"
# )

# for color in {000..255}; do
#     FG[$color]="%{[38;5;${color}m%}"
#     BG[$color]="%{[48;5;${color}m%}"
# done


# ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}

# Show all 256 colors with color number
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %{$FG[$code]%}$ZSH_SPECTRUM_TEXT%{$reset_color%}"
  done
}

# Show all 256 colors where the background is set to specific color
function spectrum_bls() {
  for code in {000..255}; do
    print -P -- "$code: %{$BG[$code]%}$ZSH_SPECTRUM_TEXT%{$reset_color%}"
  done
}
