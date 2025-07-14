#!/bin/bash

# Improved system update script following modern best practices

# Check if we're running in bash and pipefail is supported
if [ -n "${BASH_VERSION:-}" ]; then
    set -euo pipefail  # Exit on error, undefined vars, pipe failures
else
    set -eu  # Exit on error, undefined vars (pipefail not supported in sh)
fi

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)" 
   exit 1
fi

# Function to print status messages
print_status() {
    echo "===== $1 ====="
}

# Function to handle errors
handle_error() {
    echo "ERROR: $1" >&2
    exit 1
}

# Wait for other package operations to complete instead of forcing lock removal
wait_for_lock() {
    local max_wait=300  # 5 minutes
    local count=0
    
    while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do
        if [ $count -ge $max_wait ]; then
            handle_error "Timeout waiting for other package operations to complete"
        fi
        echo "Waiting for other package operations to complete..."
        sleep 1
        ((count++))
    done
}

print_status "Waiting for any running package operations to complete"
wait_for_lock

print_status "Updating package lists"
apt update || handle_error "Failed to update package lists"

print_status "Upgrading packages"
apt upgrade -y || handle_error "Failed to upgrade packages"

print_status "Performing distribution upgrade"
apt full-upgrade -y || handle_error "Failed to perform distribution upgrade"

print_status "Removing unnecessary packages"
apt autoremove -y || handle_error "Failed to remove unnecessary packages"

print_status "Cleaning package cache"
apt autoclean -y || handle_error "Failed to clean package cache"

print_status "System update completed successfully!"

# Optional: Show some system info
echo ""
echo "System Information:"
echo "- Kernel: $(uname -r)"
echo "- OS: $(lsb_release -d -s 2>/dev/null || echo 'Unknown')"
echo "- Uptime: $(uptime -p 2>/dev/null || uptime)"
