## pd.sh : preserve intermediate outputs in a Linux terminal pipeline command
In a typical Linux terminal piped command, the intermediate outputs (and errors, if any) are lost. This tool preserves intermediate outputs and errors for inspection and/or debugging. It decomposes each stage of the pipeline as a separate command and places it in a shell script. It then runs the script with user permission. It prints the exit status of the commands and saves standard output and error in numbered files inside a created dir with a random name.

### Usage Examples:

```bash
$ ./pd.sh 'ls -lr |  grep $(date +%b)'
Want to run now? [y/N] y
1. Exit status of ls -lr is 0
2. Exit status of grep Jun is 0
The stdouts and stderrs are in ./2qg65f dir
```

In a debugging scenario, a quick way to run this is to use `!!`, the bash shorthand to print last command run, for instance:

```bash
$ ps aux | grep -v grep | grp -i -e $USER
...some error...
$ ./pd.sh "!!"
./pd.sh "ps aux | grep -v grep | grp -i -e $USER"
Want to run now? [y/N] y
1. Exit status of ps aux is 0
2. Exit status of grep -v grep is 0
3. Exit status of grp -i -e ketan is 127
The stdouts and stderrs are in ./omzele dir
```

## Known Limitations
No way to escape the shell expansion in the quick `!!` way. One has to manually escape the `$` using \; for instance in the following pipeline the awk will run without $1 because bash expansion eats $1:

```bash
$ free -m|grep Mem:|awk '{print $4}'
$ ./pd.sh "!!"
./pd.sh "free -m|grep Mem:|awk '{print $4}'" #should be \$4
Want to run now? [y/N] y
1. Exit status of free -m is 0
2. Exit status of grep Mem: is 0
3. Exit status of awk {print } is 0
The stdouts and stderrs are in ./4cs37n dir
```
