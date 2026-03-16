#Linux Terminal Lab Answers

## Hard Links vs Symbolic Links
- You have a symlink pointing to /etc/config/settings.txt. The sysadmin moves that file to /etc/config/old/settings.txt and creates a new file at the original path. Your symlink still works, but now points to different data. Why did this happen and how could you have prevented it?
  a symlink stores the file path, not the actual data. When a new file is created at the same path, the symlink then points to the new file.
- You delete all hardlinks to a file, but the inode still exists and the data isn’t freed. What’s keeping the file alive? (Hint: think about what has the file open)
  a process still has the file open, so the system keeps the inode until it's closed.
- You create 10 hardlinks to a file and then delete the original. You edit one of the hardlinks and add 50 lines. How many of the remaining hardlinks now have 150 lines, and why?
  all of them, becasue hardlinks share the same inode and data.
- You’re setting up a configuration system where a symlink in /home/user/config should always point to the active config in /opt/configs/. Why would a relative symlink break here but an absolute one wouldn’t?
  relative symlinks depend on the current directory structure, absolute symlinks always point to the exact full path

## File Permissions
- You set a file to 644 but users in the group still can’t read it. The file owner is you. What could be wrong, and how would you systematically debug this?
  the user might not be in the group, or the directory permissions may prevent access
- A script is 755 and owned by root. A regular user can execute it, but when the script tries to write to a file in /var/log/, it fails with “Permission denied”. Why, and what’s the security implication?
  the script runs with the permissions of the user executing it, not the owner of the file
- Your application needs to create files in /tmp that only the owner can read, but it needs to be run by multiple different users. If you just chmod 600 the directory, what breaks and why?
  other users can't enter the directory because directories require the execute bit to access contents
- You have a directory that’s drwxr-xr-x but you want to prevent others from listing the contents while still letting them access files if they know the name. What permission would you use and why does the execute bit matter here?
  use 711 permissions because it removes read permission but keeps execute permission

## Shell Scripts
- You write a script with #!/bin/bash but it still fails when run as ./script.sh from the cron daemon. The same script works fine when you run it manually. What’s likely wrong?
  cron runs with a minimal environment so PATH or variables may be missing
- A script uses read NAME but you’re piping input to it: echo "John" | ./script.sh. The script doesn’t receive the name. Why, and how would you fix it?
  read expects interactive input unless the script is written to read from stdin
- You pass 5 arguments to a script but only use $1 and $2. You later realize you need to pass the remaining arguments to another command: some_command $@. What’s the difference between $@ and $* and when does it matter?
  $@ keeps arguments separate, while $* combines them into one string
- You have a function that returns 1 on error, but your script doesn’t check the return value and continues anyway. Later, your script appears to run successfully but actually failed silently. How would you structure your script to catch errors earlier?
  the script didn't check the exit status
- You write a loop: for file in *.txt; do process "$file"; done. If a filename has spaces in it, what breaks and how would you fix it?
  the shell splits on spaces, using "$file" can fix it

## System Administration Basics
- uptime shows a load of 8.0 on a 4-core system. What does this actually tell you about system health, and why is it not as simple as “the system is overloaded”?
  there are more processes waiting for CPU or I/O than the CPU can handle
- You discover /home is 95% full. You run du -sh /home/* but the sum is way less than the total size. Where did the space go and how would you actually find it?
  deleted files may still be open by processes
- You see a process in htop using 50GB of memory but ps aux shows it only allocated 2GB. How is this possible and what’s the difference between what these tools are measuring?
  they measure memory differently, virtual vs resident
- You add an environment variable to ~/.bashrc by appending a line, but when you open a new terminal it’s not there. You double-check the file and the line is there. What’s wrong?
  the shell might not be loading .bashrc or it needs to be sourced
- A service is crashing repeatedly. You check journalctl but the last log entry is from 10 minutes ago, even though you know it crashed 30 seconds ago. Where else would you look for logs and why?
  in application logs inside /var/log

## Networking Basics
- You run nc -zv server.com 8080 and it times out, but ping server.com succeeds. The server admin says the service is definitely running. What layer of the network stack is the problem at, and how would you prove it?
  the host is reachable but the service on that port isn't listening or is blocked
- You compare ss -tuln and netstat -tuln output on the same system and get slightly different results. Why might this happen and which one should you trust?
  ss reads kernel socket info directly and is usually more accurate
- You want to SSH to a server on port 2222, but you also need to forward a local port for development. What would your full command look like and why might this be safer than opening port 22?
  ssh -L 8080:localhost:8080 -p 2222 user@server
- traceroute server.com shows 20 hops but ping server.com returns in milliseconds. Something is very wrong. Is the server definitely reachable and why would traceroute show so many hops?
  routers treat traceroute packets differently or deprioritize them
- You want to copy a 10GB file from a remote server but scp keeps timing out. What could be wrong, and what’s a more robust approach?
  rsync because it can resume interrupted transfers

## DNS and Name Resolution
- You run nslookup google.com and get “server can’t find google.com”, but nslookup 8.8.8.8 works fine. What’s the actual problem and what’s your next debugging step?
  the DNS resolver configuration is broken
- dig google.com returns a valid IP, but your application still can’t connect. You check /etc/hosts and it has an entry for google.com pointing to 127.0.0.1. How is this possible and which takes precedence?
  /etc/hosts overrides DNS results
- You can ping 8.8.8.8 successfully, but ping 8.8.8.8.in-addr.arpa fails. You also can’t resolve any hostnames. What service is broken?
  DNS resolution

## Understanding Ports and Services
- You write a service that binds to port 22 without running as root, and it works. How is this possible, and what could break this setup?
  it may have special linux capabilities allowing it to bind to privileged ports
- A service running on your machine is using an ephemeral port that changes every time it restarts. Another service tries to connect to it using the port number from last time and fails. How would you redesign this to work reliably?
  clients cannot reliably connect unless the port is fixed
- You create a service that binds to 127.0.0.1:8080 for security, but your load balancer can’t reach it. Why is this wrong and what’s the actual security risk you’re trying to mitigate?
  127.0.0.1 only accepts connections from the same machine
- You have two services both trying to listen on port 8080. The first one starts fine, but when you start the second one, it says “address already in use”. You try killing the first service and restarting both, but the second one still fails sometimes. What’s happening on a TCP level and how do you fix it?
  the port is already in use or still in the TIME_WAIT state
