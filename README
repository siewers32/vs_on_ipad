# VS Code on IPad

### Setup
* Deze installatie is een proof of concept, waarbij vs-code-server, visual studio code als webapp publiceert.
* Draai de docker containers op een externe machine
* Open de webapp in je favoriete browser op ipad.

### Python
* Deze installatie werkt met python als programmeertaal, visual studio code bevat extensies voor het werken met python
* Python draait in een eigen container.

### Hoe werk het
* De containers hebben een user (abc) met hetzelfde UID en GID in alle containers
* In docker compose is een startup container die de gebruiker aanmaakt
* De vs-code-server en de python-server delen hetzelfde netwerk
* De vs-code-server en de python-server delen hetzelfde named volume
* Op de python-server draait OpenSSH
* Op basis van naam en wachtwoord (abc/abc) kun je vanuit de vs-code-server container via ssh inloggen op de python-server.

### Werkwijze
* Start de containers met `docker compose up -d`
* Er zijn 2 named containers beschikbaar: `code-server` en `py-server`
* Open de browser op iPad en ga naar <ip-adress:8443>. Hiermee op je vs-studio in de browser
* Je kunt met `<ip-adres:8443/?folder=/app_data>` visual studio direct openen in het gedeelde volume.
* Open een terminal-window in vs-studio. Gebruik `ssh abc@py-server` om connectie te maken met de python-container.Gebruik `abc/abc` als naam/wachtwoord.  Ga naar de `cd /app_data` directory.
* De bestanden in het file-overzicht in visual studio zijn nu gelijk aan de bestanden in de py-server container
* Run `python main.py` om te testen.
