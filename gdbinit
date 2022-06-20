
# customize prompt.
# set prompt \033[1;32m > \033[m

# save gdb history
set history save on

# Do not print addresses when displaying their contents
# set print address off

# Cause GDB to print structures in an indented format with one member per line
# particulary usefull when printing vtkObject
set print pretty on

# When displaying a pointer to an object, identify the actual (derived) type of the object rather than the declared type, using the virtual function table.
set print object on

define skip
    tbreak +1
    jump +1
end
