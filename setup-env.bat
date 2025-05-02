@echo off
REM Create virtual environment
python -m venv venv

REM Activate virtual environment
call venv\Scripts\activate

REM Upgrade pip
python -m pip install --upgrade pip

REM Install required libraries
pip install spotipy
pip install Flask
pip install flask-cors

echo.
echo All packages installed successfully.
echo Virtual environment is activated.
echo.

REM Run your script
python music_chatbot2.py

pause
