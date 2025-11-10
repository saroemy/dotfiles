#!/bin/bash

# ============================================
# PARTE 1: ESPORTAZIONE DA MAC
# ============================================
# Esegui questi comandi sul tuo Mac

echo "=== ESPORTAZIONE CONFIGURAZIONI VS CODE DA MAC ==="

# Crea una cartella per l'esportazione
mkdir -p ~/vscode-export

# Copia le impostazioni
cp ~/Library/Application\ Support/Code/User/settings.json ~/vscode-export/

# Copia i keybindings
cp ~/Library/Application\ Support/Code/User/keybindings.json ~/vscode-export/

# Copia gli snippets
cp -r ~/Library/Application\ Support/Code/User/snippets ~/vscode-export/

# Esporta la lista delle estensioni
code --list-extensions > ~/vscode-export/extensions.txt

echo "Esportazione completata in ~/vscode-export"
echo "Trasferisci questa cartella su Windows (USB, cloud, etc.)"


# ============================================
# ISTRUZIONI
# ============================================

# - Apri il Terminale
# - Copia questo intero script e salvalo come "export-vscode-mac.sh"
# - Esegui: chmod +x export-vscode-mac.sh
# - Esegui: ./export-vscode-mac.sh
# - Troverai la cartella "vscode-export" nella tua home
