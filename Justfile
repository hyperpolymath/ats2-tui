
# Synchronize A2ML metadata to SCM (Shadow Sync)
sync-metadata:
    #!/usr/bin/env bash
    echo "Synchronizing metadata (A2ML -> SCM)..."
    if [ -f .machine_readable/STATE.a2ml ]; then
        COMPLETION=$(grep "completion-percentage:" .machine_readable/STATE.a2ml | awk '{print $2}')
        sed -i "s/(overall-completion [0-9]\+)/(overall-completion $COMPLETION)/" .machine_readable/STATE.scm
        echo "✓ Metadata synchronized"
    fi
