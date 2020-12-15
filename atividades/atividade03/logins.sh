#!/bin/bash
grep -v 'sshd' /home/compartilhado/auth.log.1 

grep -E 'sshd.*session opened' /home/compartilhado/auth.log.1 

grep -E 'sshd.*Disconnected.*root' /home/compartilhado/auth.log.1 

grep -E 'Dec  4 18.*session opened' /home/compartilhado/auth.log.1 
