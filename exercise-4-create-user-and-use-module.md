# Exercice 4 - Création d'utilisateur et installation d'un module

## Créer un utilisateur avec Puppet

* Créer un manifeste `user.pp` avec le contenu suivant (remplacer $user par votre nom et l'UID par votre année de naissance + votre mois de naissance (exemple 1988 + 12 => 2000), le GID correspond à votre mois de naissance multiplier par votre jour de naissance (exemple 12*9 => 108)):

```puppet
user { '$user':
	ensure => present,
	uid => 2000,
	gid => 108,
	comment => '$user User',
	managehome => true,
}
```
* Appliquer le manifeste
```shell
sudo puppet apply user.pp
```
* Vérifier que l'utilisateur $user a bien été créé.
```shell
getent passwd $user
```
* Vous devriez voir les détail sur l'utilisateur

* Créer un nouveau manifest pour supprimer l'utilisateur que vous avez créé
* Appliquer ce manifeste, et vérifier que l'utilisateur n'existe plus avec la commande :
```shell
getenv passwd $user
```


## Installer et utiliser un module de la forge

* La forge de puppet fournit de nombreux modules pré-existant : https://forge.puppet.com/ 
* Utiliser la commande `puppet module`pour
    * rechercher un module python
    * trouver le bon module pour installer python.
    * télécharger et installer ce module

* Où le module s'est t'il installé ?
* Ecrire un manifeste qui utilise ce module
* Exécuter le manifeste que vous avez écrit
* Vérifier que python est installé avec la commande 
```shell
python --version
```