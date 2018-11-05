# Imports
import keyboard
from time import sleep
import requests

pressEnter = True
sleeptime = int(input('Time between insults\n> '))

print('Starting in 5 seconds...')
sleep(5)


while True:
    text = requests.get('https://insult.mattbas.org/api/insult').text
    # Keybord api hates uppercase 
    text = text.lower()
    
    # Writes the text
    keyboard.write(text, delay=0.05)
    # If pressEnter = True then press enter after writing text.
    if pressEnter == True:
        # Slight delay because computers are not perfect
        sleep(0.3)
        keyboard.send('enter')
    sleep(sleeptime)
