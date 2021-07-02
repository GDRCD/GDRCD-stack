# GDR-Stack
```*A solution stack built with Docker Compose for GdR play-by-chat project*```

Lo scopo di GDR-Stack è di fornire un basilare ambiente di sviluppo per i principali engine Open Source di Giochi di Ruolo play-by-chat,
garantendo gli strumenti necessari per qualsiasi esigenza.

In questo branch è contenuto un ambiente dedicato allo sviluppo di play-by-chat attraverso l'impiego dell'engine GDRCD. 
Sono supportate tutte le versioni di GDRCD a parte dalla 5.1 .  


## Requisiti

Per utilizzare gli stack presenti in questa repository, occorre aver installato sul proprio terminale Docker e GIT.
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

Copiare il file `example.php.conf` in un nuovo file `php.conf` e modificare il campo `root` in base al path del progetto dentro `services`.
Se il progetto è stato inserito direttamente dentro a `services`, allora `root` sarà `/var/www/service`, se invece è dentro una sottocartella
allora sarà `/var/www/service/{NOME_SOTTOCARTELLA}`.

Ora il tuo GDR-Stack è pronto e funzionante!!


## Comandi Utili 

Per avviare lo strumento, eseguire `docker-compose up -d` nel terminale bash aperto sulla root di GDR-STACK.

Per stoppare lo strumento, eseguire `docker-compose down` nel terminale bash aperto sulla root di GDR-STACK.

Per effettuare un avvio pulito delle immagini e dei container di GDR-Stack (questo processo non compromette i volumi creati in precedenza!),
eseguire `docker-compose down --rmi all && docker-compose up -d` nel terminale bash aperto sulla root di GDR-STACK.

## Progetti Multipli

Questo servizio di GDR-Stack supporta più progetti.

Puoi aggiungere un nuovo progetto sottoforma di una nuova sottocartella dentro `services`.
N.B.: in questo caso, sarà necessario impostare `PHP_SERVICE` vuota.

Successivamente, occorre predisporre una nuova `WEB_PORT` nel proprio file `.env` e poi riportarlo nel file `docker-compose.yml`.

Ad esempio:

.evn:

`WEB2_PORT={NUMERO_PORTA}`

docker-compose.yml:

```
ports: 
- "${WEB_PORT}:80" 
- "${WEB2_PORT}:{//NUOVA_PORTA}" 
- "${PMA_PORT}:8080"
```

A questo punto, aggiungere nel proprio file `php.conf` un nuovo server in ascolto subito sotto a quello di default.

Es:

```
server {
    listen      {//NUOVA_PORTA};
    listen      [::]:{//NUOVA_PORTA};
    server_name gdrcd.test;
    root        /var/www/service/{NOME_SOTTOCARTELLA2};
    index       index.php;

    location / {
       try_files $uri $uri/ =404;
    }

    location ~* \.php$ {
        fastcgi_pass   php:9000;
        include        fastcgi_params;
        fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param  SCRIPT_NAME     $fastcgi_script_name;
    }
}
```

Il processo può essere applicato quante volte si vuole, rispettando i passaggi.

## Segnalazione bug e richieste di aiuto

Prima di aprire una segnalazione bug o una richiesta di aiuto, assicurati che il tuo problema non sia già stato trattato 
tra le varie [issues](https://github.com/Kasui92/gdr-stack/labels/gdrcd-5.x). Se non trovi nulla, puoi aprirne una nuova
[qui](https://github.com/Kasui92/gdr-stack/issues/new).

## Riferimenti

Di seguito gli engine di riferimento per la creazione di GdR Play-by-Chat:

- [GDRCD#5.5.1](https://github.com/GDRCD/GDRCD) © GDRCD Organization, licenza CC

## Licenza
[MIT](https://choosealicense.com/licenses/mit/)

