# Add one or more variables to WSLENV, ensuring uniqueness.
# Usage: add_wslenv VARSPEC [VARSPEC...]
# Example: add_wslenv "PATH/u" "BROWSER/p"
function add_wslenv
    argparse h/help -- $argv

    if set -ql _flag_help
        echo "Usage: add_wslenv VARSPEC [...]"
        echo "Adds entries to WSLENV if not already present."
        return 0
    end

    set -l entries
    if test -n "$WSLENV"
        set entries (string split ';' -- $WSLENV)
    end

    for spec in $argv
        if not contains $spec $entries
            set -a entries $spec
        end
    end

    set -x WSLENV (string join ';' $entries)
end
