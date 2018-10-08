# Imports
import keyboard
from time import sleep
import requests

pressEnter = True
sleeptime = int(input('Time between insults\n> '))

print('Starting in 5 seconds...')
sleep(5)

def getText():
    return requests.get('https://insult.mattbas.org/api/insult').text

while True:
    text = getText()
    # Convert to lowercase to avoid an error.
    text = text.lower()

    keyboard.write(text, delay=0.1)
    # If pressEnter = True then press enter after writing text.
    if pressEnter == True:
        # Slight delay because computers are not perfect.
        sleep(0.3)
        keyboard.send('enter')
    sleep(sleeptime)
