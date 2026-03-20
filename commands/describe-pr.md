---
name: describe-pr
description: Genera una descrizione completa della pull request analizzando diff e commit.
---

# Genera Descrizione PR

Hai il compito di generare una descrizione completa della pull request seguendo il template standard del repository.

## Passaggi da seguire:

1. **Leggi il template della descrizione PR (se disponibile):**
   - Controlla se esiste un template in `thoughts/shared/pr_description.md` o `.github/pull_request_template.md`
   - Se esiste un template, leggilo attentamente per comprendere tutte le sezioni e i requisiti
   - Se non esiste un template, usa un formato standard per la descrizione della PR (vedi sotto)

2. **Identifica la PR da descrivere:**
   - Controlla se il branch corrente ha una PR associata: `gh pr view --json url,number,title,state 2>/dev/null`
   - Se non esiste una PR per il branch corrente, o se sei su main/master, elenca le PR aperte: `gh pr list --limit 10 --json number,title,headRefName,author`
   - Chiedi all'utente quale PR vuole descrivere

3. **Controlla se esiste già una descrizione:**
   - Verifica se esiste già un file di descrizione in `thoughts/shared/prs/{number}_description.md`
   - Se esiste, leggilo e informa l'utente che lo aggiornerai
   - Considera cosa è cambiato dall'ultima volta che la descrizione è stata scritta

4. **Raccogli informazioni complete sulla PR:**
   - Ottieni il diff completo della PR: `gh pr diff {number}`
   - Se ricevi un errore riguardo l'assenza di un repository remoto predefinito, istruisci l'utente ad eseguire `gh repo set-default` e selezionare il repository appropriato
   - Ottieni la cronologia dei commit: `gh pr view {number} --json commits`
   - Controlla il branch base: `gh pr view {number} --json baseRefName`
   - Ottieni i metadati della PR: `gh pr view {number} --json url,title,number,state`

5. **Analizza le modifiche in modo approfondito:** (rifletti approfonditamente sulle modifiche al codice, le loro implicazioni architetturali e gli impatti potenziali)
   - Esamina attentamente l'intero diff
   - Per contesto, leggi eventuali file che sono referenziati ma non mostrati nel diff
   - Comprendi lo scopo e l'impatto di ogni modifica
   - Identifica le modifiche visibili all'utente rispetto ai dettagli implementativi interni
   - Cerca modifiche che rompono la compatibilità o requisiti di migrazione

6. **Gestisci i requisiti di verifica:**
   - Cerca eventuali elementi della checklist nella sezione "Come verificarlo" del template
   - Per ogni passaggio di verifica:
     - Se è un comando che puoi eseguire (come `{{TEST_COMMAND}}`, linting, build, ecc.), eseguilo
     - Se passa, segna il checkbox come selezionato: `- [x]`
     - Se fallisce, mantienilo non selezionato e annota cosa è fallito: `- [ ]` con spiegazione
     - Se richiede test manuali (interazioni UI, servizi esterni), lascialo non selezionato e annota per l'utente
   - Documenta eventuali passaggi di verifica che non hai potuto completare

7. **Genera la descrizione:**
   - Compila ogni sezione dal template in modo approfondito:
     - Rispondi a ogni domanda/sezione basandoti sulla tua analisi
     - Sii specifico riguardo ai problemi risolti e alle modifiche apportate
     - Concentrati sull'impatto sull'utente dove rilevante
     - Includi i dettagli tecnici nelle sezioni appropriate
     - Scrivi una voce di changelog concisa
   - Assicurati che tutti gli elementi della checklist siano affrontati (selezionati o spiegati)

   **Formato Standard della Descrizione PR** (se non esiste un template):
   ```markdown
   ## Cosa fa questa PR?
   [Breve descrizione delle modifiche]

   ## Perché lo stiamo facendo?
   [Contesto e motivazione]

   ## Cosa è cambiato?
   - [Modifica chiave 1]
   - [Modifica chiave 2]
   - [Modifica chiave 3]

   ## Modifiche che Rompono la Compatibilità
   [Elenca eventuali modifiche che rompono la compatibilità, oppure "Nessuna"]

   ## Come verificarlo
   - [ ] Esegui i test: `{{TEST_COMMAND}}`
   - [ ] Esegui il linter: `npm run lint` (o equivalente)
   - [ ] Build ha successo: `npm run build` (o equivalente)
   - [ ] Test manuali: [passaggi specifici]

   ## Screenshot (se applicabile)
   [Aggiungi screenshot per modifiche UI]

   ## Issue/PR Correlate
   - Chiude #[numero-issue]
   - Correlato a #[numero-issue]

   ## Checklist
   - [ ] Test aggiunti/aggiornati
   - [ ] Documentazione aggiornata
   - [ ] Voce changelog aggiunta (se necessario)
   ```

8. **Salva la descrizione:**
   - Scrivi la descrizione completata in `thoughts/shared/prs/{number}_description.md`
   - Se usi humanlayer, esegui `npx humanlayer thoughts sync` per sincronizzare
   - Mostra all'utente la descrizione generata

9. **Aggiorna la PR:**
   - Aggiorna la descrizione della PR direttamente: `gh pr edit {number} --body-file thoughts/shared/prs/{number}_description.md`
   - Conferma che l'aggiornamento è riuscito
   - Se alcuni passaggi di verifica rimangono non selezionati, ricorda all'utente di completarli prima del merge

## Note importanti:
- Questo comando funziona su repository diversi - leggi sempre il template locale
- Sii approfondito ma conciso - le descrizioni dovrebbero essere facilmente scansionabili
- Concentrati sul "perché" tanto quanto sul "cosa"
- Includi eventuali modifiche che rompono la compatibilità o note di migrazione in modo prominente
- Se la PR tocca più componenti, organizza la descrizione di conseguenza
- Prova sempre ad eseguire i comandi di verifica quando possibile
- Comunica chiaramente quali passaggi di verifica necessitano test manuali
- Se non usi la directory thoughts, puoi salvare in un file temporaneo e aggiornare la PR direttamente
