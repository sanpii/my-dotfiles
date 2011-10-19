# Default time a notification is show, unless specified in notification
DEFAULT_NOTIFY_TIMEOUT = 0 # milliseconds

# Maximum time a notification is allowed to show
MAX_NOTIFY_TIMEOUT = 0 # milliseconds

# Maximum number of characters in a notification.
NOTIFICATION_MAX_LENGTH = 100 # number of characters

# Time between regular status updates
STATUS_UPDATE_INTERVAL = 2.0 # seconds

# Command to fetch status text from. We read from stdout.
# Each argument must be an element in the array
# os must be imported to use os.getenv
import os
STATUS_COMMAND = ['/bin/sh', '%s/.statusline.sh' % os.getenv('HOME')]

# Always show text from STATUS_COMMAND? If false, only show notifications
USE_STATUSTEXT=True

# Put incoming notifications in a queue, so each one is shown.
# If false, the most recent notification is shown directly.
QUEUE_NOTIFICATIONS=True

# update_text(text) is called when the status text should be updated
# If there is a pending notification to be formatted, it is appended as
# the final argument to the STATUS_COMMAND, e.g. as $1 in default shellscript

# dwm statusbar update
import subprocess
def update_text(text):
    if text:
        p1 = subprocess.Popen(['echo', text], stdout=subprocess.PIPE)
        p2 = subprocess.Popen('dzen2 -p 3 -fg white -bg darkred'.split(' '), stdin=p1.stdout, stdout=subprocess.PIPE)
        p1.stdout.close()
        output = p2.communicate()[0]

