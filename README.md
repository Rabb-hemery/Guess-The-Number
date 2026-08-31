# Guess-The-Number
Un jeu de devinette en bash connecté à une base PostgreSQL, qui garde en mémoire les statistiques des joueurs. Projet réalisé dans le cadre de la certification Relational Database de freeCodeCamp.
# Number Guessing Game

Un jeu de devinette en ligne de commande où l'utilisateur doit deviner un nombre secret entre 1 et 1000. Les statistiques de chaque joueur (nombre de parties jouées, meilleur score) sont enregistrées dans une base de données PostgreSQL. Projet réalisé dans le cadre de la [certification Relational Database de freeCodeCamp](https://www.freecodecamp.org/learn/relational-database/).

## Fonctionnement

Le script demande un nom d'utilisateur :
- S'il existe déjà en base, il affiche un message de bienvenue avec le nombre de parties jouées et le meilleur score.
- Sinon, il affiche un message de bienvenue pour un nouveau joueur.

Ensuite, un nombre aléatoire entre 1 et 1000 est généré, et l'utilisateur doit le deviner. À chaque tentative, le script indique si le nombre à trouver est plus grand ou plus petit. Une fois le nombre trouvé, les statistiques du joueur sont mises à jour en base de données.

## Fichiers

- `number_guess.sh` — le script du jeu
- `number_guess.sql` — le dump SQL pour reconstruire la base de données

## Utilisation

Reconstruire la base de données :

```bash
psql -U postgres < number_guess.sql
```

Lancer le jeu :

```bash
./number_guess.sh
```

Exemple d'exécution :

```
Enter your username:
> rewrite

Welcome, rewrite! It looks like this is your first time here.
Guess the secret number between 1 and 1000:
> 500

It's lower than that, guess again:
> 250

It's higher than that, guess again:
> 375

You guessed it in 3 tries. The secret number was 375. Nice job!
```

## Base de données

La base `number_guess` contient une table `users` avec les colonnes suivantes :

| Colonne        | Type          | Description                              |
|----------------|---------------|-------------------------------------------|
| `user_id`      | SERIAL (PK)   | Identifiant unique du joueur              |
| `username`     | VARCHAR(22)   | Nom d'utilisateur, unique                 |
| `games_played` | INT           | Nombre total de parties jouées            |
| `best_game`    | INT           | Meilleur score (moins de tentatives)      |

## Technologies

- PostgreSQL
- Bash

## Auteur

Projet réalisé dans le cadre du cursus freeCodeCamp.
