# Set Fisher installation path
set fisher_path ~/.local/share/fisher

# Prepend Fisher's completions directory to fish's completion path
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]

# Prepend Fisher's functions directory to fish's function path
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

# Source all Fish scripts in Fisher's conf.d directory
for file in $fisher_path/conf.d/*.fish
    source $file
end
