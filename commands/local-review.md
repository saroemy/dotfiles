---
name: local-review
description: Configura un ambiente di revisione locale per il branch di un collega tramite worktree.
---

# Revisione Locale

Hai il compito di configurare un ambiente di revisione locale per il branch di un collega. Questo comporta la creazione di un worktree, la configurazione delle dipendenze e l'avvio di una nuova sessione Claude Code.

## Processo

Quando invocato con un parametro come `gh_username:branchName`:

1. **Analizza l'input**:
   - Estrai il nome utente GitHub e il nome del branch dal formato `username:branchname`
   - Se non viene fornito alcun parametro, chiedi nel formato: `gh_username:branchName`

2. **Estrai informazioni sul ticket**:
   - Cerca numeri di ticket nel nome del branch (es. `eng-1696`, `ENG-1696`)
   - Usa questo per creare un nome breve della directory del worktree
   - Se non viene trovato alcun ticket, usa una versione sanitizzata del nome del branch

3. **Configura il remote e il worktree**:
   - Controlla se il remote esiste già usando `git remote -v`
   - Se no, aggiungilo: `git remote add USERNAME git@github.com:USERNAME/{{PROJECT_NAME}}`
   - Recupera dal remote: `git fetch USERNAME`
   - Crea worktree: `git worktree add -b BRANCHNAME ~/wt/{{PROJECT_NAME}}/SHORT_NAME USERNAME/BRANCHNAME`

4. **Configura il worktree**:
   - Copia le impostazioni di Claude: `cp .claude/settings.local.json WORKTREE/.claude/`
   - Esegui setup: `{{SETUP_COMMAND}}`
   - Inizializza thoughts (se in uso): `cd WORKTREE && npx humanlayer thoughts init --directory {{PROJECT_NAME}}`

   Nota: Il passaggio di inizializzazione di thoughts è opzionale. Se non stai usando il sistema thoughts, salta questo passaggio.

## Gestione degli Errori

- Se il worktree esiste già, informa l'utente che deve rimuoverlo prima
- Se il fetch del remote fallisce, controlla se il username/repo esiste
- Se il setup fallisce, fornisci l'errore ma continua con il lancio

## Esempio di Utilizzo

```
/local_review colleague_username:feature/add-new-api
```

Questo:
- Aggiungerà 'colleague_username' come remote
- Creerà il worktree in `~/wt/{{PROJECT_NAME}}/add-new-api` (o numero ticket se trovato)
- Configurerà l'ambiente
- Lancerà Claude Code nel nuovo worktree

## Personalizzazione

Aggiorna quanto segue in base al tuo progetto:
- **Repository**: Sostituisci il pattern dell'URL git se non usi GitHub
- **Comando setup**: Adatta `{{SETUP_COMMAND}}` per corrispondere al tuo progetto (npm install, poetry install, ecc.)
- **Posizione worktree**: Cambia `~/wt/{{PROJECT_NAME}}` se preferisci una posizione diversa
- **Impostazioni Claude**: Adatta il comando di copia delle impostazioni se memorizzi le impostazioni altrove
