#!/bin/bash
#Good Luck 
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME_INPUT

USER_ROW=$($PSQL "SELECT user_id, games_played, best_game FROM users WHERE username='$USERNAME_INPUT'")

if [[ -z $USER_ROW ]]
then
  echo "Welcome, $USERNAME_INPUT! It looks like this is your first time here."
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME_INPUT', 0, 0)")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME_INPUT'")
else
  USER_ID=$(echo $USER_ROW | cut -d '|' -f 1)
  GAMES_PLAYED=$(echo $USER_ROW | cut -d '|' -f 2)
  BEST_GAME=$(echo $USER_ROW | cut -d '|' -f 3)
  echo "Welcome back, $USERNAME_INPUT! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

SECRET_NUMBER=$((RANDOM % 1000 + 1))
NUMBER_OF_GUESSES=0

echo "Guess the secret number between 1 and 1000:"
read GUESS

while true
do
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    read GUESS
    continue
  fi

  NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))

  if [[ $GUESS -eq $SECRET_NUMBER ]]
  then
    echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

    NEW_GAMES_PLAYED=$((${GAMES_PLAYED:-0} + 1))

    if [[ -z $BEST_GAME || $BEST_GAME -eq 0 || $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
    then
      NEW_BEST_GAME=$NUMBER_OF_GUESSES
    else
      NEW_BEST_GAME=$BEST_GAME
    fi

    $PSQL "UPDATE users SET games_played=$NEW_GAMES_PLAYED, best_game=$NEW_BEST_GAME WHERE user_id=$USER_ID" > /dev/null

    break
  elif [[ $GUESS -lt $SECRET_NUMBER ]]
  then
    echo "It's higher than that, guess again:"
    read GUESS
  else
    echo "It's lower than that, guess again:"
    read GUESS
  fi
done
