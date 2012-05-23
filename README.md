A version of Tic-Tac-Toe implemented in Factor.

After installing the development release of Factor from the [website](http://factorcode.org/), symlink the `ttt` directory **from the project root** in this repository as follows:

`ln -s $(pwd)ttt ${YOUR-PATH-TO-FACTOR}/work/ttt`

If you're not in the project root, make sure you're symlinking the absolute path to the `ttt` directory. After doing this, you can run TTT by entering:

`${YOUR-PATH-TO-FACTOR}/factor -run=ttt`

To run the tests, enter:

`${YOUR-PATH-TO-FACTOR}/factor -run=ttt -test`

You will need the development version of Factor to run all of the project tests correctly; the stable version is missing some necessary functions. Note that there will be a lot of output from the unit tests, so you may want to store it in another file:

`${YOUR-PATH-TO-FACTOR}/factor -run=ttt > /tmp/factortests`

`vi /tmp/factortests`
