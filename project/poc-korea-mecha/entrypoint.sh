#!/bin/bash
set -e

WORKSPACE="/root/workspace/POC_Korea_Mecha"

# Install editable packages if not already installed
if ! python3 -c "import ketisdk" 2>/dev/null; then
    echo "Installing ketisdk..."
    pip install -e "$WORKSPACE/modules/ketisdk"
fi

if ! python3 -c "import kpick" 2>/dev/null; then
    echo "Installing kpick_devel..."
    pip install -e "$WORKSPACE/modules/kpick_devel"
fi

# Write aliases to a file so the exec'd shell can source them
ALIAS_FILE="/etc/poc_korea_mecha_aliases.sh"
cat > "$ALIAS_FILE" << ALIASEOF
export PYTHONPATH=\$PYTHONPATH:$WORKSPACE
alias start='cd $WORKSPACE && python3 app/machine_tending_system.py'
ALIASEOF

# Ensure root's .bashrc sources the alias file (once)
if [ -w /root/.bashrc ]; then
    grep -q 'poc_korea_mecha_aliases' /root/.bashrc 2>/dev/null || \
        echo '[ -f /etc/poc_korea_mecha_aliases.sh ] && source /etc/poc_korea_mecha_aliases.sh' >> /root/.bashrc
fi

exec "$@"
