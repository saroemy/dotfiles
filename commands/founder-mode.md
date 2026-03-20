---
name: founder-mode
description: Organizza retroattivamente lavoro sperimentale in branch, ticket e PR appropriati.
---

# Modalità Founder - Flusso di Lavoro per Iterazione Rapida

Stai lavorando su una funzionalità sperimentale che non ha ricevuto il corretto processo di ticketing e workflow PR. Questo comando ti guida nell'organizzazione retroattiva del lavoro.

Assumendo che tu abbia appena creato un commit, ecco i prossimi passaggi:

1. Ottieni lo SHA del commit che hai appena creato (se non ne hai creato uno, leggi `.claude/commands/commit.md` e creane uno)

2. Crea un ticket riguardo a ciò che hai appena implementato:
   - Rifletti profondamente su ciò che hai appena fatto
   - Scrivi un ticket chiaro con:
     - **Problema da risolvere**: Quale esigenza dell'utente viene affrontata?
     - **Soluzione proposta**: Breve panoramica della tua implementazione
   - Imposta il ticket su 'in dev' o stato appropriato
   - Se usi Linear o simili: Crea il ticket e ottieni il nome del branch raccomandato

3. Spostati sulla struttura di branch corretta:
   ```bash
   git checkout main  # Passa al branch main
   git checkout -b NOME_BRANCH  # Crea nuovo branch per la funzionalità
   git cherry-pick SHA_COMMIT  # Applica il tuo commit al nuovo branch
   git push -u origin NOME_BRANCH  # Pusha sul remoto
   ```

4. Crea una pull request:
   ```bash
   gh pr create --fill  # Crea la PR con il messaggio del commit
   ```

5. Scrivi una descrizione PR appropriata:
   - Leggi `.claude/commands/describe_pr.md` e segui le istruzioni
   - Genera una descrizione PR completa
   - Aggiorna la PR con la descrizione

## Perché Questo è Importante

Questo workflow ti aiuta a:
- Mantenere pulita la cronologia git con una struttura di branch appropriata
- Documentare il ragionamento dietro il lavoro sperimentale
- Rendere più facile la code review con il contesto appropriato
- Tracciare correttamente le funzionalità nel tuo sistema di gestione progetti

## Quando Usare Questo

Usa questo comando quando hai lavorato direttamente su `main` o un branch condiviso e devi organizzare retroattivamente il tuo lavoro sperimentale in branch e ticket appropriati.
