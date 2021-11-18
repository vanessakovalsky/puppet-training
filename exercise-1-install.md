# **exercice 1** - Installer l'environnement avec 3 conteneurs docker

## Objectifs : 
* Déployer 3 conteneurs contenant l'environnement nécessaire à l'utilisation de Puppet (un master, un agent et un conteneur avec gitlab pour stocker le code source)

## Pré-requis
* Avoir Git installé
* Avoir Docker installé 

## Créer et lancer le conteneur Puppet Master

* Pour lancer le conteneur du Puppet Master exécuter la commmande suivante : 
```
   docker run -d                         \
      --memory 4G                        \
      --ip 192.168.198.10                \
      -p 22022:22                        \
      -p 22443:443                       \
      -p 22080:8080                      \
      -p 22081:8081                      \
      -p 22140:8140                      \
      -p 22000:3000                      \
      --name puppet                      \
      --volume share:/share   \
      bentlema/centos6-puppet-nocm       \
      /sbin/init
```
* Vous obtiendrez alors un retour comme celui-ci : 
```
Unable to find image 'bentlema/centos6-puppet-nocm:latest' locally
latest: Pulling from bentlema/centos6-puppet-nocm
b6d7b2ebc0a7: Pull complete
f8d0a70b3a37: Pull complete
3a45149aa462: Pull complete
ed8f8a2946b2: Pull complete
14dd1ef04b2a: Pull complete
7c6783c108f4: Pull complete
7d3711267225: Pull complete
c4e780c655e7: Pull complete
Digest: sha256:321205a84c4340f0d24b56cb8def669ac5e769704d8d26921ba9af039c290833
Status: Downloaded newer image for bentlema/centos6-puppet-nocm:latest
1e728f78568bf155963a222f4aee9524c82d32a524449908158d3b924e687d44
```
* Votre conteneur **puppet** est maintenant démarré, laisser le tourner en arrière plan.
* Pour voir les conteneurs en cours d'exécution vous pouvez utiliser : 
```
     docker ps
```

## Se connecter au conteneur Puppet
* Pour vous connecter au conteneur utilisez la commande suivatne : 
```
     docker exec -it puppet /bin/bash
```

*OU*

```
     ssh -l root localhost -p 22022
```

* Le mot de passe par défaut est :  *foobar23*


## Créer et lancer le conteneur avec l'agent

* Lancer le conteneur avec la commande suivante : 
```
   docker run -d                        \
      --memory 512M                     \
      --ip 192.168.198.11               \
      -p 23022:22                       \
      --name agent                      \
      --volume share:/share  \
      bentlema/centos6-puppet-nocm      \
      /sbin/init
```
* Vous avez démarrer le conteneur **agent**, laisser le tourner en arrière plan.

* Pour voir les conteneurs en cours d'exécution, utilisez : 
```
     docker ps
```

## Se connecter au conteneur agent

* Utiliser la commande suivante pour vous connecter au conteneur
```
     docker exec -it agent /bin/bash
```

*OU*

```
     ssh -l root localhost -p 23022
```

* Le mot de passe par défaut est :  *foobar23*

## Créer et lancer le conteneur pour Gitlab

* Noter que l'image de conteneur que nous utilisons vient de *gitlab* directement. Cela nous permet d'avoir rapidement un outil fonctionnel sans besoin de l'installer.

```
   docker run --detach                   \
      --ip 192.168.198.12                \
      --publish 24022:22                 \
      --publish 24080:80                 \
      --publish 24443:443                \
      --name gitlab                      \
      --env GITLAB_DATABASE_POOL="3;"    \
      --env GITLAB_OMNIBUS_CONFIG="gitlab_rails['db_pool'] = 3" \
      --volume "gitlab/config:/etc/gitlab"   \
      --volume "gitlab/logs:/var/log/gitlab" \
      --volume "gitlab/data:/var/opt/gitlab" \
      gitlab/gitlab-ce:latest

```
* Attendre une ou deux minute que Gitlab se configure, puis essayer de se connecter à l'interface web sur : 

- GitLab Server: <http://127.0.0.1:24080/>

* On vous demande alors de définir un nouveau mot de passe, puis de vous connecter : 

- Username: ***root***
- Password: ***\<the password you just set\>***

* Votre Gitlab est prêt à être utilisé

## Tester la connectivité du réseau et la résolution de nom entre les conteneurs 

* Avant de continuer, assurons nous que l'on peut communiquer sur notre réseau interne de Docker entre chaque conteneur.
* Connecter vous aux conteneurs puppet et agent dans deux fenêtres de terminal différentes : 

- `docker exec -it puppet /bin/bash`
- `docker exec -it agent /bin/bash`

* Depuis chaque, tester que vous pouvez pinguer l'autre par son nom : 
    * Depuis le conteneur **puppet**, pinguer le conteneur **agent** en utilisant son nom raccourci : 
    ```
        ping agent
    ```
    * Vous devriez obtenir quelque chose comme ça : 
    ```
        [root@puppet /]# ping agent
        PING agent (192.168.198.11) 56(84) bytes of data.
        64 bytes from agent.example.com (192.168.198.11): icmp_seq=1 ttl=64 time=0.140 ms
        64 bytes from agent.example.com (192.168.198.11): icmp_seq=2 ttl=64 time=0.118 ms
        64 bytes from agent.example.com (192.168.198.11): icmp_seq=3 ttl=64 time=0.093 ms
        64 bytes from agent.example.com (192.168.198.11): icmp_seq=4 ttl=64 time=0.117 ms
        ^C
        --- agent ping statistics ---
        4 packets transmitted, 4 received, 0% packet loss, time 3352ms
        rtt min/avg/max/mdev = 0.093/0.117/0.140/0.016 ms
    ```
    * Appuyez sur **Control-C** pour arrêter le ping

    * Depuis le conteneur **agent**, pinguer le conteneur **puppet** en utilisant son nom court:
    ```
        ping puppet
    ```
    * Vous devriez obtenir quelque chose comme ça : 
    ```
        [root@agent /]# ping puppet
        PING puppet (192.168.198.10) 56(84) bytes of data.
        64 bytes from puppet.example.com (192.168.198.10): icmp_seq=1 ttl=64 time=0.103 ms
        64 bytes from puppet.example.com (192.168.198.10): icmp_seq=2 ttl=64 time=0.137 ms
        64 bytes from puppet.example.com (192.168.198.10): icmp_seq=3 ttl=64 time=0.195 ms
        64 bytes from puppet.example.com (192.168.198.10): icmp_seq=4 ttl=64 time=0.114 ms
        ^C
        --- puppet ping statistics ---
        4 packets transmitted, 4 received, 0% packet loss, time 3276ms
        rtt min/avg/max/mdev = 0.103/0.137/0.195/0.036 ms
    ```
    * Appuyez sur **Control-C** pour arrêter le ping

---

Okay, notre environnement d'exercice est prêt, et nous pouvons passer à la suite pour installer des outils  
---

