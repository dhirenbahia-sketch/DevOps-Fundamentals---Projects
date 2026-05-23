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




The password for the next level is stored somewhere on the server and has all of the following properties:

owned by user bandit7
owned by group bandit6
33 bytes in size

This level clearly requires understanding of permissions. Time to review that information again. 


Realised that find . is not going to work here, we need to cast a wider net than simply searching through the current directory onwards. Starting to search from the root directory instead will yield more results for us to look at. Used find / -user bandit7 -size 33c at first which yielded many results, but fewer than with jsut one condition. Thinking of adding the third flag which is searching for the group too. Tip seems to be to attach 2>/dev/null on the end of the command to clean up the output and make sure errors are discarded. 

Combining all aspects into one command yields a result. find / -user bandit7 -group bandit6 -size 33c 2>/dev/null

Using cd command to get into the directory containing the password file, and then catting the password file gives us the password. The key for this level was understanding that i needed to cast as wide a net as possible using find . and also that I needed to discard standard errors using 2>dev/null. Important to go over the standard error videos again. 


1. The 2 (Targeting Errors)
The number 2 tells the terminal to isolate the Standard Error pipeline. It leaves your successful data pipeline (1) completely untouched.

2. The > (The Redirector)
The > symbol is a redirection operator. It acts like a one-way valve, taking whatever data is coming out of the stream on its left and forcing it into the destination on its right.

3. The /dev/null (The Black Hole)
In Linux, /dev/null is a special system file known as the null device. It is a virtual trash can or digital shredder. Any data written to it is instantly deleted by the operating system and vanishes forever.


Password: morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj






Level 8


The password for the next level is stored in the file data.txt next to the word millionth


Thinking of utilising the grep command, which is used to print lines that match patterns.Rewatched the grep video which showed me how to use the command. Man page for grep felt slightly unclear. Need to get used to it or using a tldr man page version for commands. Performed grep 'millionth' data.txt.

Password: dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc



Level 9


The password for the next level is stored in the file data.txt and is the only line of text that occurs only once

Going to be using piping to redirect data output from one tool to another tool. Then that output should yield the answer.

Sort can sort data in alphabetical order. Grep (maybe) can look at the sorted list and sort it by identifying duplicate lines. 

Started using the tldr man pages as of this level. 

Solution:

After further research, I find that it is actually the uniq command that must be used. Specifically the uniq -u command, which filters out anything that appears more than once. 

cat data.txt | sort | uniq -u

The KEY here is that the uniq command can only work once a list has been sorted. Then we pipe between the sorted list and the uniq -u command, which will only output lines that are NOT repeated in the input. 


Password:4CKMh1JI91bUIZZPXDqGanal4xvAg0JM


Level 10 


The password for the next level is stored in the file data.txt in one of the few human-readable strings, preceded by several ‘=’ characters.


From Google search, found out that the most efficient solution is likely using strings command piped with grep to find strings that actually begin with '=='

Firstly, strings command prints the printable (i.e. readable) strings of text within the text file. This is then piped throughto the grep command which will pinpoint specific patterns buried in otherwise unreadable data, where in this case it allows us to find two equals signs next to each other before the text. 




Password: FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey



Level 11

The password for Level 11 is stored in data.txt, which contains base64 encoded data.

ssh bandit10@bandit.labs.overthewire.org -p 2220 Password: FGUW5ilLVJrxX9kMYMmlN4Mgbpfmiqey

Once logged in: ls cat data.txt base64 -d data.txt

Explanation
cat data.txt showed a string of seemingly random characters — it was base64 encoded
base64 -d data.txt decoded the file and printed the original content
The decoded output contained the password. Or could have used cat data.txt | base64 -d piping technique to arrive at the solution. 

Password: dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr


Level 12



The password for Level 12 is stored in data.txt, where all lowercase and uppercase letters have been rotated by 13 positions (ROT13 cipher). Used what I had learned from research on StackOverflow about how to solve the ROT13 famous cipher.


Once logged in: ls cat data.txt cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'



Password: 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4




Level 13 


The password for the next level is stored in the file data.txt, which is a hexdump of a file that has been repeatedly compressed. For this level it may be useful to create a directory under /tmp in which you can work. Use mkdir with a hard to guess directory name. Or better, use the command “mktemp -d”. Then copy the datafile using cp, and rename it using mv (read the manpages!)

See notepad or online solution for full notes but tldr, rinsing the use of the file command, interlaced with an assortment of different decompression commands. 

Password: FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn


Level 14


The password for the next level is stored in /etc/bandit_pass/bandit14 and can only be read by user bandit14. For this level, you don’t get the next password, but you get a private SSH key that can be used to log into the next level. Look at the commands that logged you into previous bandit levels, and find out how to use the key for this level.
If you need help with this level: a hint file can be found in the home directory.
Make sure to read the error messages as they are informative.

Intended solution was blocked apparently, since OverTheWire Bandit blocks localhost SSH connections to conserve resources. 

What we did instead.

Tried both localhost and .org connections which were both blocked. Then printed key with cat sshkey.private to extract it manually.
Then saved the clean key to my local machine on a separate Gitbash window as ~/bandit14.key to SHH from outside the server. 
Then enforced the chmod 600 ~/bandit14.key permission to the key because otherwise, SSH refuses keys with loosely set permissions. 
Finally, I connected from local machine, thus bypassing the block. ssh -i ~/bandit14.key bandit14@bandit.labs.overthewire.org -p 2220
Easily retrieved the password at the end, using command cat /etc/bandit_pass/bandit14. 

Password: MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS

Level 15

The password for the next level can be retrieved by submitting the password of the current level to port 30000 on localhost.

nc localhost 30000
This connects to the correct port 30000. After getting a blank line show up, I just need to paste the previously obtained password from this level's etc folder. Shows up as correct and provides me with the password required for the next level. 

Note that this level introduces the concept of network services. These are programs that listen on a port and respond to input. Netcat (NC) is similar to a raw telephone call to a port. You connect to it and type. Whatever you send, the service receives and responds to that. 

Password: 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo

Level 16

The password for the next level can be retrieved by submitting the password of the current level to port 30001 on localhost using SSL/TLS encryption.

OpenSSL's built in tool is the openssl s_client tool, which is useful for making SSL/TLS encrypted connections. It's like nc but with encryption and commonly used to test and debug SSL connections. 

Password:kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx

To solve this level, I made use of the openssl (instead of nc) because this allows for an encrypted connection to the port. The command was openssl s_client -connect localhost:30001

After the massive block of text, I pasted the password from the previous level and hit enter. It then stated that the password entered is correct, and I was provided the password needed for the next level. 

nc        → sends raw unencrypted text → port 30001 expects encrypted → rejected
s_client  → performs SSL handshake first → then sends encrypted text → accepted





























































