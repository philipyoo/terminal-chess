# Terminal Chess

A 2-Player Chess game played in the terminal.

![](http://s24.postimg.org/a9z6jt3at/Screen_Shot_2015_11_02_at_3_55_38_PM.png "On Run Screenshot")


## Goals

- Build a working chess game using Ruby.
- This is for my own personal growth and practice. Apply OOP, inheritance, and some creativity.
- Keep it DRY, efficient, and functional.
- Keep refactoring this as I become a better programmer :)


## Setup

In the terminal:

1. `git clone https://github.com/philipyoo/terminal-chess.git`
2. `cd terminal-chess`
3. `gem install colorize`
4. `cd lib`
5. `ruby run.rb`
6. Play the game! Instructions in-game  :)


## Future Implementations

- Method `still_in_check?` uses way too much memory (Currently O(n^3)ish). Need to refactor this somehow
- When a Pawn reaches the opposite end, it can be changed into any other piece.
- Display messages like Check or Checkmate to the current player
- Add castling of King
