---
name: validate-plan
description: Valida che un piano di implementazione sia stato eseguito correttamente verificando i criteri di successo.
---

# Valida Piano

Hai il compito di validare che un piano di implementazione sia stato eseguito correttamente, verificando tutti i criteri di successo e identificando eventuali deviazioni o problemi.

## Configurazione Iniziale

Quando invocato:
1. **Determina il contesto** - Sei in una conversazione esistente o stai iniziando da zero?
   - Se esistente: Rivedi cosa è stato implementato in questa sessione
   - Se nuovo: Devi scoprire cosa è stato fatto attraverso git e analisi del codebase

2. **Localizza il piano**:
   - Se viene fornito il percorso del piano, usalo
   - Altrimenti, cerca nei commit recenti riferimenti al piano o chiedi all'utente

3. **Raccogli prove dell'implementazione**:
   ```bash
   # Controlla i commit recenti
   git log --oneline -n 20
   git diff HEAD~N..HEAD  # Dove N copre i commit di implementazione

   # Esegui controlli completi
   {{TEST_COMMAND}}
   ```

## Processo di Validazione

### Passaggio 1: Scoperta del Contesto

Se stai iniziando da zero o hai bisogno di più contesto:

1. **Leggi il piano di implementazione** completamente
2. **Identifica cosa avrebbe dovuto cambiare**:
   - Elenca tutti i file che avrebbero dovuto essere modificati
   - Nota tutti i criteri di successo (automatizzati e manuali)
   - Identifica le funzionalità chiave da verificare

3. **Genera task di ricerca paralleli** per scoprire l'implementazione:
   ```
   Task 1 - Verifica modifiche al database:
   Ricerca se la migrazione [N] è stata aggiunta e le modifiche allo schema corrispondono al piano.
   Controlla: file di migrazione, versione schema, struttura tabelle
   Restituisci: Cosa è stato implementato vs cosa specificava il piano

   Task 2 - Verifica modifiche al codice:
   Trova tutti i file modificati relativi a [funzionalità].
   Confronta le modifiche effettive con le specifiche del piano.
   Restituisci: Confronto file per file tra pianificato e effettivo

   Task 3 - Verifica copertura test:
   Controlla se i test sono stati aggiunti/modificati come specificato.
   Esegui comandi di test e cattura i risultati.
   Restituisci: Stato dei test e eventuale copertura mancante
   ```

### Passaggio 2: Validazione Sistematica

Per ogni fase nel piano:

1. **Controlla lo stato di completamento**:
   - Cerca checkmark nel piano (- [x])
   - Verifica che il codice effettivo corrisponda al completamento dichiarato

2. **Esegui verifica automatizzata**:
   - Esegui ogni comando dalla "Verifica Automatizzata"
   - Documenta lo stato pass/fail
   - Se ci sono fallimenti, investigane la causa principale

3. **Valuta i criteri manuali**:
   - Elenca cosa necessita test manuali
   - Fornisci passaggi chiari per la verifica dell'utente

4. **Rifletti profondamente sui casi limite**:
   - Le condizioni di errore sono state gestite?
   - Ci sono validazioni mancanti?
   - L'implementazione potrebbe rompere funzionalità esistenti?

### Passaggio 3: Genera Report di Validazione

Crea un riepilogo completo della validazione:

```markdown
## Report di Validazione: [Nome Piano]

### Stato Implementazione
✓ Fase 1: [Nome] - Implementata completamente
✓ Fase 2: [Nome] - Implementata completamente
⚠️ Fase 3: [Nome] - Implementata parzialmente (vedi problemi)

### Risultati Verifica Automatizzata
✓ Build passa: {{BUILD_COMMAND}}
✓ Test passano: {{TEST_COMMAND}}
✗ Problemi di linting: {{LINT_COMMAND}} (3 warning)

### Risultati Code Review

#### Corrisponde al Piano:
- La migrazione del database aggiunge correttamente [tabella]
- Gli endpoint API implementano i metodi specificati
- La gestione degli errori segue il piano

#### Deviazioni dal Piano:
- Usati nomi di variabili diversi in [file:line]
- Aggiunta validazione extra in [file:line] (miglioramento)

#### Problemi Potenziali:
- Mancante indice sulla chiave esterna potrebbe impattare le prestazioni
- Nessuna gestione del rollback nella migrazione

### Test Manuali Richiesti:
1. Funzionalità UI:
   - [ ] Verifica che [funzionalità] appaia correttamente
   - [ ] Testa stati di errore con input non valido

2. Integrazione:
   - [ ] Conferma che funziona con [componente] esistente
   - [ ] Controlla prestazioni con dataset grandi

### Raccomandazioni:
- Affronta i warning di linting prima del merge
- Considera di aggiungere test di integrazione per [scenario]
- Documenta i nuovi endpoint API
```

## Lavorare con Contesto Esistente

Se facevi parte dell'implementazione:
- Rivedi la cronologia della conversazione
- Controlla la tua todo list per cosa è stato completato
- Concentra la validazione sul lavoro fatto in questa sessione
- Sii onesto riguardo eventuali scorciatoie o elementi incompleti

## Linee Guida Importanti

1. **Sii approfondito ma pratico** - Concentrati su ciò che conta
2. **Esegui tutti i controlli automatizzati** - Non saltare i comandi di verifica
3. **Documenta tutto** - Sia i successi che i problemi
4. **Pensa in modo critico** - Chiediti se l'implementazione risolve veramente il problema
5. **Considera la manutenibilità** - Sarà manutenibile a lungo termine?

## Checklist di Validazione

Verifica sempre:
- [ ] Tutte le fasi marcate come complete sono effettivamente fatte
- [ ] I test automatizzati passano
- [ ] Il codice segue i pattern esistenti
- [ ] Non sono state introdotte regressioni
- [ ] La gestione degli errori è robusta
- [ ] La documentazione è aggiornata se necessario
- [ ] I passaggi di test manuali sono chiari

## Relazione con Altri Comandi

Workflow raccomandato:
1. `/implement_plan` - Esegui l'implementazione
2. `/commit` - Crea commit atomici per le modifiche
3. `/validate_plan` - Verifica la correttezza dell'implementazione
4. `/describe_pr` - Genera la descrizione della PR

La validazione funziona meglio dopo che i commit sono stati fatti, poiché può analizzare la cronologia git per capire cosa è stato implementato.

Ricorda: Una buona validazione cattura i problemi prima che arrivino in produzione. Sii costruttivo ma approfondito nell'identificare lacune o miglioramenti.
