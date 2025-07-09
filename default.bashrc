# ~/.bashrc - Minimal default configuration

# Only run for interactive shells
case $- in
    *i*) ;;
    *) return ;;
esac

# Basic prompt
PS1='\u@\h:\w\$ '