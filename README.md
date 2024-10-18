# GDRCD-Stack

Lo scopo di GDRCD-Stack è di fornire un basilare ambiente di sviluppo per [GDRCD](https://github.com/GDRCD/GDRCD), lo Script per la creazione di Giochi di Ruolo "Play by Chat" su browser, fornendo all'utilizzatore tutti gli strumenti necessari per la sua realizzazione.

Questa soluzione è stata pensata prevalentemente per lo sviluppo in locale, tuttavia può essere utilizzato anche per un ambiente di produzione.

## Requisiti

Per utilizzare lo stack presente in questa repository, occorre aver installato sul proprio terminale Docker e GIT.
Di seguito, gli indirizzi con i riferimenti per l'installazione di questi strumenti:

- [Docker Desktop (o Docker Toolbox)](https://www.docker.com/products/docker-desktop)
- [GIT](https://git-scm.com/downloads)

Occorre avere un minimo di dimestichezza con il terminale (come può essere Powershell, la Bash di Linux o il terminale di macOS) per poter utilizzare lo stack.

## Installazione

Per utilizzare GDRCD-stack, clona il progetto in una qualsiasi cartella sul tuo PC. Puoi farlo scaricando l'intero progetto compresso in una cartella zip oppure utilizzando GIT ed eseguendo il seguente comando:

```shell
git clone https://github.com/GDRCD/GDRCD-stack.git
```

Il comando salverà in una cartella `gdrcd-stack` l'intera struttura. Puoi inserirlo in una cartella a tuo piacimento, aggiungendo in fondo al comando sopra indicato il nome della cartella desiderata (qualora non sia presente, la crea in automatico).

Una volta terminato il salvataggio dei file dello stack, occorre inserire il proprio progetto dentro la cartella `service`. Può essere fatto manualmente, così come attraverso `git`.
Per chi sta iniziando con un nuovo progetto di GDRCD, sarà sufficiente eseguire i seguenti comandi:

```shell
cd service # ci si sposta nella cartella del progetto
git clone https://github.com/GDRCD/GDRCD.git # clona il progetto GDRCD
```

A questo punto, copiare il file `sample.env` in un nuovo file `.env` e compilare le varie variabili presenti.
È molto importante specificare quale versione di PHP si desidera utilizzare, popolando la variabile `PHP_VERSION` con il numero di versione desiderato tra quelle disponibili.

Di seguito le versioni attualmente supportate, con i relativi riferimenti:
- PHP 5.6 (php56)
- PHP 7.4 (php74)
- PHP 8.0 (php8)

Puoi cambiare la versione PHP utilizzata in qualsiasi momento, cambiando la variabile nel file `.env`  e ricostruendo lo stack.

Ora il tuo GDRCD-Stack è pronto e funzionante!

## Utilizzo

Per facilitare l'utilizzo dello strumento, è stato predisposto il comando `gdrcd-stack` che raccoglie una serie di comandi utili all'esecuzione delle funzioni primarie dello stack.
Il comando non è altro che un file eseguibile da terminale, motivo per il quale è necessario usare la formula:

```shell
./gdrcd-stack <comando>
```

Per avviare l'esecuzione dei servizi dello stack, sarà sufficiente eseguire il seguente comando:

```shell
./gdrcd-stack start
```

In automatico avverrà la compilazione dello stack, processo che si occuperà di costruire i singoli servizi e di istanziarli in appositi container di docker, e l'avvio dei servizi.

La compilazione dello stack può essere effettuata manualmente in qualsiasi momento, attraverso il comando:

```shell
./gdrcd-stack build
```

Ciò può essere utile qualora vengono apportate modifiche allo stack, come ad esempio una modifica alla versione PHP utilizzata, o se si desidera aggiungere nuovi servizi.

Per fermare i servizi dello stack, è sufficiente eseguire il seguente comando:

```shell
./gdrcd-stack stop
```

Assieme a questi comandi, è stato predisposto anche un comando per rimuovere compleatamente lo stack, in modo da poterne ricominciare da capo:

```shell
./gdrcd-stack clean
```

## Comandi Utili

Di seguito i comandi a disposizione:

```shell
./gdrcd-stack start # avvia lo stack
./gdrcd-stack stop # ferma lo stack
./gdrcd-stack restart # riavvia lo stack
./gdrcd-stack build # compila lo stack
./gdrcd-stack clean # rimuove tutti tutti i servizi generati dallo stack
./gdrcd-stack help # mostra i comandi a disposizione
```

## Servizi Disponibili

Lo stack mette a disposizione una serie di servizi, che sono:
- Web Server (nginx)
- PHP (php56, php74, php8)
- MySQL (mysql5.7)
- PhpMyAdmin (phpmyadmin)
- Mailhog (mailhog)

N.B.:
Il servizio `mailhog` è un servizio di test che permette di visualizzare le email inviate dal sistema e funziona solo in ambiente `dev`.

## Segnalazione bug e richieste di aiuto

Prima di aprire una segnalazione bug o una richiesta di aiuto, assicurati che il tuo problema non sia già stato trattato
tra le varie [issues](https://github.com/GDRCD/GDRCD-stack/issues). Se non trovi nulla, puoi aprirne una nuova
[qui](https://github.com/GDRCD/GDRCD-stack/issues/new).

## Riferimenti

Di seguito le versioni di riferimento dell'engine OS GDRCD:

- [GDRCD](https://github.com/GDRCD/GDRCD) © GDRCD Organization, licenza CC

## Licenza
[MIT](https://choosealicense.com/licenses/mit/)

