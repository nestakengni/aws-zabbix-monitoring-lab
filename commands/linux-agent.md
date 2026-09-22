# Linux - Zabbix Agent 2

Vérifier le service :

```bash
sudo systemctl status zabbix-agent2

Arrêter :

sudo systemctl stop zabbix-agent2

Démarrer :

sudo systemctl start zabbix-agent2

Redémarrer :

sudo systemctl restart zabbix-agent2

Vérifier le port :

sudo ss -lntp | grep 10050