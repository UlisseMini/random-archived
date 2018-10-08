# Imports
import keyboard
from time import sleep
# Config option
pressEnter = True

text = str(input('Text to repeat\n> '))
times = int(input('Times to repeat {}\n> '.format(text)))
sleeptime = float(input('How long to sleep between repeats\n> '))
print('Starting in 5 seconds...')
sleep(5)

for i in range(times):
    keyboard.write(text)
    # If pressEnter = True then press enter after writing text.
    if pressEnter == True:
        # Slight delay because computers are not perfect.
        sleep(0.3)
        keyboard.send('enter')
    sleep(sleeptime)
