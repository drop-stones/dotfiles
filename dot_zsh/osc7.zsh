# Ref: https://github.com/wez/wezterm/discussions/3718
function url_encode() {
	local length="${#1}"
	for (( i = 0; i < length; i++ )); do
		local c="${1:$i:1}"
		case $c in
			%) printf '%%%02X' "'$c" ;;
			*) printf "%s" "$c" ;;
		esac
	done
}

function osc7_cwd(){
		printf "\e]7;file://%s%s\e\\" "$HOSTNAME" '$(url_encode "$PWD")'
}

precmd_functions+=(osc7_cwd)
