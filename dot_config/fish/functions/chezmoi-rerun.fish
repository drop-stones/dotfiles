# Reset chezmoi state and re-run init + update
function chezmoi-rerun --description "Reset chezmoi state and re-run init + update"
    if not chezmoi state reset --force
        echo "chezmoi-rerun failed: state reset" >&2
        return 1
    end

    if not chezmoi init
        echo "chezmoi-rerun failed: init" >&2
        return 1
    end

    if not chezmoi apply
        echo "chezmoi-rerun failed: update" >&2
        return 1
    end
end
