# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git asdf zsh-autosuggestions fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim"
alias be="bundle exec"
alias gclean="git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D"
alias mycaselogin="aws sso login --profile devresource"
alias pumakill="pkill -9 -f puma-dev"
alias pumarestart="puma-dev -stop"

export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/.asdf/installs/python/3.10.0/bin"
export EDITOR='nvim'
export THOR_MERGE='nvim'

eval "#(/opt/homebrew/bin/brew shellenv)"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

export ASDF_DIR=/opt/homebrew/opt/asdf/libexec
. /opt/homebrew/opt/asdf/libexec/asdf.sh

function change_db_port {
  local OLD_PORT=$1
  local NEW_PORT=$2

  echo Switching from $OLD_PORT to $NEW_PORT

  find ./services -type f -name '.env.local' -exec sed -i '' "s/$OLD_PORT/$NEW_PORT/g" {} \;
}

function create_service_migration {
  local SERVICE_NAME=$1
  local MIGRATION_NAME=$2

  if [[ "$(pwd)" == *$SERVICE_NAME* ]]; then
    echo Creating migration for $SERVICE_NAME
    echo Migration name: $MIGRATION_NAME

    docker compose -f compose-dev.yml --env-file=./../.env run -i $SERVICE_NAME npx prisma migrate dev  --create-only --schema=services/$SERVICE_NAME/prisma/schema.prisma -n $MIGRATION_NAME
  else
    echo Check your current directory. You should be in the $SERVICE_NAME directory
  fi
}

function run_service_migrations {
  local SERVICE_NAME=$1

  if [[ "$(pwd)" == *$SERVICE_NAME* ]]; then
    echo Running migrations for $SERVICE_NAME

    docker compose -f compose-dev.yml --env-file=./../.env run -i $SERVICE_NAME npx prisma migrate dev --schema=services/$SERVICE_NAME/prisma/schema.prisma
  else
    echo Check your current directory. You should be in the $SERVICE_NAME directory
  fi
}
export BITBUCKET_HTTPS=1
