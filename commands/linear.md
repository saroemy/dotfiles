---
name: linear
description: Gestisce ticket Linear creando, aggiornando e cercando issue dal codebase.
---

# Linear - Gestione Ticket

Hai il compito di gestire i ticket Linear, inclusa la creazione di ticket da documenti thoughts, l'aggiornamento di ticket esistenti e il seguire i pattern di workflow del tuo team.

## Configurazione Iniziale

Prima, verifica che gli strumenti Linear MCP siano disponibili controllando se esistono strumenti `mcp__linear__`. Se no, rispondi:
```
Ho bisogno di accesso agli strumenti Linear per aiutare con la gestione dei ticket. Per favore esegui il comando `/mcp` per abilitare il server Linear MCP, poi riprova.
```

Se gli strumenti sono disponibili, rispondi in base alla richiesta dell'utente:

### Per richieste generali:
```
Posso aiutarti con i ticket Linear. Cosa vorresti fare?
1. Creare un nuovo ticket da un documento thoughts
2. Aggiungere un commento a un ticket (userò il contesto della nostra conversazione)
3. Cercare ticket
4. Aggiornare stato o dettagli del ticket
```

### Per richieste specifiche di creazione:
```
Ti aiuterò a creare un ticket Linear dal tuo documento thoughts. Per favore fornisci:
1. Il percorso al documento thoughts (o argomento da cercare)
2. Qualsiasi focus o angolazione specifica per il ticket (opzionale)
```

Poi attendi l'input dell'utente.

## Workflow del Team & Progressione degli Stati

Workflow tipico di engineering (personalizza in base al tuo team):

1. **Triage** → Tutti i nuovi ticket iniziano qui per la revisione iniziale
2. **Spec Needed** → Servono più dettagli - problema da risolvere e schema della soluzione necessari
3. **Research Needed** → Il ticket richiede investigazione prima che si possa scrivere il piano
4. **Research in Progress** → Ricerca/investigazione attiva in corso
5. **Ready for Plan** → Ricerca completa, il ticket necessita un piano di implementazione
6. **Plan in Progress** → Scrittura attiva del piano di implementazione
7. **Plan in Review** → Piano scritto e in discussione
8. **Ready for Dev** → Piano approvato, pronto per l'implementazione
9. **In Dev** → Sviluppo attivo
10. **Code Review** → PR sottomessa
11. **Done** → Completato

**Principio chiave**: La revisione e l'allineamento avvengono nella fase del piano (non nella fase PR) per muoversi più velocemente ed evitare rilavorazioni.

## Convenzioni Importanti

### Mappatura URL per Documenti Thoughts
Quando fai riferimento a documenti thoughts, fornisci sempre link GitHub usando il parametro `links`:
- `thoughts/shared/...` → URL GitHub ai thoughts condivisi
- `thoughts/{username}/...` → URL GitHub ai thoughts personali
- `thoughts/global/...` → URL GitHub ai thoughts globali

### Valori Predefiniti
- **Status**: Crea nuovi ticket in "Triage" o lo stato iniziale del tuo team
- **Project**: Predefinito al tuo progetto principale o chiedi all'utente
- **Priority**: Predefinito a Medium (3) per la maggior parte dei task, usa il miglior giudizio o chiedi all'utente
  - Urgent (1): Blocchi critici, problemi di sicurezza
  - High (2): Funzionalità importanti con scadenze, bug maggiori
  - Medium (3): Task di implementazione standard (predefinito)
  - Low (4): Nice-to-have, miglioramenti minori
- **Links**: Usa il parametro `links` per allegare URL (non solo link markdown nella descrizione)

### Assegnazione Automatica delle Label
Applica automaticamente label in base al contenuto del ticket (personalizza per il tuo codebase):
- **backend**: Per modifiche server/API
- **frontend**: Per modifiche UI/client
- **infrastructure**: Per lavoro DevOps, CI/CD, deployment
- **documentation**: Per modifiche solo docs

## Istruzioni Specifiche per Azione

### 1. Creare Ticket da Thoughts

#### Passaggi da seguire dopo aver ricevuto la richiesta:

1. **Localizza e leggi il documento thoughts:**
   - Se viene dato un percorso, leggi il documento direttamente
   - Se viene dato un argomento/parola chiave, cerca nella directory thoughts/ usando Grep per trovare documenti rilevanti
   - Se vengono trovate più corrispondenze, mostra la lista e chiedi all'utente di selezionare
   - Crea una lista TodoWrite per tracciare: Leggi documento → Analizza contenuto → Bozza ticket → Ottieni input utente → Crea ticket

2. **Analizza il contenuto del documento:**
   - Identifica il problema centrale o la funzionalità discussa
   - Estrai i dettagli chiave di implementazione o decisioni tecniche
   - Nota eventuali file di codice specifici o aree menzionate
   - Cerca action item o prossimi passi
   - Identifica a che stadio si trova l'idea (ideazione iniziale vs pronto per implementare)
   - Prenditi del tempo per riflettere profondamente su come distillare l'essenza di questo documento in una chiara dichiarazione del problema e approccio alla soluzione

3. **Controlla il contesto correlato (se menzionato nel doc):**
   - Se il documento fa riferimento a file di codice specifici, leggi le sezioni rilevanti
   - Se menziona altri documenti thoughts, controllali rapidamente
   - Cerca eventuali ticket Linear già menzionati

4. **Ottieni il contesto del workspace Linear:**
   - Elenca i team: `mcp__linear__list_teams`
   - Se ci sono più team, chiedi all'utente di selezionarne uno
   - Elenca i progetti per il team selezionato: `mcp__linear__list_projects`

5. **Bozza del riepilogo del ticket:**
   Presenta una bozza all'utente:
   ```
   ## Bozza Ticket Linear

   **Titolo**: [Titolo chiaro e orientato all'azione]

   **Descrizione**:
   [Riepilogo del problema/obiettivo in 2-3 frasi]

   ## Dettagli Chiave
   - [Punti elenco di dettagli importanti dai thoughts]
   - [Decisioni tecniche o vincoli]
   - [Eventuali requisiti specifici]

   ## Note di Implementazione (se applicabile)
   [Eventuali approcci tecnici specifici o passaggi delineati]

   ## Riferimenti
   - Fonte: `thoughts/[percorso/al/documento.md]` ([Visualizza su GitHub](URL GitHub convertito))
   - Codice correlato: [eventuali riferimenti file:line]
   - Ticket padre: [se applicabile]

   ---
   In base al documento, questo sembra essere nella fase di: [ideazione/pianificazione/pronto per implementare]
   ```

6. **Raffinamento interattivo:**
   Chiedi all'utente:
   - Questo riepilogo cattura accuratamente il ticket?
   - In quale progetto dovrebbe andare? [mostra lista]
   - Quale priorità? (Predefinito: Medium/3)
   - Qualche contesto aggiuntivo da aggiungere?
   - Dovremmo includere più/meno dettagli di implementazione?
   - Vuoi assegnarlo a te stesso?

   Nota: Il ticket sarà creato nello stato "Triage" per impostazione predefinita.

7. **Crea il ticket Linear:**
   ```
   mcp__linear__create_issue con:
   - title: [titolo raffinato]
   - description: [descrizione finale in markdown]
   - teamId: [team selezionato]
   - projectId: [progetto selezionato]
   - priority: [numero priorità selezionato, predefinito 3]
   - stateId: [ID stato Triage]
   - assigneeId: [se richiesto]
   - labelIds: [applica assegnazione automatica label]
   - links: [{url: "URL GitHub", title: "Titolo Documento"}]
   ```

8. **Azioni post-creazione:**
   - Mostra l'URL del ticket creato
   - Chiedi se l'utente vuole:
     - Aggiungere un commento con ulteriori dettagli di implementazione
     - Creare sotto-task per action item specifici
     - Aggiornare il documento thoughts originale con il riferimento al ticket
   - Se sì all'aggiornamento del doc thoughts:
     ```
     Aggiungi all'inizio del documento:
     ---
     linear_ticket: [URL]
     created: [data]
     ---
     ```

## Esempi di trasformazioni:

### Da thoughts verbosi:
```
"Ho riflettuto su come le nostre sessioni non salvano correttamente le preferenze utente.
Questo sta causando problemi dove gli utenti devono riconfigurare tutto. Dovremmo probabilmente
memorizzare le preferenze nel database e caricarle quando inizia la sessione..."
```

### A ticket conciso:
```
Titolo: Salva e ripristina le preferenze utente tra le sessioni

Descrizione:

## Problema da risolvere
Attualmente, le preferenze utente non vengono mantenute tra le sessioni, costringendo gli utenti a
riconfigurare le impostazioni ogni volta che avviano una nuova sessione.

## Soluzione
Memorizzare le preferenze utente nel database e ripristinarle automaticamente quando una sessione
inizia, con supporto per override espliciti.
```

### 2. Aggiungere Commenti e Link ai Ticket Esistenti

Quando l'utente vuole aggiungere un commento a un ticket:

1. **Determina quale ticket:**
   - Usa il contesto dalla conversazione corrente per identificare il ticket rilevante
   - Se incerto, usa `mcp__linear__get_issue` per mostrare i dettagli del ticket e confermare con l'utente
   - Cerca riferimenti ai ticket nel lavoro recente discusso

2. **Formatta i commenti per chiarezza:**
   - Mantieni i commenti concisi (~10 righe) a meno che non servano più dettagli
   - Concentrati sull'intuizione chiave o l'informazione più utile per un lettore umano
   - Non solo cosa è stato fatto, ma cosa è importante riguardo ad esso
   - Includi riferimenti ai file rilevanti con backtick e link GitHub

3. **Formattazione dei riferimenti ai file:**
   - Racchiudi i percorsi in backtick: `src/components/example.tsx`
   - Aggiungi link GitHub dopo: `([Visualizza](url))`
   - Fallo sia per i file thoughts/ che per i file di codice menzionati

4. **Esempio di struttura del commento:**
   ```markdown
   Implementata logica di retry per affrontare problemi di rate limit.

   Intuizione chiave: Le risposte 429 erano raggruppate durante operazioni batch,
   quindi il backoff esponenziale da solo non era sufficiente - aggiunta coda richieste.

   File aggiornati:
   - `src/api/handler.ts` ([GitHub](link))
   - `thoughts/shared/rate_limit_analysis.md` ([GitHub](link))
   ```

### 3. Cercare Ticket

Quando l'utente vuole trovare ticket:

1. **Raccogli criteri di ricerca:**
   - Testo query
   - Filtri Team/Project
   - Filtri Status
   - Range di date (createdAt, updatedAt)

2. **Esegui la ricerca:**
   ```
   mcp__linear__list_issues con:
   - query: [testo ricerca]
   - teamId: [se specificato]
   - projectId: [se specificato]
   - stateId: [se filtrando per stato]
   - limit: 20
   ```

3. **Presenta i risultati:**
   - Mostra ID ticket, titolo, stato, assegnatario
   - Raggruppa per progetto se ci sono più progetti
   - Includi link diretti a Linear

### 4. Aggiornare lo Stato del Ticket

Quando sposti ticket attraverso il workflow:

1. **Ottieni lo stato corrente:**
   - Recupera i dettagli del ticket
   - Mostra lo stato corrente nel workflow

2. **Suggerisci lo stato successivo:**
   Basato sulla tipica progressione del workflow

3. **Aggiorna con contesto:**
   ```
   mcp__linear__update_issue con:
   - id: [ID ticket]
   - stateId: [ID nuovo stato]
   ```

   Considera di aggiungere un commento spiegando il cambio di stato.

## Note Importanti

- Mantieni i ticket concisi ma completi - punta a contenuto scansionabile
- Tutti i ticket dovrebbero includere un chiaro "problema da risolvere" - se l'utente chiede un ticket e fornisce solo dettagli di implementazione, DEVI chiedere "Per scrivere un buon ticket, per favore spiega il problema che stai cercando di risolvere dal punto di vista dell'utente"
- Concentrati su "cosa" e "perché", includi "come" solo se ben definito
- Preserva sempre i link al materiale sorgente usando il parametro `links`
- Non creare ticket da brainstorming in fase iniziale a meno che non venga richiesto
- Usa la formattazione markdown appropriata di Linear
- Includi riferimenti al codice come: `percorso/al/file.ext:numerorighe`
- Chiedi chiarimenti piuttosto che indovinare progetto/stato
- Ricorda che le descrizioni Linear supportano markdown completo inclusi blocchi di codice
- Usa sempre il parametro `links` per URL esterni (non solo link markdown)
- Ricorda - devi ottenere un "Problema da risolvere"!

## Linee Guida per la Qualità dei Commenti

Quando crei commenti, concentrati sull'estrarre le **informazioni più preziose** per un lettore umano:

- **Intuizioni chiave sopra riassunti**: Qual è il momento "aha" o la comprensione critica?
- **Decisioni e compromessi**: Quale approccio è stato scelto e cosa abilita/previene
- **Blocchi risolti**: Cosa stava impedendo il progresso e come è stato affrontato
- **Cambi di stato**: Cosa è diverso ora e cosa significa per i prossimi passi
- **Sorprese o scoperte**: Risultati inaspettati che influenzano il lavoro

Evita:
- Liste meccaniche di modifiche senza contesto
- Ripetere ciò che è ovvio dai diff del codice
- Riassunti generici che non aggiungono valore

Ricorda: L'obiettivo è aiutare un lettore futuro (incluso te stesso) a capire rapidamente cosa è importante riguardo a questo aggiornamento.
