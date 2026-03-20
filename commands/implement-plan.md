---
name: implement-plan
description: Implementa un piano tecnico approvato seguendo le fasi e verificando i criteri di successo.
---

# Implementa Piano

Hai il compito di implementare un piano tecnico approvato da `thoughts/shared/plans/`. Questi piani contengono fasi con modifiche specifiche e criteri di successo.

## Iniziare

Quando viene fornito un percorso del piano:
- Leggi il piano completamente e controlla eventuali checkmark esistenti (- [x])
- Leggi il ticket originale e tutti i file menzionati nel piano
- **Leggi i file completamente** - non usare mai parametri limit/offset, hai bisogno del contesto completo
- Rifletti profondamente su come i pezzi si incastrano insieme
- Crea una todo list per tracciare i tuoi progressi
- Inizia l'implementazione se capisci cosa deve essere fatto

Se non viene fornito un percorso del piano, chiedine uno.

## Filosofia di Implementazione

I piani sono progettati con cura, ma la realtà può essere disordinata. Il tuo lavoro è:
- Seguire l'intento del piano adattandoti a ciò che trovi
- Implementare ogni fase completamente prima di passare alla successiva
- Verificare che il tuo lavoro abbia senso nel contesto più ampio del codebase
- Aggiornare i checkbox nel piano man mano che completi le sezioni

Quando le cose non corrispondono esattamente al piano, pensa al perché e comunica chiaramente. Il piano è la tua guida, ma il tuo giudizio conta anche.

Se incontri una discrepanza:
- FERMATI e rifletti profondamente sul perché il piano non può essere seguito
- Presenta il problema chiaramente:
  ```
  Problema nella Fase [N]:
  Previsto: [cosa dice il piano]
  Trovato: [situazione effettiva]
  Perché questo è importante: [spiegazione]

  Come devo procedere?
  ```

## Approccio alla Verifica

Dopo aver implementato una fase:
- Esegui i controlli dei criteri di successo (tipicamente `{{TEST_COMMAND}}` e comandi build/lint)
- Correggi eventuali problemi prima di procedere
- Aggiorna i tuoi progressi sia nel piano che nelle tue todo
- Spunta gli elementi completati nel file del piano stesso usando Edit
- **Pausa per verifica umana**: Dopo aver completato tutta la verifica automatizzata per una fase, mettiti in pausa e informa l'umano che la fase è pronta per i test manuali. Usa questo formato:
  ```
  Fase [N] Completata - Pronta per Verifica Manuale

  Verifica automatizzata superata:
  - [Elenca i controlli automatizzati superati]

  Per favore esegui i passaggi di verifica manuale elencati nel piano:
  - [Elenca gli elementi di verifica manuale dal piano]

  Fammi sapere quando i test manuali sono completi così posso procedere alla Fase [N+1].
  ```

Se istruito ad eseguire più fasi consecutivamente, salta la pausa fino all'ultima fase. Altrimenti, presumi di dover fare solo una fase.

Non spuntare gli elementi nei passaggi di test manuali fino a conferma da parte dell'utente.

## Se Ti Blocchi

Quando qualcosa non funziona come previsto:
- Prima, assicurati di aver letto e compreso tutto il codice rilevante
- Considera se il codebase si è evoluto da quando il piano è stato scritto
- Presenta la discrepanza chiaramente e chiedi indicazioni

Usa le sotto-attività con parsimonia - principalmente per debugging mirato o esplorazione di territorio sconosciuto.

## Riprendere il Lavoro

Se il piano ha checkmark esistenti:
- Fidati che il lavoro completato sia fatto
- Riprendi dal primo elemento non spuntato
- Verifica il lavoro precedente solo se qualcosa sembra strano

Ricorda: Stai implementando una soluzione, non solo spuntando caselle. Tieni a mente l'obiettivo finale e mantieni slancio in avanti.
