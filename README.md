# GDRCD-Stack
```*A solution stack built with Docker Compose for GdR play-by-chat project*```

Lo scopo di GDRCD-Stack è di fornire un basilare ambiente di sviluppo per il principale engine Open Source di Giochi di Ruolo play-by-chat,
garantendo gli strumenti necessari per qualsiasi esigenza.


Si tratta esclusivamente di ambienti focalizzati alla creazione del mock up del sito web mediante l'uso dell'engine GDRCD, pertanto 
non sono integrati soluzioni per la produzione e nemmeno strumenti per la pipeline.


## Requisiti

Per utilizzare lo stack presente in questa repository, occorre aver installato sul proprio terminale Docker e GIT.
Di seguito, gli indirizzi con i riferimenti per l'installazione di questi strumenti:

- [Docker Desktop (o Docker Toolbox)](https://www.docker.com/products/docker-desktop)
- [GIT](https://git-scm.com/downloads)

## Come iniziare

Per utilizzare gli GDR-Stack, seleziona dall'indice che trovi poco più sotto lo stack desiderato, in base all'engine che si è scelto
di utilizzare ( in questo caso GDRCD#5.x). Una volta aperta la pagina con il progetto, sarà sufficiente scaricare il progetto in formato ZIP o clonarlo tramite GIT.

Di seguito un esempio di comando GIT CLONE:

```shell
git clone --branch gdrcd-5.x https://github.com/Kasui92/gdr-stack [OPZ: cartella in cui salvare lo stack]
```

Salvato il progetto, occorre inserire l'engine ( o il progetto già realizzato ) dentro la cartella `services`.
Il processo può essere inserito direttamente dentro questa cartella o in una sottocartella. In quest'ultimo caso, 
occorrerà modificare la root nel file di configurazione.

Copiare il file `sample.env` in un nuovo file `.env` e compilare le varie variabili presenti.

Ora il tuo GDR-Stack è pronto e funzionante!!


## Comandi Utili 

Per avviare lo strumento, eseguire `docker-compose up -d` nel terminale bash aperto sulla root di GDR-STACK.

Per stoppare lo strumento, eseguire `docker-compose down` nel terminale bash aperto sulla root di GDR-STACK.

Per effettuare un avvio pulito delle immagini e dei container di GDR-Stack (questo processo non compromette i volumi creati in precedenza!),
eseguire `docker-compose down --rmi all && docker-compose up -d` nel terminale bash aperto sulla root di GDR-STACK.

## Segnalazione bug e richieste di aiuto

Prima di aprire una segnalazione bug o una richiesta di aiuto, assicurati che il tuo problema non sia già stato trattato 
tra le varie [issues](https://github.com/Kasui92/gdr-stack/labels/gdrcd-5.x). Se non trovi nulla, puoi aprirne una nuova
[qui](https://github.com/Kasui92/gdr-stack/issues/new).

## Riferimenti

Di seguito le versioni di riferimento dell'engine OS GDRCD:

- [GDRCD#5.5.1](https://github.com/GDRCD/GDRCD) © GDRCD Organization, licenza CC

## Licenza
[MIT](https://choosealicense.com/licenses/mit/)

