# pd.sh
Linux terminal piped commands preserve outputs and debug. This little tool allows you to preserve the standard output and errors in intermediate files in a sandbox directory for inspection and/or debugging.

When you run the pd.sh script with your piped command as an argument, it will detach each stage of the pipeline as a separate command in a shell script and ask you if you'd like to run the script. If you say yes, it will run the script. It will print the exit status of the individual commands and preserve standard output and errors in numbered files inside a randomly generated directory.

If you say no (default), it will simply create the shell script for you that you may run manually.

Usage Examples:
./pd.sh 'ls -lr |  grep $(date +%b)'
Want to run now? [y/N] y
1. Exit status of ls -lr is 0
2. Exit status of grep Jun is 0
The stdouts and stderrs are in ./2qg65f dir

