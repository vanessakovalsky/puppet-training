# Exercice 5 - Conditions et boucles

## Facter et les conditions de test

* Rappel : vous pouvez voir les facts en utilisant facter. Lancer seulement :
```shell
facter
```

* Reprendre le manifest webserver de l'exercice 3
* Ajouter une condition basé sur la famille de l'OS :
    * si vous ête sur un sytème de type Debian, installer le paquet 'apache2'
    * si vous êtes sur un stystème de type Redhat, installer le paquet 'httpd'
* Appliquer votre manifeste pour vérifier votre syntaxe


## Ecrire une notification sur une boucle

* Créer un manifest notify-os.pp 
* Celui-ci doit envoyer une notification pour informer du type de système d'exploitation utilisé par l'agent
* Pour cela utiliser la fonction case 