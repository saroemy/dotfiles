#!/bin/bash

# Setup dell'ambiente: crea i symlink dalle posizioni di sistema verso questa
# cartella e prepara tmux/ghostty/zsh. Il repo deve trovarsi in ~/.dotfiles.
# Idempotente: si può rilanciare ogni volta che si aggiunge una config.

DOTFILES="$HOME/.dotfiles"

# Colori per output
VERDE='\033[0;32m'
ROSSO='\033[0;31m'
GIALLO='\033[1;33m'
RESET='\033[0m'

stampa_ok() {
    echo -e "${VERDE}✓${RESET} $1"
}

stampa_errore() {
    echo -e "${ROSSO}✗${RESET} $1"
}

stampa_info() {
    echo -e "${GIALLO}ℹ${RESET} $1"
}

if [ ! -d "$DOTFILES" ]; then
    stampa_errore "Cartella $DOTFILES non trovata: clona il repo lì prima di lanciare lo script"
    exit 1
fi

# crea_symlink <sorgente> <destinazione>
# - se il link è già giusto non fa nulla
# - se la destinazione è un file identico alla sorgente lo sostituisce senza backup
# - altrimenti fa il backup di ciò che trova e crea il link
crea_symlink() {
    local sorgente=$1
    local dest=$2

    if [ ! -e "$sorgente" ]; then
        stampa_errore "Sorgente mancante: $sorgente"
        return 1
    fi

    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$sorgente" ]; then
        stampa_ok "$dest (già collegato)"
        return 0
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ -f "$dest" ] && [ ! -L "$dest" ] && cmp -s "$sorgente" "$dest"; then
            rm "$dest"
        else
            local backup="$dest.backup.$(date +%Y%m%d_%H%M%S)"
            stampa_info "Backup di $dest in $backup"
            mv "$dest" "$backup"
        fi
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$sorgente" "$dest"
    stampa_ok "$dest → $sorgente"
}

echo "============================================"
echo "  Symlink delle configurazioni"
echo "============================================"

crea_symlink "$DOTFILES/nvim" "$HOME/.config/nvim"
crea_symlink "$DOTFILES/ghostty" "$HOME/.config/ghostty"
# Solo il file, non la cartella: in ~/.config/tmux vivono anche i plugin
crea_symlink "$DOTFILES/tmux.conf" "$HOME/.config/tmux/tmux.conf"
crea_symlink "$DOTFILES/.vimrc" "$HOME/.vimrc"
# In home così clang-format lo trova per ogni progetto senza un proprio .clang-format
crea_symlink "$DOTFILES/formatters/.clang-format" "$HOME/.clang-format"

echo ""
echo "============================================"
echo "  Comandi e agenti di Claude Code"
echo "============================================"

# Per singolo file: ~/.claude può contenere anche altro che non va toccato
for f in "$DOTFILES/commands"/*.md; do
    crea_symlink "$f" "$HOME/.claude/commands/$(basename "$f")"
done
for f in "$DOTFILES/agents"/*.md; do
    crea_symlink "$f" "$HOME/.claude/agents/$(basename "$f")"
done

echo ""
echo "============================================"
echo "  Preparazione ambiente"
echo "============================================"

# TPM (Tmux Plugin Manager): i temi vengono poi installati con prefix + I
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
    stampa_ok "TPM già presente in $TPM_DIR"
else
    stampa_info "Clonazione TPM..."
    if git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"; then
        stampa_ok "TPM installato (apri tmux e premi prefix + I per i plugin)"
    else
        stampa_errore "Clonazione TPM fallita"
    fi
fi

# DEV_THEME: letta da tmux.conf e dal colorscheme di nvim.
# Aggiunge l'export al file rc della shell in uso (zsh su macOS, bash su Ubuntu),
# solo se manca, senza toccare il resto del file.
case "$SHELL" in
    */zsh) RC_FILE="$HOME/.zshrc" ;;
    *)     RC_FILE="$HOME/.bashrc" ;;
esac

if grep -q "export DEV_THEME=" "$RC_FILE" 2>/dev/null; then
    stampa_ok "DEV_THEME già presente in $RC_FILE"
else
    printf '\n# TEMA (catppuccin | nord) — letta da tmux.conf e dal colorscheme di nvim\nexport DEV_THEME="catppuccin"\n' >> "$RC_FILE"
    stampa_ok "Aggiunto export DEV_THEME a $RC_FILE"
fi

# Tema ghostty: theme-local non è versionato; se esiste vince su Nord (default).
# Lo si crea solo se DEV_THEME è catppuccin, per restare coerenti con tmux/nvim.
TEMA=$(grep 'export DEV_THEME=' "$RC_FILE" 2>/dev/null | cut -d'"' -f2)
THEME_LOCAL="$DOTFILES/ghostty/theme-local"
if [ "$TEMA" = "catppuccin" ] && [ ! -f "$THEME_LOCAL" ]; then
    echo "theme = Catppuccin Frappe" > "$THEME_LOCAL"
    stampa_ok "Creato ghostty/theme-local (tema Catppuccin)"
elif [ -f "$THEME_LOCAL" ]; then
    stampa_ok "ghostty/theme-local già presente"
else
    stampa_ok "Nessun theme-local: ghostty userà Nord (default)"
fi

echo ""
stampa_info "Karabiner non viene collegato: karabiner.json è gestito dall'app,"
stampa_info "i file in $DOTFILES/karabiner sono regole da importare a mano."
stampa_info "Per i pacchetti di sistema (brew/apt, neovim, fzf...) usa env-setup.sh."

echo ""
echo "============================================"
stampa_ok "Setup completato!"
echo "============================================"
