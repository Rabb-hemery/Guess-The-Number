# Guess-The-Number
A Bash guessing game connected to a PostgreSQL database that keeps track of players' statistics. Project completed as part of the freeCodeCamp Relational Database certification.

# Number Guessing Game

A command-line guessing game where the user must guess a secret number between 1 and 1000. Each player's statistics (number of games played, best score) are saved in a PostgreSQL database. Project completed as part of the [freeCodeCamp Relational Database Certification](https://www.freecodecamp.org/learn/relational-database/).

## How it works

The script asks for a username:
- If it already exists in the database, it displays a welcome message with the number of games played and the best score.
- Otherwise, it displays a welcome message for a new player.

Then, a random number between 1 and 1000 is generated, and the user has to guess it. With each guess, the script indicates whether the secret number is higher or lower. Once the number is found, the player's statistics are updated in the database.

## Files

- `number_guess.sh` — the game script
- `number_guess.sql` — the SQL dump to rebuild the database

## Usage

Rebuild the database:

```bash
psql -U postgres < number_guess.sql
```

Run the game:

```bash
./number_guess.sh
```

Execution example:



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

## Database

The `number_guess` database contains a `users` table with the following columns:

| Column         | Type          | Description                              |
|----------------|---------------|------------------------------------------|
| `user_id`      | SERIAL (PK)   | Unique identifier for the player         |
| `username`     | VARCHAR(22)   | Unique username                          |
| `games_played` | INT           | Total number of games played             |
| `best_game`    | INT           | Best score (fewest guesses)              |

## Technologies

- PostgreSQL
- Bash

## Author

Project completed as part of the freeCodeCamp curriculum.
