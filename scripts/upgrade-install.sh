#!/bin/bash

# ------- LARGE Banner display section start

function print_separator {
    printf "\n%s\n" "--------------------------------------------------------------------------------"
}

function print_header {
    figlet -c -f slant "$1"
    print_separator
}

# --------------- LArge Banner display Section end --------------

# Displaying Screen message in color  Start

# Detection in Yellow color
function print_init {
    local message="$1"
    printf "\e[33m%s\e[0m\n" "$message"  
}

# Intermediate in Blue color
function print_intermediate {
    local message="$1"
    printf "\e[34m%s\e[0m\n" "$message"  
}

# Completion in Green color
function print_success {
    local message="$1"
    printf "\e[1m\e[32m%s\e[0m\n" "$message"  
    print_separator
}

# Failures in Red color
function print_fail {
    local message="$1"
    printf "\e[1m\e[31m%s\e[0m\n" "$message"  
    print_separator
}

# -------------Displaying Screen message in color  end ----------------


# ---------- Package installation and Upgrade start -------------

install_and_upgrade_figlet() {
    os_description=$(lsb_release -a 2>/dev/null | grep "Description:" | awk -F'\t' '{print $2}')
    print_init "$os_description Detected on your system"
    printf "\n"
    print_intermediate "Installing Figlet"
    print_separator

    if grep -q 'Ubuntu' /etc/os-release; then
        sudo apt-get update
        sudo apt-get install -y figlet
        print_separator

        if [ $? -eq 0 ]; then
            print_success "Figlet is now installed"  
        else
            print_fail "Failed to install Figlet"  
        fi

    elif grep -qEi 'redhat|centos' /etc/os-release; then
        sudo yum update
        sudo yum -y install figlet
        print_separator
        if [ $? -eq 0 ]; then
            print_success "Figlet is now installed"  
        else
            print_fail "Failed to install Figlet"  
        fi

    elif grep -q 'Amazon Linux 2' /etc/os-release || grep -q 'Amazon Linux 3' /etc/os-release; then
        sudo amazon-linux-extras install epel -y
        sudo yum update
        sudo yum -y install figlet
        print_separator
        if [ $? -eq 0 ]; then
            print_success "Figlet is now installed"  
        else
            print_fail "Failed to install Figlet"  
        fi
    else
        print_fail "Unsupported Linux distribution"  
        exit 1
    fi
}

    os_description=$(lsb_release -a 2>/dev/null | grep "Description:" | awk -F'\t' '{print $2}')
    print_init "$os_description OS is detected on your system."
    print_intermediate "\nInstalling Nginx\n"
    print_separator
    if grep -q 'Ubuntu' /etc/os-release; then
        sudo apt-get update
        sudo apt-get install -y nginx
        if [ $? -eq 0 ]; then
            print_success "Nginx is now installed"
        else
            print_fail "Failed to install Nginx"
        fi
    elif grep -qEi 'redhat|centos' /etc/os-release; then
        sudo yum update
        sudo yum -y install nginx
        if [ $? -eq 0 ]; then
            print_success "Nginx is now installed"
        else
            print_fail "Failed to install Nginx"
        fi
    else
        print_fail "Unsupported Linux distribution"
        exit 1
    fi
}

main() {
    install_figlet
    install_nginx
}

main