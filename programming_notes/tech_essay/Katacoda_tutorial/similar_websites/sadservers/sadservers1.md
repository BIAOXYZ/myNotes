
# Easy

Scenario: "Saint John": what is writing to this log file? https://sadservers.com/newserver/saint-john
1. You can use ps to list all processes and see if you see something related, for example with: `ps auxf`. Ignore system processes [in brackets]. <br> A better way is to use the command to list open files: `lsof`.
2. Find the name (first column) and Process ID (PID, second column) of the process related to /var/log/bad.log by running lsof and filtering the rows to the one(s) containing bad.log. <br> You can also use the "fuser" command to quickly find the offending process: `fuser /var/log/bad.log`.
3. Run: `lsof | grep bad.log` and get the PID (second column). <br> With the PID of the process, it's not necessary but we can find its current working directory (program location) by doing `pwdx PID` or for more detail: `lsof -p PID` and check the cwd row. This will allow us to check its ownership and perhaps inspect its offending code if it's a script (not a binary). <br> (Open window once more to see the complete solution).
4. Solution: Using the PID found, terminate (kill) the process with `kill -9 PID`.
