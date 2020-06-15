
# Automatically reload *.py files when executing commands
%load_ext autoreload
%autoreload 2

# execute & capture shell expressions (replace shellcommand)
!ls
var1=!ls
%sc yourvar=shellcommand

# matplotlib dark color theme
import matplotlib.pyplot as plt
plt.style.use('dark_background')

# interactive charts
%matplolib

# magic command descriptions
# see update procedure below

%alias          Define an alias for a system command.
%alias_magic    Create an alias for an existing line or cell magic.
%autoawait      Allow to change the status of the autoawait option.
%autocall       Make functions callable without having to type parentheses.
%automagic      Make magic functions callable without having to type the initial %.
%bookmark       Manage IPython’s bookmark system.
%cd             Change the current working directory.
%colors         Switch color scheme for prompts, info system and exception handlers.
%conda          Run the conda package manager within the current kernel.
%config         configure IPython
%debug          Activate the interactive debugger.
%dhist          Print your history of visited directories.
%dirs           Return the current directory stack.
%doctest_mode   Toggle doctest mode on and off.
%edit           Bring up an editor and execute the resulting code.
%env            Get, set, or list environment variables.
%gui            Enable or disable IPython GUI event loop integration.
%history        Print input history (_i<n> variables), with most recent last.
%killbgscripts  Kill all BG processes started by %%script and its family.
%load           Load code into the current frontend.
%load_ext       Load an IPython extension by its module name.
%loadpy         Alias of
%logoff         Temporarily stop logging.
%logon          Restart logging.
%logstart       Start logging anywhere in a session.
%logstate       Print the status of the logging system.
%logstop        Fully stop logging and close log file.
%lsmagic        List currently available magic functions.
%macro          Define a macro for future re-execution. It accepts ranges of history, filenames or string objects.
%magic          Print information about the magic function system.
%matplotlib     Set up matplotlib to work interactively.
%notebook       Export and convert IPython notebooks.
%page           Pretty print the object and display it through a pager.
%pastebin       Upload code to dpaste’s paste bin, returning the URL.
%pdb            Control the automatic calling of the pdb interactive debugger.
%pdef           Print the call signature for any callable object.
%pdoc           Print the docstring for an object.
%pfile          Print (or run through pager) the file where an object is defined.
%pinfo          Provide detailed information about an object.
%pinfo2         Provide extra detailed information about an object.
%pip            Run the pip package manager within the current kernel.
%popd           Change to directory popped off the top of the stack.
%pprint         Toggle pretty printing on/off.
%precision      Set floating point precision for pretty printing.
%prun           Run a statement through the python code profiler.
%psearch        Search for object in namespaces by wildcard.
%psource        Print (or run through pager) the source code for an object.
%pushd          Place the current dir on stack and change directory.
%pwd            Return the current working directory path.
%pycat          Show a syntax-highlighted file through a pager.
%pylab          Load numpy and matplotlib to work interactively.
%quickref       Show a quick reference sheet
%recall         Repeat a command, or get command to input line for editing.
%rehashx        Update the alias table with all executable files in $PATH.
%reload_ext     Reload an IPython extension by its module name.
%rerun          Re-run previous input
%reset          Resets the namespace by removing all names defined by the user, if called without arguments, or by removing some types of objects, such as everything currently in IPython’s In[] and Out[] containers (see the parameters for details).
%reset_selectiveResets the namespace by removing names defined by the user.
%run            Run the named file inside IPython as a program.
%save           Save a set of lines or a macro to a given filename.
%sc             Shell capture - run shell command and capture output (DEPRECATED use !).
%set_env        Set environment variables.  Assumptions are that either “val” is a name in the user namespace, or val is something that evaluates to a string.
%sx             Shell execute - run shell command and capture output (!! is short-hand).
%system         Shell execute - run shell command and capture output (!! is short-hand).
%tb             Print the last traceback.
%time           Time execution of a Python statement or expression.
%timeit         Time execution of a Python statement or expression
%unalias        Remove an alias
%unload_ext     Unload an IPython extension by its module name.
%who            Print all interactive variables, with some minimal formatting.
%who_ls         Return a sorted list of all interactive variables.
%whos           Like %who, but gives some extra information about each variable.
%xdel           Delete a variable, trying to clear it from anywhere that IPython’s machinery has references to it. By default, this uses the identity of the named object in the user namespace to remove references held under other names. The object is also removed from the output history.
%xmode          Switch modes for the exception handlers.


# :update:
#   import requests
#   r = requests.get("https://ipython.readthedocs.io/en/stable/interactive/magics.html")
#   import lxml.html
#   xml = lxml.html.fromstring(r.content)
#   magics = xml.xpath('//dl[@class="magic"]/dt/code/text()')
#   descs = xml.xpath('//dl[@class="magic"]/dt/code/../../dd/p[1]/text()')
#   dict(zip(magics, descs))
#   b = ""
#   %store b >/tmp/test.txt
