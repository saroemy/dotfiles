---
name: commit
description: Crea commit git per le modifiche della sessione corrente, raggruppando le modifiche correlate con messaggi chiari e descrittivi.
---

# Commit Changes

Ti è stato assegnato il compito di creare commit git per le modifiche apportate durante questa sessione.

## Processo:

1. **Pensa a cosa è cambiato:**
   - Rivedi la cronologia della conversazione e comprendi cosa è stato realizzato
   - Esegui `git status` per vedere le modifiche attuali
   - Esegui `git diff` per comprendere le modifiche
   - Considera se le modifiche dovrebbero essere un unico commit o più commit logici

2. **Pianifica i tuoi commit:**
   - Identifica quali file appartengono insieme
   - Bozza messaggi di commit chiari e descrittivi
   - Usa il modo imperativo nei messaggi di commit
   - Concentrati sul perché le modifiche sono state apportate, non solo su cosa

3. **Presenta il tuo piano all'utente:**
   - Elenca i file che intendi aggiungere per ogni commit
   - Mostra i messaggi di commit che utilizzerai
   - Chiedi: "Ho intenzione di creare [N] commit con queste modifiche. Devo procedere?"

4. **Esegui dopo la conferma:**
   - Usa `git add` con file specifici (non usare mai `-A` o `.`)
   - Crea commit con i messaggi pianificati
   - Mostra il risultato con `git log --oneline -n [numero]`

## Importante:
- **NON aggiungere MAI informazioni sul coautore o attribuzione a Claude**
- I commit dovrebbero essere creati esclusivamente dall'utente
- Non includere messaggi "Generato con Claude"
- Non aggiungere righe "Co-Authored-By"
- Scrivi i messaggi di commit come se li avesse scritti l'utente

## Ricorda:
- Hai il contesto completo di ciò che è stato fatto in questa sessione
- Raggruppa le modifiche correlate
- Mantieni i commit focalizzati e atomici quando possibile
- L'utente si fida del tuo giudizio - ti ha chiesto di fare il commit
