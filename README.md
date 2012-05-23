A version of Tic-Tac-Toe implemented in Factor.

After installing the development release of Factor from the [website](http://factorcode.org/), symlink the `ttt` directory in this repository as follows:

`ln -s $(pwd) ${YOUR-PATH-TO-FACTOR}/work/ttt`

After doing this, you can run TTT by entering:

`${YOUR-PATH-TO-FACTOR}/factor -run=ttt`

To run the tests, enter:

`${YOUR-PATH-TO-FACTOR}/factor -run=ttt -test`

Note that there will be a lot of output from the unit tests, so you may want to store it in another file:

`${YOUR-PATH-TO-FACTOR}/factor -run=ttt > /tmp/factortests`

`vi /tmp/factortests`
