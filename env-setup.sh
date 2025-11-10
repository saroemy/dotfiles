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

# Funzione per installare TPM (Tmux Plugin Manager)
installa_tpm() {
    echo ""
    stampa_info "Installazione TPM (Tmux Plugin Manager)..."

    TPM_DIR="$HOME/.tmux/plugins/tpm"

    # Rimuovi directory esistente se presente
    if [ -d "$TPM_DIR" ]; then
        stampa_info "TPM già presente, aggiornamento..."
        rm -rf "$TPM_DIR"
    fi

    # Clona TPM
    if git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"; then
        stampa_ok "TPM installato in $TPM_DIR"
    else
        stampa_errore "Errore durante l'installazione di TPM"
        return 1
    fi
}

# Funzione per installare tema Catppuccin per Tmux
installa_tema_tmux() {
    echo ""
    stampa_info "Installazione tema Catppuccin per Tmux..."

    CATPPUCCIN_DIR="$HOME/.config/tmux/plugins/catppuccin"

    # Crea directory se non esiste
    mkdir -p "$CATPPUCCIN_DIR"

    # Rimuovi tema esistente se presente
    if [ -d "$CATPPUCCIN_DIR/tmux" ]; then
        stampa_info "Tema Catppuccin già presente, aggiornamento..."
        rm -rf "$CATPPUCCIN_DIR/tmux"
    fi

    # Clona tema Catppuccin versione v2.1.3
    if git clone -b v2.1.3 https://github.com/catppuccin/tmux.git "$CATPPUCCIN_DIR/tmux"; then
        stampa_ok "Tema Catppuccin installato in $CATPPUCCIN_DIR/tmux"
    else
        stampa_errore "Errore durante l'installazione del tema Catppuccin"
        return 1
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

# Funzione per clonare e configurare dotfiles
setup_configurazioni() {
    echo ""
    echo "============================================"
    echo "  Configurazione Neovim e Tmux"
    echo "============================================"
    echo ""

    # Directory configurazioni
    REPO_URL="https://github.com/saroemy/dotfiles.git"
    REPO_DIR="$HOME/dotfiles"
    NVIM_CONFIG_DIR="$HOME/.config/nvim"
    TMUX_CONFIG_DIR="$HOME/.config/tmux"

    # Controlla se git è installato
    if ! comando_esiste git; then
        stampa_errore "Git non installato. Impossibile clonare repository."
        return 1
    fi

    # Rimuovi repository esistente se presente
    if [ -d "$REPO_DIR" ]; then
        stampa_info "Repository esistente trovata in $REPO_DIR"
        stampa_info "Rimozione repository vecchia..."
        rm -rf "$REPO_DIR"
    fi

    # Clona repository nella home
    stampa_info "Clonazione repository da $REPO_URL..."
    if git clone "$REPO_URL" "$REPO_DIR"; then
        stampa_ok "Repository clonata in $REPO_DIR"
    else
        stampa_errore "Errore durante la clonazione"
        return 1
    fi

    # === SETUP NEOVIM ===
    echo ""
    stampa_info "Setup configurazione Neovim..."

    # Verifica che esista la cartella nvim nella repo
    if [ ! -d "$REPO_DIR/nvim" ]; then
        stampa_errore "Cartella nvim non trovata nella repository"
        return 1
    fi

    # Backup configurazione Neovim esistente
    if [ -d "$NVIM_CONFIG_DIR" ]; then
        backup_nvim="$NVIM_CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
        stampa_info "Backup configurazione Neovim esistente in $backup_nvim"
        mv "$NVIM_CONFIG_DIR" "$backup_nvim"
    fi

    # Crea directory .config se non esiste
    mkdir -p "$HOME/.config"

    # Copia cartella nvim in .config
    cp -r "$REPO_DIR/nvim" "$NVIM_CONFIG_DIR"
    stampa_ok "Configurazione Neovim installata in $NVIM_CONFIG_DIR"

    # === SETUP TMUX ===
    echo ""
    stampa_info "Setup configurazione Tmux..."

    # Verifica che esista il file tmux.conf nella repo
    if [ ! -f "$REPO_DIR/tmux.conf" ]; then
        stampa_errore "File tmux.conf non trovato nella repository"
        return 1
    fi

    # Crea directory tmux se non esiste
    mkdir -p "$TMUX_CONFIG_DIR"

    # Backup configurazione Tmux esistente
    if [ -f "$TMUX_CONFIG_DIR/tmux.conf" ]; then
        backup_tmux="$TMUX_CONFIG_DIR/tmux.conf.backup.$(date +%Y%m%d_%H%M%S)"
        stampa_info "Backup configurazione Tmux esistente in $backup_tmux"
        mv "$TMUX_CONFIG_DIR/tmux.conf" "$backup_tmux"
    fi

    # Copia file tmux.conf
    cp "$REPO_DIR/tmux.conf" "$TMUX_CONFIG_DIR/tmux.conf"
    stampa_ok "Configurazione Tmux installata in $TMUX_CONFIG_DIR/tmux.conf"

    # === PULIZIA ===
    echo ""
    stampa_info "Repository clonata mantenuta in $REPO_DIR"
    stampa_info "Puoi rimuoverla con: rm -rf $REPO_DIR"

    echo ""
    stampa_ok "Configurazioni installate!"
    stampa_info "Neovim config: $NVIM_CONFIG_DIR"
    stampa_info "Tmux config: $TMUX_CONFIG_DIR/tmux.conf"
    echo ""
    stampa_info "Avvia Neovim con: nvim"
    stampa_info "Avvia Tmux con: tmux"
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

    # Setup configurazioni
    setup_configurazioni

    # Installa TPM (Tmux Plugin Manager)
    installa_tpm

    # Installa tema Catppuccin per Tmux
    installa_tema_tmux

    # Configura vim mode in bashrc
    configura_vim_mode_bash

    echo ""
    echo "============================================"
    stampa_ok "Setup completato!"
    echo "============================================"
}

# Esegui il main
main
