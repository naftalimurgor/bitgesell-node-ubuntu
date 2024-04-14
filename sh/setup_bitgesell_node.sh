#!/bin/bash

# Function to display menu and get user input
display_menu() {
    echo "Bitgesell Node Setup Script"
    echo "1. Install Bitgesell Node (Non-GUI)"
    echo "2. Install Bitgesell Node (GUI)"
    echo "3. Exit"
    read -p "Enter your choice: " choice
}

# Function to select Bitgesell version
select_version() {
    echo "Select Bitgesell version:"
    echo "1. 0.1.10"
    echo "2. 0.1.11"
    echo "3. 0.1.9"
    read -p "Enter your choice: " version_choice

    case $version_choice in
        1)
            VERSION="0.1.10"
            ;;
        2)
            VERSION="0.1.11"
            ;;
        3)
            VERSION="0.1.9"
            ;;
        *)
            echo "Invalid version. Exiting..."
            exit 1
            ;;
    esac
}

# Function to install Bitgesell Node (Non-GUI)
install_bgld() {
    echo "Installing Bitgesell Node (Non-GUI)..."
    # Download and install Bitgesell Node (bgld)
    cd /tmp/
    wget https://github.com/BitgesellOfficial/bitgesell/releases/download/${VERSION}/bitgesell_${VERSION}_amd64.deb
    wget http://ports.ubuntu.com/pool/main/p/perl/perl-modules-5.30_5.30.0-9build1_all.deb
    dpkg -i perl-modules-5.30_5.30.0-9build1_all.deb
    dpkg -i bitgesell_${VERSION}_amd64.deb
    apt-get install -y -f
    apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    # Start BGLd daemon
    BGLd &
}

# Function to install Bitgesell Node (GUI)
install_gui() {
    echo "Installing Bitgesell Node (GUI)..."
    # Download and install Bitgesell Node (bgld with GUI)
    cd /tmp/
    wget https://github.com/BitgesellOfficial/bitgesell/releases/download/${VERSION}/bitgesell-qt_${VERSION}_amd64.deb
    wget http://ports.ubuntu.com/pool/main/p/perl/perl-modules-5.30_5.30.0-9build1_all.deb
    dpkg -i perl-modules-5.30_5.30.0-9build1_all.deb
    dpkg -i bitgesell-qt_${VERSION}_amd64.deb
    apt-get install -y -f
    apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    # Start Bitgesell Node with GUI
    bitgesell-qt &
}

# Install necessary dependencies
echo "Installing dependencies..."
apt update
apt install -y --no-install-recommends \
    libatomic1 \
    wget \
    ca-certificates \
    apt-transport-https

# Main script logic
select_version
while true; do
    display_menu
    case $choice in
        1)
            install_bgld
            ;;
        2)
            install_gui
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please select again."
            ;;
    esac
done
