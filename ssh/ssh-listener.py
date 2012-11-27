#!/usr/bin/env python

# Echo server program
import socket
import shlex, subprocess
import sys
import os
import os.path

NOTIFIER  = '/usr/bin/notify-send'
VIEWER  = '/usr/bin/see'
OPENER = '/usr/bin/xdg-open'
HOST = 'localhost'
PORT = 8088

# Daemonization
PID_FILE = "/tmp/ssh-listener.pid"
UMASK = 766
WORKDIR='/tmp/'
MAXFD=1024

if (hasattr(os, "devnull")):
   REDIRECT_TO = os.devnull
else:
   REDIRECT_TO = "/dev/null"

def createDaemon():
   """Detach a process from the controlling terminal and run it in the
   background as a daemon.
   """

   try:
      pid = os.fork()
   except OSError, e:
      raise Exception, "%s [%d]" % (e.strerror, e.errno)
   if (pid == 0):	# The first child.
      os.setsid()
      try:
         pid = os.fork()	# Fork a second child.
      except OSError, e:
         raise Exception, "%s [%d]" % (e.strerror, e.errno)
      if (pid == 0):	# The second child.
         os.chdir(WORKDIR)
         os.umask(UMASK)
      else:
         os._exit(0)	# Exit parent (the first child) of the second child.
   else:
      os._exit(0)	# Exit parent of the first child.
   import resource		# Resource usage information.
   maxfd = resource.getrlimit(resource.RLIMIT_NOFILE)[1]
   if (maxfd == resource.RLIM_INFINITY):
      maxfd = MAXFD
   # Iterate through and close all file descriptors.
   for fd in range(0, maxfd):
      try:
         os.close(fd)
      except OSError:	# ERROR, fd wasn't open to begin with (ignored)
         pass
   # This call to open is guaranteed to return the lowest file descriptor,
   # which will be 0 (stdin), since it was closed above.
   os.open(REDIRECT_TO, os.O_RDWR)	# standard input (0)
   # Duplicate standard input to standard output and standard error.
   os.dup2(0, 1)			# standard output (1)
   os.dup2(0, 2)			# standard error (2)
   return(0)

def parse(data):
    data = data.split('\n', 1)
    (action, args) = data.pop(0).split(' ', 1)
    if len(data) > 0:
        data = data[0]
    else:
        data = ''
    return (action, args, data)

def action_notify(summary, message):
    return [NOTIFIER, summary, message]

def action_send(filename, content):
    f = open(filename, 'wb')
    f.write(content)
    f.close()
    return [VIEWER , filename]

def action_open(url, content):
    return [OPENER , url]

if __name__ == '__main__':
    fg = False

    ### check arguments

    # check for help
    if len(sys.argv) == 2 and sys.argv[1] in ('-h', '--help') or len(sys.argv) > 2 :
        print '''Usage: %s [-s|-f|-h]
Usage: %s [--stop|--foreground|--help]

Running with no argument or one wrong argument, will still launch the daemon.
Only one argument is expected. More will give you that help message.

    -s|--stop           stop the running daemon
    -f|--foreground     executes in foreground (and outputs all notifications to stdout)
    -h|--help           this help message
''' % (sys.argv[0], sys.argv[0])
        sys.exit(0)

    # check for -stop
    if len(sys.argv) == 2 and sys.argv[1] in ('--stop', '-s'):
        if not os.path.isfile(PID_FILE):
            print 'nothing to stop. exiting...'
            sys.exit(1)
        try:
            os.kill(int(open(PID_FILE, 'r').read()), 9)
        except ValueError, ve:
            print 'Invalid PID file. exiting...'
            sys.exit(1)
        except OSError, oe:
            print 'Invalid PID: %s. Process has already exited. exiting...' % int(open(PID_FILE, 'r').read())
            sys.exit(1)
        os.unlink(PID_FILE)
        print 'notify daemon killed'
        sys.exit(0)

    if os.path.isfile(PID_FILE):
        print 'Daemon is already running... Exiting.'
        sys.exit(1)

    if not (len(sys.argv) == 2 and sys.argv[1] in ('-f', '--foreground')):
        print 'Starting server as daemon...'
        retCode = createDaemon()

        # create PID file
        f = open(PID_FILE, 'w').write(str(os.getpid()))
    else:
        fg = True
        print 'Starting server in foreground mode...'

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind((HOST, PORT))
    s.listen(1)
    if fg is True: print 'Listening on '+str(HOST)+':'+str(PORT)+'...'

    # daemon main loop
    while True:
        data = ''
        conn, addr = s.accept()
        if fg is True: print 'RCPT'
        while 1:
            tmp = conn.recv(1024)
            if not tmp: break
            data += tmp
        conn.close()

        (action, args, data) = parse(data)
        function = locals()['action_'+action.lower()]
        p = subprocess.Popen(function(args, data))

    sys.exit(retCode)
