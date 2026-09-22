# AWS Zabbix Monitoring Lab

Infrastructure de supervision centralisée déployée sur AWS avec Zabbix, Docker, Linux et Windows Server.

## Objectif

Mettre en place une infrastructure permettant de superviser plusieurs serveurs Linux et Windows depuis une plateforme Zabbix centralisée.

## Architecture

- AWS VPC : `10.0.0.0/16`
- Subnet : `10.0.1.0/24`
- Zabbix Server
- Linux Server
- Windows Server
- Docker
- Zabbix Agent 2

## Technologies

- AWS EC2
- AWS VPC
- Security Groups
- Ubuntu Linux
- Windows Server
- Docker
- Docker Compose
- Zabbix
- Zabbix Agent 2

## Sécurité

Les accès d'administration sont restreints selon le principe du moindre privilège.

- SSH 22 : My IP
- RDP 3389 : My IP
- HTTP/HTTPS : My IP
- Zabbix Agent 10050 : réseau privé
- Zabbix Server 10051 : réseau privé

L'utilisation de `My IP` plutôt que `0.0.0.0/0` permet de réduire la surface d'attaque et d'éviter d'exposer inutilement les interfaces d'administration à Internet.

## Monitoring

Zabbix collecte notamment :

- CPU
- Mémoire
- Espace disque
- État des services
- Disponibilité des hôtes

## Tests d'incident

Des tests ont été réalisés en arrêtant volontairement Zabbix Agent 2 sur Linux et Windows.

Linux :

```bash
sudo systemctl stop zabbix-agent2
sudo systemctl start zabbix-agent2
sudo systemctl status zabbix-agent2

Windows :

Stop-Service "Zabbix Agent 2"
Start-Service "Zabbix Agent 2"
Get-Service "Zabbix Agent 2"

Zabbix détecte l'indisponibilité puis confirme le retour à l'état normal après redémarrage de l'agent.

Résultats
Supervision centralisée fonctionnelle
Linux et Windows monitorés
Collecte continue des métriques
Visualisation CPU/RAM
Détection d'incidents
Retour automatique à l'état disponible après rétablissement
Captures
Infrastructure AWS

Hôtes Zabbix

Monitoring Windows

Monitoring Linux

Améliorations futures
Automatisation de l'infrastructure avec Terraform
Notifications Zabbix
HTTPS
Monitoring du serveur Zabbix lui-même
Infrastructure multi-subnets
Déploiement via CI/CD
Auteur

Nesta Kengni

DevOps & Cloud Engineer