Level 0 and 1

The goal of this is to connect to the game properly, understand how it works and ensure that I am pushing my notes to Github. The following are believed to be useful resources which can be used as an aid to solve the problems:

* gef (https://github.com/hugsy/gef) in /opt/gef/
~                                                                                      │    * pwndbg (https://github.com/pwndbg/pwndbg) in /opt/pwndbg/
~                                                                                      │    * gdbinit (https://github.com/gdbinit/Gdbinit) in /opt/gdbinit/
~                                                                                      │    * pwntools (https://github.com/Gallopsled/pwntools)
~                                                                                      │    * radare2 (http://www.radare.org/)i


Solution: cd gives us home directory
Then ls tells us readme file is located here
Then cat lets us read such file, where the password is stored


password: ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If

Level 2


Dash-prefixed filenames are files that begin with a hyphen ( - ), which can be mistaken for command-line options. For example: -file. txt.

In theory, could use file name redirection or just rename the file entirely using .mv command. 

Cat - in its nature is a standard input shortcut, to tell Linux you want to read the file named dash you must provide it with a path to do so. The ./ tells Linux to look in this current folder for a physical file named dash and to not use the keyboard shortcut.

Solution here is to use cat ./-
Password: 263JGJPfgU6LtdEvgfWU1XP5yac29mFx

ssh bandit1@bandit.labs.overthewire.org -p 2220


SECURITY NOTE: 

To prevent the server from crashing, the game developers do not allow you to SSH from one level to another directly. You must first exit the connection. This is so that the server's RAM and process limit is preserved as much as possible. It can create a Russian nesting doll of loads of open SSH connections.



Level 3

The password for the next level is stored in a file called --spaces in this filename-- located in the home directory.

Had a slight syntax discrepancy which made this level take longer than it should have. 

Solution:

Building from the last level, I can use cat ./ to open filenames starting with dashes. In this way, I can combine it with the knowledge that spaces in a filename can be propblematic to open in the normal way so single quotation mark wrapping is very useful here.

This combination results in:
cat ./'--spaces in this filename--'

Password: MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx


Level 4


The password for the next level is stored in a hidden file in the inhere directory.

Thinking of using a modified ls command to find the hidden files within the directory.
Looking through man ls. This was a good idea, found and used the ls -a modification which worked very well. Note that it's actually called a flag not a modification. 

Solution:
cat '...Hiding-From-You' - Think it can be a good habit to use single quotation marks going forward when catting files. Used ls -a which showed it hidden in the directory.


Password: 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ



Level 5


The password for the next level is stored in the only human-readable file in the inhere directory. Tip: if your terminal is messed up, try the “reset” command.


Looked at file documentation. Found that I can use file ./* to tell me the file types of all the different files. This easily points me in the direction of which is the human-readable file. 

file ./* breakdown. the ./ part means you are examining this very current directory while the * is known as a wildcard character which is used to represent every file (and directory) in your current location.

Password:
4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw


Level 6



The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties:

human-readable
1033 bytes in size
not executable

Opened up a couple of the files. Thinking I am going to need to use the find command with specific criteria in order to identify the appopriate file. 

Realised I can combine two flags of the find command together to determine the correct file. find . -size 1033c ! -executable     where the exclamation mark before executable tells Linux we are looking for non-executable files.

Ran the code, both the longer command and the command without the ! -executable flag work in finding the correct file within one of 19 directories!

Don't think ls on its own shows the .file2 so i used ls -a to show all files after which i found the correct one and it opened up as expected within one of the original 19 directories, nested within as one of several different files.

In future, worth figuring out how to use the ultra file command that shows the types of every file for HIDDEN files as well. Edit: 

Password:HWasnPhtq9AVKe0dmk45nxy20cvUa6EG 

Level 7

