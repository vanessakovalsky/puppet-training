# Exercice 3 - Créer son premier manifest

## Pré-requis 

* Avoir accès à un server Puppet master 

## Installer un serveur web

* Créer un fichier webserver.pp avec le contenu suivant : 
```
package { "apache2":
  ensure => installed,
}
```
* Appliquer le manifest 
```
puppet apply webserver.pp
```
* Vérifier que votre serveur est bien installé : 
```
ping localhost
```
* Doit vous renvoyer une page HTML

## Ajouter un fichier

* Créer un fichier `file.pp` avec le contenu suivant (remplacer $user par votre nom) :

```puppet
file { '/var/www/html/$user.html': #the path of the new file
	ensure => 'present',
	content => '<html>La super page html de $user</html>', #this text will be inside the file
}
```

* Appliquer le manifest

```shell
sudo puppet apply file.pp
```

* Vérifier sur le master que le fichier existe `/var/www/html/$user` et a le bon contenu.

* Appliquer de nouveau le manifest.
* Vérifier que le contenu n'a pas changer.
* Modifier le contenu du fichier.
* Appliquer le manifeste de nouveau.
* Vérifier que le contenu du fichier est revenu au contenu se trouvant dans le manifest

## Déploiement sur l'agent

* Attendre 10 minutes (ou le temps défini sur l'agent pour récupérer le contenu)
* Ouvrir un navigateur et se rendre à l'adresse IP de votre agent
* Ajouter le nom de votre fichier après l'adresse IP, vous devriez alors voir votre fichier apparaître