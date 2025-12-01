FROM python:trixie

# De gekozen numerieke ID (moet overeenkomen met de PUID/PGID van code-server)
ARG PUID=1001
ARG PGID=1001

# De gewenste gebruikersnaam
ARG USERNAME=abc
ARG PASSWORD=abc

# Installeer OpenSSH Server en benodigde tools
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    rm -rf /var/lib/apt/lists/*

# 2. Maak de gebruiker 'abc' aan met de numerieke ID's 1001:1001
# We gebruiken 'abc' als zowel de gebruikersnaam als de groepsnaam voor consistentie.
RUN addgroup --gid $PGID $USERNAME \
    && adduser --uid $PUID --ingroup $USERNAME --disabled-password --gecos "" $USERNAME

# 3. Configureer SSH en stel wachtwoord in voor 'abc'
# Sta inloggen met wachtwoord toe (gebruik SSH-sleutels voor productie!)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
# Wachtwoord instellen voor de nieuwe gebruiker 'abc'
RUN echo "$USERNAME:$PASSWORD" | chpasswd

# 4. Stel de nodige directory voor de SSH daemon in
RUN mkdir -p /var/run/sshd

# 5. Geef de gebruiker 'abc' eigenaarschap over de applicatie directory (voor schrijfrechten)
WORKDIR /app
COPY . /app
RUN chown -R $USERNAME:$USERNAME /app

# 6. Definieer de opstartopdracht om zowel SSH als je applicatie te starten
EXPOSE 22
# Definieer de commando's die je applicatie moet uitvoeren
CMD ["/usr/sbin/sshd", "-D"]
