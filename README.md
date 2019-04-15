# Martian Robots Coding Challenge

*This is the result of the Developer Programming Problem done for Red Badger*

## Introduction

This tool has been written using Swift and the Swift Package Manager.  
The choice of language has been made accordingly to the position applied for.

## Installation

####*This project has been created and tested only under Swift 4.2.1*

#### Executable

There is already an executable built for Mac os 10.10 and above (x86_64).
If compatible it should work out of the box using :

```
./martianRobotsApp
```

***You may need to `chmod u+x ./martianRobotsApp`***

#### Build & Run

To build for debug  

```
make
```

The binary path will be displayed in the last line of the build log.

**Check the Makefile for more options*

## Usage

The CLI expects inputs from the standard input (stdin). An empty line or EOF will end the input

Simply run the binary then insert instructions. 
Example:

```sh
$ ./martianRobotsApp
Enter your instructions:
5 3
1 1 E
RFRFRFRF
3 2 N
FRRFLLFFRRFLL
0 3 W
LLFFFLFLFL

1 1 E
3 3 N LOST
2 3 S
```

You can also do the following
```sh
./martianRobotsApp < sampleData
```

#### Tests

The test do not require any dependency.

Simply do:
 
```sh
make test
```

or (without xcpretty):

```sh
swift test
```

Enjoy!

 