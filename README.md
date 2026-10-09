# NorskFlow

Gratis norsk diktering for Windows. Hold **Ctrl + Windows**, snakk, slipp, og teksten dukker opp der markøren står.
NB-Whisper fra Nasjonalbiblioteket gjør tale til tekst lokalt på PC-en, og Claude rydder opp teksten.

## Last ned

Trykk den grønne **Code**-knappen øverst på denne siden og velg **Download ZIP**. Pakk ut zip-filen og følg stegene under.

> Til deg som har fått denne: du trenger din egen Anthropic API-nøkkel (steg 3). Ikke del nøkkelen din med andre, og ikke del `config.json`.

Din egen Wispr Flow, laget for norsk. Hold Ctrl + Windows (nede til venstre), snakk, slipp. Teksten dukker opp der markøren står, i hvilket som helst program.

**Slik fungerer det:** NB-Whisper fra Nasjonalbiblioteket gjør tale om til tekst lokalt på PC-en din (gratis, lyden forlater aldri maskinen). Deretter rydder Claude opp teksten: fjerner ehm og øh, fikser selvkorrigeringer som «tirsdag, nei vent, onsdag», setter tegnsetting og lager lister når du lister opp ting. Bare teksten sendes til Claude, ikke lyden.

## Oppsett (ca. 15 minutter, én gang)

1. **Installer Python 3.12** fra python.org. Huk av «Add python.exe to PATH» i installasjonen.
2. **Dobbeltklikk `1_installer.bat`.** Den finner ut om du har Nvidia-skjermkort, installerer alt og laster ned den norske talemodellen. Det tar en stund første gang.
3. **Lag en API-nøkkel** på console.anthropic.com (API Keys, Create Key) og legg inn litt kreditt. Åpne `config.json` i Notisblokk og lim nøkkelen inn mellom anførselstegnene på `"anthropic_api_key": ""`.
4. **Dobbeltklikk `2_start.bat`.** Slå av Wispr Flow først, den bruker samme taster. En liten boks nederst på skjermen sier fra når den er klar.
5. Vil du at den starter automatisk med Windows: dobbeltklikk `3_autostart.bat`.

Husk å si opp Wispr Flow først når du er fornøyd.

## Bruk

| Tast | Hva skjer |
|---|---|
| Hold **Ctrl + Windows** | Tar opp. Slipp for å skrive inn teksten |
| **Esc** mens du holder | Avbryter opptaket |
| **Ctrl+Alt+V** | Limer inn forrige tekst på nytt |
| **Ctrl+Alt+H** | Åpner historikken |

**Historikk:** Alt du dikterer lagres før det limes inn, så ingenting forsvinner. Dobbeltklikk mikrofonikonet ved klokka (eller Ctrl+Alt+H) for å se alt, søke og trykke Kopier. Høyreklikk ikonet for flere valg, blant annet Avslutt. Historikken ligger i `historikk.jsonl`.

**Opptaksindikator:** Mens du holder tasten vises en mørk pille nederst på skjermen med rød prikk og en lydmåler, og ikonet ved klokka blir rødt.

Du kan si «ny linje», «nytt avsnitt», «punktum», «komma» og «spørsmålstegn».

## Innstillinger i config.json

- `push_to_talk`: tastene du holder. Standard `"ctrl+win"`. Andre eksempler: `"right ctrl"`, `"right alt"`, `"ctrl+shift"`, `"f9"`. Legg linjen til i config.json hvis du vil bytte.
- `whisper_model`: `"auto"` velger medium med Nvidia og small uten. Har du et kraftig skjermkort kan du prøve `"NbAiLab/nb-whisper-large"` for enda bedre resultat.
- Ordlista styrer du i appen: dobbeltklikk mikrofonikonet ved klokka og velg fanen Ordliste. Ord du retter med Rett-knappen i historikken læres automatisk. Den ligger i `ordliste.txt`.
- `style_rules`: egne regler for hvordan teksten skal se ut.
- `cleanup`: sett til `false` for kun lokal transkripsjon uten opprydding.
- `language`: `"no"` for bokmål, `"nn"` for nynorsk.

Etter at du har endret noe: dobbeltklikk `oppdater.bat`, så starter den på nytt.

## Hvis noe ikke virker

- **Kjør `feilsok.bat`**, så ser du feilmeldingene direkte. Det samme står i `norskflow.log`.
- **Ingenting skjer i et bestemt program:** programmer som kjører som administrator tar ikke imot tastene. Høyreklikk `2_start.bat` og velg «Kjør som administrator» hvis du trenger det der.
- **Treg:** uten Nvidia-skjermkort tar det noen sekunder. Prøv `"NbAiLab/nb-whisper-base"` for raskere, men litt dårligere, resultat.
- **Mikrofonikonet i Windows lyser hele tiden:** det er med vilje. Mikrofonen holdes åpen så første ord ikke blir kuttet, men ingenting tas opp eller sendes før du holder tasten.
- `historikk.txt` viser rå og ferdig tekst for hver diktering. Nyttig for å se hva opprydningen gjør.
