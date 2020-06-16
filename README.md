# pd.sh
In a typical Linux terminal piped command, the intermediate outputs (and errors, if any) are lost. This little tool preserves intermediate outputs/errors for inspection or debugging. It breaks each stage of the pipeline as a separate command in a shell script and asks you if you'd like to run the script. If you say yes, it will run the script inside a randomly generated sandbox dir. It will print the exit status of the individual commands and preserve standard output and errors in numbered files inside a randomly generated directory. If you say no (default), it will simply create the shell script for you that you may run manually.

### Usage Example:

```bash
$ ./pd.sh 'ls -lr |  grep $(date +%b)'
Want to run now? [y/N] y
1. Exit status of ls -lr is 0
2. Exit status of grep Jun is 0
The stdouts and stderrs are in ./2qg65f dir
```

A quick way to run this is to use `!!`, the bash shorthand to print last command run, for instance:

```bash
$ ps aux | grep -v grep | grep -i -e $USER
...output...
$ ./pd.sh "!!"
./pd.sh "ps aux | grep -v grep | grep -i -e $USER"
Want to run now? [y/N] y
1. Exit status of ps aux is 0
2. Exit status of grep -v grep is 0
3. Exit status of grep -i -e ketan is 0
The stdouts and stderrs are in ./omzele dir
```

## Known Limitation
No way to escape the shell expansion in the quick `!!` way. One has to manually escape the `$` using \; for instance in the following pipeline the awk will run without $1 because bash expansion eats $1:

```bash
$ free -m|grep Mem:|awk '{print $4}'
$ ./pd.sh "!!"
./pd.sh "free -m|grep Mem:|awk '{print $4}'"
Want to run now? [y/N] y
1. Exit status of free -m is 0
2. Exit status of grep Mem: is 0
3. Exit status of awk {print } is 0
The stdouts and stderrs are in ./4cs37n dir
```
