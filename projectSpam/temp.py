# Imports
import keyboard
from time import sleep
# Config option
pressEnter = True

text = "https://bit.ly/2CUsPcX"
text = text.lower() # keyboard.write does not like capital letters

times = int(input('Times to repeat {}\n> '.format(text)))
sleeptime = float(input('How long to sleep between repeats\n> '))

print('Starting in 5 seconds...')
sleep(5)

for i in range(times):
    keyboard.write(text, delay=0.05)
    # If pressEnter = True then press enter after writing text.
    if pressEnter == True:
        # Slight delay because computers are not perfect.
        sleep(0.3)
        keyboard.send('enter')
    sleep(sleeptime)
