---
name: debug
description: Aiuta a risolvere problemi esaminando log, database e stato git senza modificare file.
---

# Debug

Ti viene assegnato il compito di aiutare a risolvere i problemi durante i test manuali o l'implementazione. Questo comando ti consente di indagare sui problemi esaminando i log, lo stato del database e la cronologia di git senza modificare i file. Pensalo come un modo per avviare una sessione di debug senza utilizzare il contesto della finestra principale.

## Risposta Iniziale

Quando richiamato CON un file di piano/ticket:
```
Aiuterò a risolvere i problemi con [nome file]. Fammi capire lo stato attuale.

Quale problema specifico stai riscontrando?
- Cosa stavi cercando di testare/implementare?
- Cosa è andato storto?
- Ci sono messaggi di errore?

Indagherò i log, il database e lo stato di git per aiutare a capire cosa sta succedendo.
```

Quando richiamato SENZA parametri:
```
Aiuterò a risolvere il tuo problema attuale.

Descrivi cosa sta andando storto:
- Su cosa stai lavorando?
- Quale problema specifico si è verificato?
- Quando ha funzionato l'ultima volta?

Posso indagare i log, lo stato del database e le modifiche recenti per aiutare a identificare il problema.
```

## Informazioni sull'ambiente

Hai accesso a queste posizioni e strumenti chiave per il debug:

**Log** (comunemente in queste posizioni):
- Log dell'applicazione: Controlla le directory dei log specifiche del progetto
- Log di sistema: `/var/log/` (Linux/Mac) o visualizzatore eventi (Windows)
- Log del server di sviluppo: Solitamente nella root del progetto o nei file `.log`
- Log del servizio: Controlla dove i tuoi servizi scrivono i log

**Database**:
- Posizione: Specifica del progetto (controlla i file di configurazione)
- Tipo: SQLite, PostgreSQL, MySQL, MongoDB, ecc.
- Può interrogare direttamente con gli strumenti CLI appropriati

**Stato Git**:
- Controlla il branch corrente, i commit recenti, le modifiche non commesse
- Simile a come funzionano i comandi `commit` e `describe_pr`

**Stato del servizio**:
- Controlla se i servizi sono in esecuzione: `ps aux | grep [nome-servizio]`
- Controlla le porte: `lsof -i :[porta]` o `netstat -an | grep [porta]`
- Controlla lo stato del processo

## Fasi del Processo

### Fase 1: Comprendere il Problema

Dopo che l'utente descrive il problema:

1.  **Leggi qualsiasi contesto fornito** (piano o file del ticket):
    *   Comprendi cosa stanno implementando/testando
    *   Annota in quale fase o passaggio si trovano
    *   Identifica il comportamento atteso rispetto a quello effettivo

2.  **Controllo rapido dello stato**:
    *   Branch git corrente e commit recenti
    *   Eventuali modifiche non commesse
    *   Quando ha iniziato a verificarsi il problema

### Fase 2: Indagare il Problema

Avvia agenti Task paralleli per un'indagine efficiente:

```
Task 1 - Controlla i Log Recenti:
Trova e analizza i log più recenti per errori:
1. Identifica le posizioni dei file di log (controlla la configurazione o le posizioni comuni)
2. Cerca errori, avvisi o problemi intorno al periodo in cui si è verificato il problema
3. Cerca stack trace o errori ripetuti
4. Controlla la correlazione temporale con il momento in cui si è verificato il problema
5. Annota eventuali schemi insoliti
Ritorna: Errori/avvisi chiave con timestamp e contesto
```

```
Task 2 - Stato del Database (se applicabile):
Controlla lo stato attuale del database:
1. Connettiti al database usando lo strumento appropriato
2. Controlla lo schema e le tabelle pertinenti
3. Interroga i dati recenti relativi al problema
4. Cerca stati bloccati, anomalie o dati mancanti
5. Controlla eventuali violazioni di vincoli o problemi di chiavi esterne
Ritorna: Risultati pertinenti del database
```

```
Task 3 - Stato di Git e dei File:
Comprendi cosa è cambiato di recente:
1. Controlla lo stato di git e il branch corrente
2. Guarda i commit recenti: git log --oneline -10
3. Controlla le modifiche non commesse: git diff
4. Verifica che i file attesi esistano
5. Cerca eventuali problemi di permessi dei file
6. Controlla se le dipendenze sono aggiornate
Ritorna: Stato di Git e eventuali problemi dei file
```

```
Task 4 - Ambiente e Dipendenze (se rilevante):
Controlla la configurazione dell'ambiente:
1. Verifica che le variabili d'ambiente siano impostate correttamente
2. Controlla le versioni delle dipendenze: package.json, requirements.txt, go.mod, ecc.
3. Cerca versioni in conflitto
4. Controlla che gli artefatti di build siano aggiornati
5. Verifica che i file di configurazione siano corretti
Ritorna: Stato dell'ambiente e delle dipendenze
```

### Step 3: Present Findings

Based on the investigation, present a focused debug report:

```markdown
## Debug Report

### What's Wrong
[Clear statement of the issue based on evidence]

### Evidence Found

**From Logs**:
- [Error/warning with timestamp]
- [Pattern or repeated issue]
- [Stack trace or error message]

**From Database** (if applicable):
```sql
-- Relevant query and result
[Finding from database]
```

**From Git/Files**:
- [Recent changes that might be related]
- [File state issues]
- [Dependency or build issues]

### Root Cause
[Most likely explanation based on evidence]

### Next Steps

1. **Try This First**:
   ```bash
   [Specific command or action]
   ```

2. **If That Doesn't Work**:
   - Restart services
   - Clear cache/build artifacts
   - Check browser console (for web apps)
   - Run with debug/verbose logging
   - Verify environment configuration

3. **Additional Investigation**:
   - [Specific area to look into]
   - [Alternative hypothesis to test]

### Can't Access?
Some issues might be outside my reach:
- Browser console errors (F12 in browser)
- Network requests (check browser Network tab)
- System-level issues (permissions, firewall, etc.)
- External service outages

Would you like me to investigate something specific further?
```

## Important Notes

- **Focus on manual testing scenarios** - This is for debugging during implementation
- **Always require problem description** - Can't debug without knowing what's wrong
- **Read files completely** - No limit/offset when reading context
- **Think like `commit` or `describe_pr`** - Understand git state and changes
- **Guide back to user** - Some issues (browser console, network, external services) are outside reach
- **No file editing** - Pure investigation only
- **Use parallel tasks** - Investigate multiple areas concurrently for efficiency

## Quick Reference

**Find Latest Logs** (adjust paths for your project):
```bash
# Find recent log files
find . -name "*.log" -type f -mtime -1

# Tail log file
tail -f /path/to/app.log

# Search for errors
grep -i error /path/to/app.log
```

**Database Queries** (examples for common databases):
```bash
# SQLite
sqlite3 database.db ".tables"
sqlite3 database.db "SELECT * FROM table_name ORDER BY created_at DESC LIMIT 5;"

# PostgreSQL
psql -d database_name -c "SELECT * FROM table_name ORDER BY created_at DESC LIMIT 5;"

# MySQL
mysql -u user -p database_name -e "SELECT * FROM table_name ORDER BY created_at DESC LIMIT 5;"
```

**Service Check**:
```bash
# Check if service is running
ps aux | grep [service-name]

# Check port usage
lsof -i :[port-number]

# Check listening ports
netstat -tuln | grep [port-number]
```

**Git State**:
```bash
git status
git log --oneline -10
git diff
git diff --staged
```

**Environment Check**:
```bash
# Check Node.js version
node --version

# Check Python version
python --version

# Check installed packages
npm list (Node.js)
pip list (Python)
go list -m all (Go)
```

Remember: This command helps you investigate without burning the primary window's context. Perfect for when you hit an issue during manual testing and need to dig into logs, database, or git state.
