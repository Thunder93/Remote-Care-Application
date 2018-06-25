# Remote-Care-Application - Eine Case-Study zur Nutzung von Jolie.

Als Grundlage dient das folgende Paper: [Design and Implementation of a Remote Care Application Based on Microservice Architecture](https://arxiv.org/pdf/1804.09976v1.pdf).
## Grundidee
>This paper presents a case study of an MSA-based Remote Care Application (RCA) that allows caregivers to remotely access smart home devices. The goal of the RCA is to assist persons being cared in Activities of Daily Living.

Im Zuge dessen werden vier Microservices umgesetzt:
- **RemoteControl** - Verarbeitet ankommendende aufrufe, prüft mithilfe des AccessControl-Service ob ein Nutzer berechtigt ist und schickt dann den entsprechenden Befehl an den SmartHomeClient
- **AccessControl** - Prüft ob ein Nutzer berechtigt ist, einen Befehl auf einem Gerät in einem SmartHome auszuführen
- **SmartHomeClient** - Führt den erhaltenen Befehl aus, und schickt den neuen Status an den History-Service
- **History** - Speichert den erhaltenen neuen Status eines Smarthomedevices in einer persistenten Datenbank

## Installation und Vorraussetzungen
Insgesamt sind folgende Vorraussetzungen zu erfüllen:
- Installieres Jolie ([Anleitung](http://www.jolie-lang.org/downloads.html))
- [MySQL Server](https://dev.mysql.com/downloads/installer/) als Nutzer dient in diesem Beispiel "root" mit Passwort "root"

## Ausführung
Insgesamt müssen alle vier Services jeweils in einer eignen Kommandozeile gestartet werden, die Reihenfolge ist wichtig.
- `jolie history.ol`
- `jolie smartHomeClient.ol`
- `jolie accessControl.ol`
- `jolie remoteControl.ol Anna Home1 Radio 1`
### Parameter für den Remote-Control-Service
1. Parameter (Nutzer):
-hinterlegt ist nur der Nutzer `Anna`
2. Parameter (SmartHome):
    1. `Home1`
    2. `Home2`
3. Parameter (Device):
    1. `Radio`
    2. `TV`
4. Parameter(On/Off State)
    1. `1`
    2. `0`
