# Script di importazione VS Code per Windows
Write-Host "=== IMPORTAZIONE CONFIGURAZIONI VS CODE SU WINDOWS ===" -ForegroundColor Green

# Percorso dove hai copiato la cartella vscode-export
$exportPath = "$env:USERPROFILE\Desktop\vscode-export"
$vscodeUserPath = "$env:APPDATA\Code\User"

# Verifica che la cartella di esportazione esista
if (-not (Test-Path $exportPath)) {
    Write-Host "ERRORE: Cartella $exportPath non trovata!" -ForegroundColor Red
    Write-Host "Assicurati di aver copiato la cartella vscode-export sul Desktop" -ForegroundColor Yellow
    exit
}

# Crea la cartella User se non esiste
if (-not (Test-Path $vscodeUserPath)) {
    New-Item -ItemType Directory -Path $vscodeUserPath -Force | Out-Null
}

# Importa settings.json
if (Test-Path "$exportPath\settings.json") {
    Copy-Item "$exportPath\settings.json" "$vscodeUserPath\settings.json" -Force
    Write-Host "[OK] settings.json importato" -ForegroundColor Green
}

# Importa keybindings.json
if (Test-Path "$exportPath\keybindings.json") {
    Copy-Item "$exportPath\keybindings.json" "$vscodeUserPath\keybindings.json" -Force
    Write-Host "[OK] keybindings.json importato" -ForegroundColor Green
}

# Importa snippets
if (Test-Path "$exportPath\snippets") {
    Copy-Item "$exportPath\snippets" "$vscodeUserPath\" -Recurse -Force
    Write-Host "[OK] Snippets importati" -ForegroundColor Green
}

# Installa le estensioni
if (Test-Path "$exportPath\extensions.txt") {
    Write-Host "`nInstallazione estensioni in corso..." -ForegroundColor Yellow
    
    $extensions = Get-Content "$exportPath\extensions.txt"
    $total = $extensions.Count
    $current = 0
    
    foreach ($ext in $extensions) {
        if ($ext -and $ext.Trim() -ne "") {
            $current++
            Write-Host "[$current/$total] Installando: $ext" -ForegroundColor Cyan
            & code --install-extension $ext --force 2>&1 | Out-Null
        }
    }
    
    Write-Host "[OK] Tutte le estensioni installate" -ForegroundColor Green
}

Write-Host "`n=== IMPORTAZIONE COMPLETATA ===" -ForegroundColor Green
Write-Host "Riavvia VS Code per applicare tutte le modifiche" -ForegroundColor Yellow

# ============================================
# ISTRUZIONI
# ============================================

# 2. TRASFERIMENTO:
#    - Copia la cartella "vscode-export" su una USB o caricala su cloud
#    - Trasferiscila sul PC Windows (es. sul Desktop)

# 3. SU WINDOWS:
#    - Apri PowerShell come Amministratore
#    - Copia la sezione PowerShell qui sopra (tra gli apici singoli)
#    - Salvala come "import-vscode-windows.ps1" sul Desktop
#    - Esegui: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#    - Esegui: .\import-vscode-windows.ps1
#    - Riavvia VS Code