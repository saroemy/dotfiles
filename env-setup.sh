#!/bin/bash

# Lista dei pacchetti da installare
PACCHETTI=("ripgrep" "fzf" "fd" "neovim" "git" "tmux" "gzip" "build-essential")

# Colori per output
VERDE='\033[0;32m'
ROSSO='\033[0;31m'
GIALLO='\033[1;33m'
RESET='\033[0m'

# Funzione per stampare messaggi colorati
stampa_ok() {
    echo -e "${VERDE}✓${RESET} $1"
}

stampa_errore() {
    echo -e "${ROSSO}✗${RESET} $1"
}

stampa_info() {
    echo -e "${GIALLO}ℹ${RESET} $1"
}

# Funzione per verificare se un comando esiste
comando_esiste() {
    command -v "$1" &>/dev/null
}

# Funzione per installare un pacchetto su macOS
installa_mac() {
    pacchetto=$1

    if ! comando_esiste brew; then
        stampa_errore "Homebrew non installato. Installazione in corso..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        if ! comando_esiste brew; then
            stampa_errore "Installazione Homebrew fallita"
            exit 1
        fi
    fi

    stampa_info "Installazione $pacchetto con Homebrew..."
    brew install "$pacchetto"
}

# Funzione per installare un pacchetto su Linux
installa_linux() {
    pacchetto=$1

    # Alcuni pacchetti hanno nomi diversi su apt
    case "$pacchetto" in
    "fd")
        pacchetto_apt="fd-find"
        ;;
    *)
        pacchetto_apt="$pacchetto"
        ;;
    esac

    if comando_esiste apt; then
        # Se è neovim, aggiungi il PPA unstable prima
        if [ "$pacchetto" = "neovim" ]; then
            stampa_info "Aggiunta PPA unstable di Neovim..."
            sudo add-apt-repository ppa:neovim-ppa/unstable -y
        fi

        stampa_info "Installazione $pacchetto con apt..."
        sudo apt update -qq
        sudo apt install "$pacchetto_apt" -y

    elif comando_esiste dnf; then
        stampa_info "Installazione $pacchetto con dnf..."
        sudo dnf install "$pacchetto" -y

    elif comando_esiste yum; then
        stampa_info "Installazione $pacchetto con yum..."
        sudo yum install "$pacchetto" -y

    elif comando_esiste pacman; then
        stampa_info "Installazione $pacchetto con pacman..."
        sudo pacman -S "$pacchetto" --noconfirm

    else
        stampa_errore "Package manager non supportato"
        exit 1
    fi
}

# Funzione per installare un pacchetto (cross-platform)
installa_pacchetto() {
    pacchetto=$1

    if [[ "$OSTYPE" == "darwin"* ]]; then
        installa_mac "$pacchetto"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        installa_linux "$pacchetto"
    else
        stampa_errore "Sistema operativo non supportato: $OSTYPE"
        exit 1
    fi
}

# Funzione per verificare e installare un pacchetto
verifica_e_installa() {
    pacchetto=$1

    # Alcuni comandi hanno nomi diversi dal pacchetto
    comando="$pacchetto"
    case "$pacchetto" in
    "neovim")
        comando="nvim"
        ;;
    "fd")
        if [[ "$OSTYPE" == "linux-gnu"* ]] && comando_esiste fdfind; then
            comando="fdfind"
        fi
        ;;
    esac

    if comando_esiste "$comando"; then
        stampa_ok "$pacchetto è già installato"
    else
        stampa_info "$pacchetto non trovato"
        installa_pacchetto "$pacchetto"

        if comando_esiste "$comando"; then
            stampa_ok "$pacchetto installato con successo!"
        else
            stampa_errore "Installazione $pacchetto fallita"
            return 1
        fi
    fi
}

# Funzione per chiedere installazione pacchetti opzionali
chiedi_installazione_opzionali() {
    echo ""
    echo "============================================"
    echo "  Installazione pacchetti opzionali"
    echo "============================================"
    echo ""

    # Chiedi per Python
    read -p "Vuoi installare Python3 con pip e venv? (s/N): " risposta_python
    if [[ "$risposta_python" =~ ^[Ss]$ ]]; then
        INSTALLA_PYTHON=true
    else
        INSTALLA_PYTHON=false
    fi

    # Chiedi per Node.js
    read -p "Vuoi installare Node.js e npm? (s/N): " risposta_nodejs
    if [[ "$risposta_nodejs" =~ ^[Ss]$ ]]; then
        INSTALLA_NODEJS=true
    else
        INSTALLA_NODEJS=false
    fi
}

# Funzione per installare Python e dipendenze
installa_python() {
    echo ""
    stampa_info "Installazione Python3, pip e venv..."

    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install python3
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if comando_esiste apt; then
            sudo apt update -qq
            sudo apt install python3 python3-pip python3-venv -y
        elif comando_esiste dnf; then
            sudo dnf install python3 python3-pip python3-virtualenv -y
        elif comando_esiste yum; then
            sudo yum install python3 python3-pip -y
        elif comando_esiste pacman; then
            sudo pacman -S python python-pip --noconfirm
        fi
    fi

    if comando_esiste python3; then
        stampa_ok "Python3 installato: $(python3 --version)"
    else
        stampa_errore "Installazione Python3 fallita"
    fi
}

# Funzione per installare Node.js e npm
installa_nodejs() {
    echo ""
    stampa_info "Installazione Node.js e npm..."

    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install node
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if comando_esiste apt; then
            sudo apt update -qq
            sudo apt install nodejs npm -y
        elif comando_esiste dnf; then
            sudo dnf install nodejs npm -y
        elif comando_esiste yum; then
            sudo yum install nodejs npm -y
        elif comando_esiste pacman; then
            sudo pacman -S nodejs npm --noconfirm
        fi
    fi

    if comando_esiste node; then
        stampa_ok "Node.js installato: $(node --version)"
        comando_esiste npm && echo "  npm: $(npm --version)"
    else
        stampa_errore "Installazione Node.js fallita"
    fi
}

# Funzione per configurare vim mode in bashrc
configura_vim_mode_bash() {
    echo ""
    stampa_info "Configurazione vim mode in bashrc..."

    BASHRC="$HOME/.bashrc"

    # Crea bashrc se non esiste
    touch "$BASHRC"

    # Controlla se la configurazione vim mode è già presente
    if grep -q "# Abilita vim mode" "$BASHRC"; then
        stampa_info "Configurazione vim mode già presente in .bashrc"
        return 0
    fi

    # Aggiungi configurazione vim mode
    cat >> "$BASHRC" << 'EOF'

# Abilita vim mode
set -o vi

# Mostra il mode nel prompt (opzionale)
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string "\1\e[6 q\2"'
bind 'set vi-cmd-mode-string "\1\e[2 q\2"'

# Serve a impostare come editor predefinito neovim per la vi mode di bash, cisto che premendo v apre l'editor predefinito
export VISUAL=nvim
export EDITOR=nvim
EOF

    stampa_ok "Vim mode configurato in $BASHRC"
    stampa_info "Riavvia il terminale o esegui: source ~/.bashrc"
}

# Funzione per clonare i dotfiles e creare i symlink
setup_configurazioni() {
    echo ""
    echo "============================================"
    echo "  Configurazione dotfiles"
    echo "============================================"
    echo ""

    REPO_URL="https://github.com/saroemy/dotfiles.git"
    REPO_DIR="$HOME/.dotfiles"

    # Controlla se git è installato
    if ! comando_esiste git; then
        stampa_errore "Git non installato. Impossibile clonare repository."
        return 1
    fi

    # Clona il repo in ~/.dotfiles, o aggiornalo se già presente
    if [ -d "$REPO_DIR" ]; then
        stampa_info "Repository già presente in $REPO_DIR, aggiornamento..."
        git -C "$REPO_DIR" pull --ff-only || stampa_info "Pull non riuscito, uso la versione locale"
    else
        stampa_info "Clonazione repository da $REPO_URL..."
        if git clone "$REPO_URL" "$REPO_DIR"; then
            stampa_ok "Repository clonata in $REPO_DIR"
        else
            stampa_errore "Errore durante la clonazione"
            return 1
        fi
    fi

    # Symlink, TPM e preparazione ambiente sono delegati a setup.sh
    bash "$REPO_DIR/setup.sh"
}

# Main: esecuzione principale
main() {
    echo "============================================"
    echo "  Installazione pacchetti sviluppo"
    echo "============================================"
    echo ""

    # Rileva sistema operativo
    if [[ "$OSTYPE" == "darwin"* ]]; then
        stampa_info "Sistema: macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        stampa_info "Sistema: Linux"
    else
        stampa_errore "Sistema non supportato: $OSTYPE"
        exit 1
    fi

    echo ""

    # Installa ogni pacchetto
    for pacchetto in "${PACCHETTI[@]}"; do
        verifica_e_installa "$pacchetto"
    done

    echo ""
    echo "============================================"
    stampa_ok "Installazione pacchetti completata!"
    echo "============================================"

    # Mostra versioni installate
    echo ""
    echo "Versioni installate:"
    comando_esiste rg && echo "  ripgrep: $(rg --version | head -n1)"
    comando_esiste fzf && echo "  fzf: $(fzf --version)"
    comando_esiste fd && echo "  fd: $(fd --version)"
    comando_esiste fdfind && echo "  fd: $(fdfind --version)"
    comando_esiste nvim && echo "  neovim: $(nvim --version | head -n1)"
    comando_esiste git && echo "  git: $(git --version)"
    comando_esiste tmux && echo "  tmux: $(tmux -V)"

    # Chiedi per pacchetti opzionali
    chiedi_installazione_opzionali

    # Installa Python se richiesto
    if [ "$INSTALLA_PYTHON" = true ]; then
        installa_python
    fi

    # Installa Node.js se richiesto
    if [ "$INSTALLA_NODEJS" = true ]; then
        installa_nodejs
    fi

    # Setup configurazioni (symlink e TPM via setup.sh)
    setup_configurazioni

    # Configura vim mode in bashrc
    configura_vim_mode_bash

    echo ""
    echo "============================================"
    stampa_ok "Setup completato!"
    echo "============================================"
}

# Esegui il main
main
