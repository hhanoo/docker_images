WORKSPACE="/root/workspace/POC_Korea_Mecha"

# Commands
start() {
    cd "$WORKSPACE" || return 1
    PYTHONPATH="$WORKSPACE:$PYTHONPATH" python3 app/machine_tending_system.py
}

cmd_help() {
    printf "\n[POC_Korea_Mecha] Commands:\n"
    printf "  %-10s - %s\n" "start" "run machine_tending_system"
    echo
}

# ===== Show help on interactive shell =====
case $- in
    *i*) cmd_help ;;
esac
