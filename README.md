## Installation

Install dependencies by running
```
bundle
```

## Running app

Run app by running `app.rb` script
```
ruby app.rb
```

## Input

The first line of input has to contain the upper-right coordinates of the plateau, separated with single space, the
lower- left coordinates are assumed to be 0,0. The rest of the input has to contain
information pertaining to the rovers that have been deployed.
Each rover should have two lines of input. The first line should give the rover’s position (also separated by space), and
the second line - a series of instructions telling the rover how to explore the
plateau (also separated by space).

Example:

```
5 5
1 2 N
L M L M L M L M M
3 3 E
M M R M M R M R R M
```

Click Ctrl+D when you finish filling up input data

## Output

The ouput contains one line for each rover with its final co-ordinates and heading.

```
1 3 N
5 1 E
```

## Running tests

Run the full test suite with

```
$ rspec
```
