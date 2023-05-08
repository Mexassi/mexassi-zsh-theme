
() {

local PR_USER PR_USER_OP PR_PROMPT PR_HOST

# Colors
# to customise colors use spectrum method to replace value inside the square brackets
# see bottom of the script
user_host=${BG[013]}
user_host_text=${FG[013]}
prompt_indicator=${FG[118]}
dark_text=${FG[098]}
date_time=${BG[117]}
date_time_text=${FG[117]}
black_text=${FG[000]}
white_text=${FG[255]}
extra_color=${BG[098]}
extra_color_text=${FG[098]}

# # Check the UID
if [[ $UID -ne 0 ]]; then # normal user
 PR_USER="%{$user_host%n%f"
 PR_USER_OP='%${FG[000]}%#%f'
 PR_PROMPT='%f$prompt_indicator❯%f'
else # root
 PR_USER='%F{red}%n%f'
 PR_USER_OP='%F{red}%#%f'
 PR_PROMPT='%F{red}❯%f'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
 PR_HOST='%F{red}%M%f' # SSH
else
 PR_HOST='%${FG[232]}%M%f' # no SSH
fi


# local return_code="%(?..%F{red}%? ↵%f)"

local user_host_t="${PR_USER}%F"
local current_dir="%B%{$white_text%}%~%f%b"
local git_branch='$(git_prompt_info)'
# works on any laptop with Manjaro installed.
local battery_indicator="💻 $(system_profiler SPPowerDataType | grep 'State of Charge' | awk '{print $5}')%";
local desktop='💻'
local extra

if [ "$(system_profiler SPPowerDataType | grep 'State of Charge' | awk '{print $5}')" ]; then
   # display battery life
   extra=${battery_indicator}
else
   # display computer
   extra=${desktop}
fi

prompt_sep="$(echo -n '\uE0B0')"
left_end_prop="$(echo -n '\uE0B2')"
PROMPT="$date_time_text$left_end_prop$black_text${date_time}[%D{%c}]$extra_color${date_time_text}$prompt_sep$white_text ${extra}% $extra_color_text $user_host$prompt_sep $prompt_indicator$black_text${user_host_t} $white_text$user_host_text$extra_color$prompt_sep $white_text%~%f%b$extra_color_text$prompt_sep ${git_branch}"$'\e[0m%}'" 
$prompt_indicator$PR_PROMPT "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[117]%}git:(%{$FG[013]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[117]%}) %{$FG[208]%}%{[01m%}!"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[117]%}) %{$FG[118]%}%{[01m%}✔"

}

typeset -AHg FX FG BG

FX=(
  reset     "%{[00m%}"
  bold      "%{[01m%}" no-bold      "%{[22m%}"
  italic    "%{[03m%}" no-italic    "%{[23m%}"
  underline "%{[04m%}" no-underline "%{[24m%}"
  blink     "%{[05m%}" no-blink     "%{[25m%}"
  reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
  FG[$color]="%{[38;5;${color}m%}"
  BG[$color]="%{[48;5;${color}m%}"
done

# Show all 256 colors with color number
function spectrum_ls() {
  setopt localoptions nopromptsubst
  local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}
  for code in {000..255}; do
    print -P -- "$code: ${FG[$code]}${ZSH_SPECTRUM_TEXT}%{$reset_color%}"
  done
}

# Show all 256 colors where the background is set to specific color
function spectrum_bls() {
  setopt localoptions nopromptsubst
  local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}
  for code in {000..255}; do
    print -P -- "$code: ${BG[$code]}${ZSH_SPECTRUM_TEXT}%{$reset_color%}"
  done
}
