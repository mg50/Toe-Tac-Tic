A version of Tic-Tac-Toe implemented in Factor.

To begin, install the **development release** of Factor from the [website](http://factorcode.org/). The stable release listed on the Factor homepage is missing a few necessary functions.

Next, symlink the `ttt` directory **from the project root** in this repository as follows:

`ln -s $(pwd)/ttt ${YOUR-PATH-TO-FACTOR}/work/ttt`

If you're not in the project root, make sure you're symlinking the absolute path to the `ttt` directory. After doing this, you can run TTT by entering:

`${YOUR-PATH-TO-FACTOR}/factor -run=ttt`

To run the tests, enter:

`${YOUR-PATH-TO-FACTOR}/factor -run=ttt -test`

To learn more about the Factor language, get started with the [Factor Cookbook](http://docs.factorcode.org/content/article-cookbook.html) for the basic nuances. Aterwards, peruse the [Factor language docs](http://docs.factorcode.org/content/article-handbook-language-reference.html) to refer to the core library.
