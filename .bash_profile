# Author: Folkert-Jan van der Pol
# Sources:
# https://www.maketecheasier.com/8-useful-and-interesting-bash-prompts/
# http://www.terminally-incoherent.com/blog/2013/01/14/whats-in-your-bash-prompt/

# Welcome message
echo -e "\n Buenos dias, $USER!"

# === Colors === #
Color_Off="\033[0m"

Red="\033[0;31m"
Red_light="\033[1;31m"
Green="\033[0;32m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
Cyan_light="\033[1;36m"
Yellow="\033[1;33m"

# Main color is for the name part of the prompt
Color_main=$Cyan_light
# Secondary color is for the current directory path part of the prompt
Color_sec=$Cyan
# Text color is for the commands you write and messages that get echoed
Color_text=$Color_Off

# change these values to change wat color the emoji or character will have that shows when you execute a good / bad command
Color_good_command=$Green
Color_bad_command=$Red_light

Color_ssh=$Yellow

# change these values to change how the [git info] part of your prompt looks
Color_git_clean=$Green
Color_git_untracked=$Purple
Color_git_dirty=$Red_light


# === Emoji's === #
Emoji_good=" ✔ "
Emoji_bad=" ✖ "

# === Command Prompt Setup === #
# set up command prompt
function __prompt_command() {
	# capture the exit status of the last command
	EXIT="$?"
	PS1="\n\[$Color_main\][\[$Color_sec\]\w\[$Color_main\]]\n"
	if [ $EXIT -eq 0 ]; then
        # if good command was executed, show good emoji and color
		PS1+="[\!]\[$Color_good_command\][$Emoji_good]\[$Color_main\] ";
	else
        # if bad command was executed, show bad emoji and color
		PS1+="[\!]\[$Color_bad_command\][$Emoji_bad]\[$Color_main\] ";
	fi
	# if logged in via ssh, shows the ip of the client
	if [ -n "$SSH_CLIENT" ]; then
		PS1+="\[$Color_ssh\]("${$SSH_CLIENT%% *}")\[$Color_main\]";
	fi
	# debian chroot stuff (take it or leave it)
	PS1+="${debian_chroot:+($debian_chroot)}"
	# basic information (user@host:path)
	PS1+="- \u@\h: "
	# check if inside git repo
	local git_status="`git status -unormal 2>&1`"
	if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
		# parse the porcelain output of git status
		if [[ "$git_status" =~ nothing\ to\ commit ]]; then
			local Color_On=$Color_git_clean
		elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
			local Color_On=$Color_git_untracked
		else
			local Color_On=$Color_git_dirty
		fi
		if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
			branch=${BASH_REMATCH[1]}
		else
			# Detached HEAD. (branch=HEAD is a faster alternative.)
			branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
		fi
		# add the result to prompt
		PS1+="\[$Color_On\][$branch]\[$Color_main\] "
	fi
	# prompt $ or # for root
	PS1+="\$ \[$Color_text\]"
}

# === Export Command Prompt === #
PROMPT_COMMAND=__prompt_command


# if aliases were made, run them.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
