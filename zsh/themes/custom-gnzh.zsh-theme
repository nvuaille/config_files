# Based on bira theme

function python_env_prompt_info() {
    if [[ $CONDA_DEFAULT_ENV ]]; then
      # echo "%B(${CONDA_DEFAULT_ENV})%b"
      echo "${CONDA_ENV_PREFIX}${CONDA_DEFAULT_ENV}${CONDA_ENV_SUFFIX}"
    fi
}


local CONDA_ENV_PREFIX="%B("
local CONDA_ENV_SUFFIX=")%b"

setopt prompt_subst

() {

# local CONDA_ENV_PREFIX CONDA_ENV_SUFFIX
local PR_USER PR_USER_OP PR_PROMPT PR_HOST

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%F{green}%n%f'
  PR_USER_OP='%F{green}%#%f'
  PR_PROMPT='%f➤ %f'
else # root
  PR_USER='%F{red}%n%f'
  PR_USER_OP='%F{red}%#%f'
  PR_PROMPT='%F{red}➤ %f'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{red}%M%f' # SSH
else
  PR_HOST='%F{green}%M%f' # no SSH
fi


local return_code="%(?..%F{red}%? ↵%f)"

local user_host="${PR_USER}%F{cyan}@${PR_HOST}"
local current_dir="%B%F{cyan}%~%f%b"
local git_branch='$(git_prompt_info)'
local env_name='$(python_env_prompt_info)'

PROMPT="╭─${user_host} ${current_dir} \$(ruby_prompt_info) ${git_branch} ${env_name}
╰─$PR_PROMPT "
RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %f"
ZSH_THEME_RUBY_PROMPT_PREFIX="%F{red}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%f"

}
