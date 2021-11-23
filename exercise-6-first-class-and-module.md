# Exercice 6 - Classes et modules

## Pré-requis
* Afin de se faciliter la vie pour développer, nous allons utiliser  le puppetdevelopementKit, installer le depuis cette adresse : 
https://puppet.com/try-puppet/puppet-development-kit/


## Créer Votre premier module

* Créer votre propre module `notifier_$user` (en remplaçant $user par votre nom)
```
pdk new module notifier_myuser
```
* Se mettre dans le dossier du module créé
* Dans ce module, nous allons créer une classe appelée `my_notifier`
```
pdk new class my_notifier
```
* Cette classe appelle une ressource de type notify et affiche un message (de votre choix) (vous pouvez reprendre le contenu du manifeste de l'exercice 5).
* Etudier les fichiers générés par pdk dans le module (le détail de chaque fichier et dossier est expliqué ici : https://puppet.com/docs/pdk/2.x/pdk_creating_modules.html)

## Construire, installer et utiliser le module 

* Utiliser la commande pdk build notifier_myuser pour construire votre module et pouvoir l'utiliser
* Pour utiliser votre module : 
  * Soit vous le livrer (en vous créant un compte) sur la forge avec pdk release puis puppet module install
  * Soit vous copier le contenu de votre module vers /etc/puppetlabs/code/modules/

* Créer un manifeste dans lequel vous utiliser votre module et appliquer votre manifeste.
