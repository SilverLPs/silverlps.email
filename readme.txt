OfflineIMAP:

- Umlaute funktionieren nicht, auch wenn das für das Backup scheinbar irrelevant ist (testen schadet nie)
- Readonly wird zwar für das Mailkonto in der Konfiguration spezifiziert, allerdings macht es Sinn, das MailDir Verzeichnis selbst auch regelmäßig zu sichern, damit im Falle eines Fehlers auch wirklich ein Backup bereitsteht
- Der quiet Modus gibt gar keine Informationen mehr aus. Um sicherzustellen, dass alle Informationen ausgegeben werden, muss der basic Modus verwendet werden. Dieser flutet aber den Log mit absolut allen synchronisierten E-Mails. Es empfiehlt sich, inital einmal manuell das MailDir Repository mit BisonBackup zu synchronisierten, damit die Log-Dateien danach nicht geflutet werden und übersichtlich bleiben
- OfflineIMAP legt Cache-Datenbanken für jedes lokale und entfernte Repository (also sowohl die Mailkonten als auch die MailDir Verzeichnisse) an und zwar im Homeverzeichnis unter .offlineimap. Laut ChatGPT hat ein löschen des Cache Ordners die Folge, dass alle Mails neu heruntergeladen werden, auch wenn es angeblich keine Korruption oder Duplizierung auslöst. Dennoch sollte dies kritisch betrachtet und eher vermieden werden. Repositories sollten dementsprechend auch nicht umbenannt werden. Wenn ein Cache Ordner wegfällt oder das Repository umbenannt werden soll, so empfiehlt es sich, das Repository einmal komplett neu anzulegen. Dies sollte auch keine Auswirkungen auf eine spätere Deduplizierung durch Borg z.B. haben, da alle Mails ja eh einzelne Dateien im MailDir Verzeichnis sind.
- OfflineIMAP ignoriert eingestellte umasks, es muss also nachher ggf. mit dem bisonbackup.general.permissions Modul nachgezogen werden
- OAuth2 funktioniert grundsätzlich nicht, eine Implementation wäre mit OfflineIMAP unverhältnismäßig kompliziert, die Tokens würden regelmäßig ablaufen usw. Damit funktioniert Office 365 aka outlook.com GAR NICHt, da dort nur OAuth2 unterstützt wird.
- Es kann bei sehr seltenen einzelnen Mails zu folgendem Fehler kommen, der in OfflineIMAP selbst generiert wird und vorgeblich in modernen Versionen bereits gefixt ist, allerdings auch bereits jetzt sonst keinen Schaden anrichtet oder sonst den Sync der anderen Mails beeinträchtigt oder abbricht:
ERROR: UID XXX (<Unknown Message-ID>) has defects preventing it from being processed!
  UnicodeEncodeError: 'ascii' codec can't encode characters in position XXX: ordinal not in range(128)
- Es gab noch einen Fehler mit irgendwelchen Separatoren in der UID, der ist nach dem ersten Sync des Mailkontos nicht wieder aufgetaucht und betraf auch nur vereinzelte Mails, aber darauf sollte man etwas achten
- Insgesamt ist das ganze Modul eigentlich eher als "besser als nichts" betrachtet werden. Es sichert die meisten Mails auf den meisten Mailkonten recht zuverlässig, aber es nicht vollständig fehlerfrei und auch nicht perfekt auf die Idee der "offiziellen" BisonBackup Module, von Portabilität und das Integrieren der Software in die Module, optimiert.

Roadmap:
- Umstellung auf isync/mbsync evaluieren, falls es einige der oben genannten Probleme und einige der Fehler behebt
- Ggf. könnte dann auch OfflineIMAP in eingeschränkter Form als optionales, umstellbares Backend erhalten bleiben
