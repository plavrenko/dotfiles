# startup script for python to enable saving of interpreter history and
# enabling name completion

# import needed modules
import atexit
import os
import readline
import rlcompleter
import sys

# where is history saved
historyPath = os.path.expanduser("~/.pyhistory")

# handler for saving history
def save_history(historyPath=historyPath):
	import readline
	readline.write_history_file(historyPath)

# read history, if it exists
if os.path.exists(historyPath):
	readline.read_history_file(historyPath)

# register saving handler
atexit.register(save_history)

# enable completion
if sys.platform.startswith('darwin'):
	# for BSD readline
	readline.parse_and_bind('bind ^I rl_complete')
else:
	# for GNU readline
	readline.parse_and_bind('tab: complete')

# cleanup
del os, atexit, readline, rlcompleter, save_history, historyPath
