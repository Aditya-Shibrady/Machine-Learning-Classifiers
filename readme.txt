Below is the list of the classifiers that has been implemented:
1. Decision Tree
2. Support Vector Machines
3. Naïve Bayesian
4. kNN
5. Logistic Regression
6. Neural Network
7. Bagging
8. Random Forest
9. Boosting

Steps to run: (Some terminologies maybe specific to Mac Terminal)

1) login to terminal by ssh.
2) Create a folder called “Rlib” in your root directory.
3) Create a file called .Rprofile in your root directory and add the following
  .libPaths(“<Path to the directory created in step 2>”)
4) Type R in terminal and install packages eg:
  install.packages('randomForest', repos='http://cran.us.r-project.org')
5) Copy runscript.sh and ML4.R to ur home folder.
6) Type the command : ./runscript.sh

Note: you may have to set the right permissions by folowing command: chmod 777 <filename>


Following datasets are being used:

1. Credit default dataset that is available at:
https://gist.github.com/Bart6114/8675941
Class variable is attribute: default10yr (Position 6 in the columns)

2. Graduate school admission dataset that can be obtained from: http://www.ats.ucla.edu/stat/data/binary.csv
Class variable is attribute: admit (Position 1 in the columns) 

3. Wisconsin Prognostic Breast Cancer (WPBC) dataset:
Description is here: https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer- wisconsin/wpbc.names
Data is here: http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer- wisconsin/wpbc.data
Note: Read the field names in the description file. The class attribute is: Outcome (Position 2 in the columns). Also note that the data has no header field.

4. Wisconsin Diagnostic Breast Cancer (WDBC) dataset:
Description is here: https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer- wisconsin/wdbc.names
Data is here: http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer- wisconsin/wdbc.data
Note: Read the field names in the description file. The class attribute is: Diagnosis (Position 2 in the columns). Also note that the data has no header field.
 
5. Ionosphere dataset:
Description is here: https://archive.ics.uci.edu/ml/machine-learning- databases/ionosphere/ionosphere.names
Data is here: http://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data
Note: Read the field names in the description file. The class attribute has Position 35 in the columns. Also note that the data has no header field.
