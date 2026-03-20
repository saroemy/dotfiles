---
name: create-plan
description: Crea piani di implementazione dettagliati attraverso un processo interattivo e iterativo.
---

# Piano di Implementazione

Ti viene affidato il compito di creare piani di implementazione dettagliati attraverso un processo interattivo e iterativo. Dovresti essere scettico, approfondito e lavorare in collaborazione con l'utente per produrre specifiche tecniche di alta qualità.

## Risposta Iniziale

Quando questo comando viene richiamato:

1. **Verifica se sono stati forniti parametri**:
   - Se è stato fornito un percorso di file o un riferimento a un ticket come parametro, salta il messaggio predefinito
   - Leggi immediatamente e COMPLETAMENTE tutti i file forniti
   - Inizia il processo di ricerca

2. **Se non sono stati forniti parametri**, rispondi con:
```
Ti aiuterò a creare un piano di implementazione dettagliato. Iniziamo a capire cosa stiamo costruendo.

Per favore, fornisci:
1. La descrizione del compito/ticket (o il riferimento a un file di ticket)
2. Qualsiasi contesto, vincolo o requisito specifico rilevante
3. Link a ricerche correlate o implementazioni precedenti

Analizzerò queste informazioni e lavorerò con te per creare un piano completo.

Suggerimento: Puoi anche richiamare questo comando direttamente con un file di ticket: `/create_plan thoughts/{username}/tickets/ticket_name.md`
Per un'analisi più approfondita, prova: `/create_plan think deeply about thoughts/{username}/tickets/ticket_name.md`
```

Quindi attendi l'input dell'utente.

## Passaggi del Processo

### Passaggio 1: Raccolta del Contesto e Analisi Iniziale

1. **Leggi immediatamente e COMPLETAMENTE tutti i file menzionati**:
   - File di ticket (es. `thoughts/{username}/tickets/ticket_name.md`)
   - Documenti di ricerca
   - Piani di implementazione correlati
   - Qualsiasi file JSON/dati menzionato
   - **IMPORTANTE**: Usa lo strumento Read SENZA parametri limit/offset per leggere interi file
   - **CRITICO**: NON generare sotto-attività prima di leggere questi file tu stesso nel contesto principale
   - **MAI** leggere i file parzialmente - se un file viene menzionato, leggilo completamente

2. **Genera attività di ricerca iniziali per raccogliere il contesto**:
   Prima di porre domande all'utente, usa agenti specializzati per la ricerca in parallelo:

   - Usa l'agente **codebase-locator** per trovare tutti i file relativi al ticket/compito
   - Usa l'agente **codebase-analyzer** per capire come funziona l'implementazione attuale
   - Se pertinente, usa l'agente **thoughts-locator** per trovare eventuali documenti di pensieri esistenti su questa funzionalità
   - Se viene menzionato un ticket Linear, usa l'agente **linear-ticket-reader** per ottenere tutti i dettagli

   Questi agenti:
   - Troveranno file sorgente, configurazioni e test pertinenti
   - Identificheranno le directory specifiche su cui concentrarsi (es. `{{MAIN_SRC_DIR}}/`)
   - Tracceranno il flusso di dati e le funzioni chiave
   - Restituiranno spiegazioni dettagliate con riferimenti file:riga

3. **Leggi tutti i file identificati dalle attività di ricerca**:
   - Dopo che le attività di ricerca sono completate, leggi TUTTI i file che hanno identificato come pertinenti
   - Leggili COMPLETAMENTE nel contesto principale
   - Questo assicura una comprensione completa prima di procedere

4. **Analizza e verifica la comprensione**:
   - Confronta i requisiti del ticket con il codice effettivo
   - Identifica eventuali discrepanze o incomprensioni
   - Annota le ipotesi che necessitano di verifica
   - Determina il vero ambito basato sulla realtà del codebase

5. **Presenta una comprensione informata e domande mirate**:
   ```
   Basandomi sul ticket e sulla mia ricerca del codebase di {{PROJECT_NAME}}, capisco che dobbiamo [riassunto accurato].

   Ho scoperto che:
   - [Dettaglio dell'implementazione attuale con riferimento file:riga]
   - [Pattern o vincolo rilevante scoperto]
   - [Potenziale complessità o caso limite identificato]

   Domande a cui la mia ricerca non ha potuto rispondere:
   - [Domanda tecnica specifica che richiede giudizio umano]
   - [Chiarimento della logica di business]
   - [Preferenza di design che influisce sull'implementazione]
   ```

   Poni solo domande a cui non puoi sinceramente rispondere tramite l'indagine del codice.

### Step 2: Ricerca e Scoperta

Dopo aver ottenuto i chiarimenti iniziali:

1.  **Se l'utente corregge qualsiasi incomprensione**:
    *   NON accettare semplicemente la correzione
    *   Avviare nuove attività di ricerca per verificare le informazioni corrette
    *   Leggere i file/directory specifici menzionati
    *   Procedere solo dopo aver verificato i fatti personalmente

2.  **Creare una lista di cose da fare per la ricerca** usando TodoWrite per tracciare le attività di esplorazione

3.  **Avviare sotto-attività parallele per una ricerca completa**:
    *   Creare più agenti Task per ricercare diversi aspetti contemporaneamente
    *   Utilizzare l'agente giusto per ogni tipo di ricerca:

    **Per un'indagine più approfondita:**
    *   **codebase-locator** - Per trovare file più specifici (es. "trova tutti i file che gestiscono [componente specifico]")
    *   **codebase-analyzer** - Per comprendere i dettagli di implementazione (es. "analizza come funziona [il sistema]")
    *   **codebase-pattern-finder** - Per trovare funzionalità simili a cui possiamo ispirarci

    **Per il contesto storico:**
    *   **thoughts-locator** - Per trovare ricerche, piani o decisioni relative a quest'area
    *   **thoughts-analyzer** - Per estrarre intuizioni chiave dai documenti più rilevanti

    **Per ticket correlati:**
    *   **linear-searcher** - Per trovare problemi simili o implementazioni passate

    Ogni agente sa come:
    *   Trovare i file e i modelli di codice giusti
    *   Identificare convenzioni e modelli da seguire
    *   Cercare punti di integrazione e dipendenze
    *   Restituire riferimenti specifici file:riga
    *   Trovare test ed esempi

3.  **Attendere il completamento di TUTTE le sotto-attività** prima di procedere

4.  **Presentare i risultati e le opzioni di progettazione**:
    ```
    Sulla base della mia ricerca, ecco cosa ho trovato:

    **Stato Attuale:**
    - [Scoperta chiave sul codice esistente]
    - [Modello o convenzione da seguire]

    **Opzioni di Progettazione:**
    1. [Opzione A] - [pro/contro]
    2. [Opzione B] - [pro/contro]

    **Domande Aperte:**
    - [Incertezza tecnica]
    - [Decisione di progettazione necessaria]

    Quale approccio si allinea meglio alla tua visione?
    ```

### Step 3: Sviluppo della Struttura del Piano

Una volta allineati sull'approccio:

1.  **Creare una bozza iniziale del piano**:
    ```
    Ecco la struttura del piano che propongo:

    ## Overview
    [Riepilogo di 1-2 frasi]

    ## Fasi di Implementazione:
    1. [Nome fase] - [cosa realizza]
    2. [Nome fase] - [cosa realizza]
    3. [Nome fase] - [cosa realizza]

    Questa suddivisione in fasi ha senso? Dovrei modificare l'ordine o la granularità?
    ```

2.  **Ottenere feedback sulla struttura** prima di scrivere i dettagli

### Step 4: Scrittura Dettagliata del Piano

Dopo l'approvazione della struttura:

1.  **Scrivi il piano** in `thoughts/shared/plans/YYYY-MM-DD-description.md` o `thoughts/shared/plans/YYYY-MM-DD-TICKET-XXXX-description.md`
    *   Formato: `YYYY-MM-DD-description.md` o `YYYY-MM-DD-TICKET-XXXX-description.md` dove:
        *   YYYY-MM-DD è la data odierna
        *   TICKET-XXXX è il numero del ticket (se applicabile)
        *   description è una breve descrizione in kebab-case
    *   Esempi:
        *   Con ticket: `2025-01-08-ENG-1478-parent-child-tracking.md`
        *   Senza ticket: `2025-01-08-improve-error-handling.md`

2.  **Usa questa struttura di template**:

    ````markdown
    # Piano di Implementazione [Nome Funzionalità/Task]

    ## Panoramica

    [Breve descrizione di cosa stiamo implementando e perché]

    ## Analisi dello Stato Attuale

    [Cosa esiste ora, cosa manca, vincoli chiave scoperti]

    ## Stato Finale Desiderato

    [Una specifica dello stato finale desiderato dopo il completamento di questo piano, e come verificarlo]

    ### Scoperte Chiave:
    - [Importante scoperta con riferimento file:linea]
    - [Pattern da seguire]
    - [Vincolo entro cui lavorare]

    ## Cosa NON Stiamo Facendo

    [Elenca esplicitamente gli elementi fuori scopo per prevenire lo scope creep]

    ## Approccio all'Implementazione

    [Strategia e ragionamento di alto livello]

    ## Fase 1: [Nome Descrittivo]

    ### Panoramica
    [Cosa realizza questa fase]

    ### Modifiche Richieste:

    #### 1. [Componente/Gruppo di File]
    **File**: `path/to/file.ext`
    **Modifiche**: [Riepilogo delle modifiche]

    ```[language]
    // Codice specifico da aggiungere/modificare
    ```

    ### Criteri di Successo:

    #### Verifica Automatica:
    - [ ] I test passano: `{{TEST_COMMAND}}`
    - [ ] Il controllo dei tipi passa: `npm run typecheck` (o equivalente)
    - [ ] Il linting passa: `npm run lint` (o equivalente)
    - [ ] La build ha successo: `npm run build` (o equivalente)

    #### Verifica Manuale:
    - [ ] La funzionalità funziona come previsto quando testata
    - [ ] Le prestazioni sono accettabili
    - [ ] La gestione dei casi limite è verificata manualmente
    - [ ] Nessuna regressione nelle funzionalità correlate

    **Nota di Implementazione**: Dopo aver completato questa fase e superato tutte le verifiche automatiche, fermarsi qui per una conferma manuale da parte dell'umano che il test manuale ha avuto successo prima di procedere alla fase successiva.

    ---

    ## Fase 2: [Nome Descrittivo]

    [Struttura simile con criteri di successo sia automatici che manuali...]

    ---

    ## Strategia di Testing

    ### Unit Test:
    - [Cosa testare]
    - [Casi limite chiave]

    ### Integration Test:
    - [Scenari end-to-end]

    ### Passi di Testing Manuale:
    1. [Passo specifico per verificare la funzionalità]
    2. [Un altro passo di verifica]
    3. [Caso limite da testare manualmente]

    ## Considerazioni sulle Prestazioni

    [Eventuali implicazioni sulle prestazioni o ottimizzazioni necessarie]

    ## Note di Migrazione

    [Se applicabile, come gestire dati/sistemi esistenti]

    ## Riferimenti

    - Ticket originale: `thoughts/{username}/tickets/ticket_name.md`
    - Ricerca correlata: `thoughts/shared/research/[relevant].md`
    - Implementazione simile: `[file:line]`
    ````

### Step 5: Sincronizza e Rivedi

1.  **Sincronizza la directory dei pensieri**:
    *   Esegui `npx humanlayer thoughts sync` per sincronizzare il piano appena creato
    *   Questo assicura che il piano sia correttamente indicizzato e disponibile
    *   *Nota: Se non stai usando humanlayer, salta questo passaggio o usa il tuo metodo di sincronizzazione*

2.  **Presenta la posizione della bozza del piano**:
    ```
    Ho creato il piano di implementazione iniziale in:
    `thoughts/shared/plans/YYYY-MM-DD-description.md`

    Per favore, rivedilo e fammi sapere:
    - Le fasi sono correttamente delimitate?
    - I criteri di successo sono abbastanza specifici?
    - Ci sono dettagli tecnici che necessitano di aggiustamenti?
    - Mancano casi limite o considerazioni?
    ```

3.  **Itera in base al feedback** - sii pronto a:
    *   Aggiungere fasi mancanti
    *   Regolare l'approccio tecnico
    *   Chiarire i criteri di successo (sia automatici che manuali)
    *   Aggiungere/rimuovere elementi di scope
    *   Dopo aver apportato modifiche, esegui di nuovo `npx humanlayer thoughts sync` (se usi humanlayer)

4.  **Continua a perfezionare** finché l'utente non è soddisfatto

## Linee Guida Importanti

1.  **Sii Scettico**:
    *   Metti in discussione requisiti vaghi
    *   Identifica potenziali problemi in anticipo
    *   Chiedi "perché" e "che dire di"
    *   Non dare per scontato - verifica con il codice

2.  **Sii Interattivo**:
    *   Non scrivere il piano completo in una sola volta
    *   Ottieni l'approvazione ad ogni passo importante
    *   Consenti correzioni di rotta
    *   Lavora in modo collaborativo

3.  **Sii Approfondito**:
    *   Leggi TUTTI i file di contesto COMPLETAMENTE prima di pianificare
    *   Ricerca modelli di codice effettivi usando sotto-task paralleli
    *   Includi percorsi di file e numeri di riga specifici
    *   Scrivi criteri di successo misurabili con chiara distinzione tra automatico e manuale

4.  **Sii Pratico**:
    *   Concentrati su modifiche incrementali e testabili
    *   Considera la migrazione e il rollback
    *   Pensa ai casi limite
    *   Includi "cosa NON stiamo facendo"

5.  **Tieni Traccia dei Progressi**:
    *   Usa TodoWrite per tenere traccia delle attività di pianificazione
    *   Aggiorna i todo man mano che completi la ricerca
    *   Contrassegna le attività di pianificazione come completate quando fatto

6.  **Nessuna Domanda Aperta nel Piano Finale**:
    *   Se incontri domande aperte durante la pianificazione, FERMATI
    *   Ricerca o chiedi chiarimenti immediatamente
    *   NON scrivere il piano con domande irrisolte
    *   Il piano di implementazione deve essere completo e attuabile
    *   Ogni decisione deve essere presa prima di finalizzare il piano

## Linee Guida per i Criteri di Successo

**Separa sempre i criteri di successo in due categorie:**

1.  **Verifica Automatica** (può essere eseguita da agenti di esecuzione):
    *   Comandi che possono essere eseguiti: `{{TEST_COMMAND}}`, linting, type checking, ecc.
    *   File specifici che dovrebbero esistere
    *   Compilazione/controllo dei tipi del codice
    *   Suite di test automatizzate

2.  **Verifica Manuale** (richiede test umani):
    *   Funzionalità UI/UX
    *   Prestazioni in condizioni reali
    *   Casi limite difficili da automatizzare
    *   Criteri di accettazione dell'utente

**Esempio di formato:**
```markdown
### Criteri di Successo:

#### Verifica Automatica:
- [ ] Tutti i test passano: `{{TEST_COMMAND}}`
- [ ] Nessun errore di linting: `npm run lint`
- [ ] Il controllo dei tipi passa: `npm run typecheck`
- [ ] La build ha successo: `npm run build`

#### Verifica Manuale:
- [ ] La nuova funzionalità appare correttamente nell'interfaccia utente
- [ ] Le prestazioni sono accettabili con grandi set di dati
- [ ] I messaggi di errore sono user-friendly
- [ ] La funzionalità funziona correttamente su browser/dispositivi diversi
```

## Modelli Comuni

### Per Modifiche al Database:
- Inizia con schema/migrazione
- Aggiungi metodi di store
- Aggiorna la logica di business
- Espone tramite API
- Aggiorna i client

### Per Nuove Funzionalità:
- Ricerca prima i modelli esistenti
- Inizia con il modello di dati
- Costruisci la logica di backend
- Aggiungi endpoint API
- Implementa l'interfaccia utente per ultima

### Per il Refactoring:
- Documenta il comportamento attuale
- Pianifica modifiche incrementali
- Mantieni la compatibilità all'indietro
- Includi la strategia di migrazione

## Best Practice per la Generazione di Sotto-task

Quando si generano sotto-task di ricerca:

1.  **Genera più task in parallelo** per efficienza
2.  **Ogni task dovrebbe essere focalizzato** su un'area specifica
3.  **Fornisci istruzioni dettagliate** includendo:
    *   Esattamente cosa cercare
    *   Quali directory focalizzare (es. `{{MAIN_SRC_DIR}}/`)
    *   Quali informazioni estrarre
    *   Formato di output atteso
4.  **Sii ESTREMAMENTE specifico riguardo alle directory**:
    *   Includi il contesto del percorso completo nei tuoi prompt
    *   Specifica nomi di directory esatti quando conosciuti
5.  **Specifica strumenti di sola lettura** da usare
6.  **Richiedi riferimenti specifici file:riga** nelle risposte
7.  **Attendi il completamento di tutti i task** prima di sintetizzare
8.  **Verifica i risultati dei sotto-task**:
    *   Se un sotto-task restituisce risultati inaspettati, genera task di follow-up
    *   Confronta i risultati con il codice effettivo
    *   Non accettare risultati che sembrano errati

Esempio di generazione di più task:
```python
# Genera questi task contemporaneamente:
tasks = [
    Task("Ricerca schema database", db_research_prompt),
    Task("Trova modelli API", api_research_prompt),
    Task("Indaga componenti", component_research_prompt),
    Task("Controlla modelli di test", test_research_prompt)
]
```

## Example Interaction Flow

```
User: /create_plan
Assistant: I'll help you create a detailed implementation plan...

User: We need to add [feature description]. See thoughts/{username}/tickets/ticket_name.md
Assistant: Let me read that ticket file completely first...

[Reads file fully]

Based on the ticket, I understand we need to [summary]. Before I start planning, let me research the {{PROJECT_NAME}} codebase to understand the current implementation...

[Interactive process continues...]
```
