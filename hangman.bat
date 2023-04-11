@echo off
setlocal EnableDelayedExpansion

set words=apple banana cherry durian elephant fig grapefruit
set /a max_guesses=7
set /a num_guesses=0
set word_length=0
set word=""
set guessed_letters=

:: Choose a random word from the list
for %%w in (%words%) do (
  set /a index=!random!%%!words: =!
  if !index! equ 0 set word=%%w
  set /a words-=1
)

:: Determine the length of the word
for /f "tokens=*" %%w in ("%word%") do (
  set /a word_length=%%w
)

:: Set up the hidden word with underscores
set hidden_word=
for /l %%i in (1,1,%word_length%) do (
  set hidden_word=!hidden_word!_
)

:: Main game loop
:game_loop
cls
echo Hangman Game
echo.
echo Word: !hidden_word!
echo.
echo Guessed letters: !guessed_letters!
echo.
echo Guess a letter:
set /p guess=

:: Validate the guess
set valid_guess=0
for /f "tokens=*" %%g in ("%guess%") do (
  if "%%g" neq "" if "%%g" geq "a" if "%%g" leq "z" set valid_guess=1
  if "%%g" neq "" if "%%g" geq "A" if "%%g" leq "Z" set valid_guess=1
)
if %valid_guess% equ 0 (
  echo Invalid guess! Please enter a letter.
  pause >nul
  goto game_loop
)

:: Check if the guess is correct
set correct_guess=0
for /f "tokens=*" %%w in ("%word%") do (
  set "temp_word=%%w"
  for /l %%i in (0,1,%word_length%-1) do (
    set "temp_letter=!temp_word:~%%i,1!"
    if /i "%guess%"=="!temp_letter!" (
      set "hidden_word=!hidden_word:~0,%%i!!guess!!hidden_word:~%%i+1!"
      set correct_guess=1
    )
  )
)
if %correct_guess% equ 1 (
  echo Correct guess!
) else (
  echo Incorrect guess!
  set /a num_guesses+=1
)

:: Add the guessed letter to the list
set guessed_letters=!guessed_letters!!guess!

:: Check if the player has won or lost
if "%hidden_word%"=="%word%" (
  cls
  echo Hangman Game
  echo.
  echo Word: !hidden_word!
  echo.
  echo Congratulations, you won!
  pause >nul
  exit /b
)
if %num_guesses% geq %max_guesses% (
  cls
  echo Hangman Game
  echo.
  echo Word: %word%
  echo.
  echo Sorry, you lost!
  pause >nul
  exit /b
)

:: Keep playing
goto game_loop
