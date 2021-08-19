import uinput
import time

device = uinput.Device([
        uinput.BTN_LEFT,
        uinput.BTN_RIGHT,
        uinput.BTN_EXTRA,
        uinput.REL_X,
        uinput.REL_Y,
        ])

for i in range(50):
    x = raw_input('Enter your name:')
    #device.emit(uinput.REL_X, 5)
    #device.emit(uinput.REL_X, 5)
    if ( x == 'p' ):
        time.sleep(1)
        device.emit(uinput.BTN_EXTRA, 1) #press
        print 'pressed!'
        for i in range(50):
            time.sleep(0.1)
            #device.emit(uinput.REL_Y, 5)
        print 'release'
        device.emit(uinput.BTN_EXTRA, 0) #release
    else:
        device.emit(uinput.BTN_EXTRA, 0) #release
    
