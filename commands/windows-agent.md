# Windows - Zabbix Agent 2

Vérifier :

```powershell
Get-Service "Zabbix Agent 2"

Arrêter :

Stop-Service "Zabbix Agent 2"

Démarrer :

Start-Service "Zabbix Agent 2"

Vérifier le port :

netstat -ano | findstr :10050