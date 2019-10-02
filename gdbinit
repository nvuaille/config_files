
# customize prompt.
set prompt \033[1;32m > \033[m

# save gdb history
set history save on

# Do not print addresses when displaying their contents
# set print address off

# Cause GDB to print structures in an indented format with one member per line
# particulary usefull when printing vtkObject
set print pretty on

# When displaying a pointer to an object, identify the actual (derived) type of the object rather than the declared type, using the virtual function table.
set print object on


# -----------------------------------------------
# Define bt-colors, that print a colored backtrace
# no more needed

# Script from https://github.com/RAttab/dotfiles/blob/master/colors.gdb
define setup-color-pipe
    shell rm -f /tmp/gdb-color-pipe
    set logging file /tmp/gdb-color-pipe
    set logging redirect on
    set logging on
    set logging off
    set logging on
end

define cleanup-color-pipe
    set logging off
    set logging redirect off
    #shell rm -f /tmp/gdb-color-pipe
end


define do-generic-colors
    # Use tput to add colors and formatting
    # Five regex to find following blocks:
    # 1. Function names and the class they belong to
    # 2. Function argument names
    # 3. Stack frame number
    # 4. Thread id colorization
    # 5. File path and line number
    shell cat /tmp/gdb-color-pipe | \
        sed -r "s_([^<])([a-zA-Z0-9_]+::)?([a-zA-Z0-9_\.@]+)( ?)\(_\1$(tput setaf 6)$(tput bold)\2$(tput sgr0)$(tput setaf 6)\3\4$(tput sgr0)(_g" | \
        sed -r "s_([a-zA-Z0-9_#]*)=_$(tput setaf 7)$(tput bold)\1$(tput sgr0)=_g" | \
        sed -r "s_^(#[0-9]*)_$(tput setaf 7)\1$(tput sgr0)_" | \
        sed -r "s_^([ \*]) ([0-9]+)_$(tput bold)$(tput setaf 6)\1 $(tput setaf 1)\2$(tput sgr0)_" | \
        sed -r "s_(\.*[/A-Za-z0-9\+_\.\-]*\/)([^:]*):([0-9]+)\$_$(tput setaf 3)\1$(tput smul)\2$(tput rmul):\3$(tput sgr0)_"
end

define bt-colors
    setup-color-pipe
    bt
    do-generic-colors
    cleanup-color-pipe
end
# -----------------------------------------------
