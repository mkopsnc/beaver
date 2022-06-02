<p align="center">
  <img src="https://github.com/mkopsnc/beaver/blob/master/img/beaver.png">
</p>

# Beaver

Sample code illustrating the way of running `Fortran` code with `IMAS` bindings. What it does is a simple operation on `Summary IDS`. This code reads `Summary IDS` from the pulse file: `shot=1111 run=997`. It changes the value of `summary%ids_properties%comment` field

```
summary%ids_properties%comment = 'Modified by the code'
```

and stores the output inside pulse file: `shot=1111 run=999`.

# Content of the repository

.
|-- bin
|   `-- intentionally_left_empty
|-- data
|   |-- input
|   |   `-- input.tar.gz           - input file with sample Summary IDS
|   `-- reference
|       `-- reference.tar.gz       - reference file with expected output
|-- img
|   `-- beaver.png
|-- Makefile                       - Makefile that builds the code
|-- README.md                      - this README.md file
`-- src
    `-- main.f90                   - source code

# Requirements

Please note that this code requires `IMAS` environment for building and running.

# Building

Make sure to clone the repository, load `IMAS` environment and build the code

```
> module load imasenv
> git clone https://github.com/mkopsnc/beaver.git
> cd beaver
> make
> ./bin/main
```

# Input data

Before running the code, make sure to copy data into your `imasdb` folder.

```
> module load imasenv
> imasdb test
> cd beaver/data/input
> tar -xf input.tar.gz -C $HOME/public/imasdb/test/3/0
```
