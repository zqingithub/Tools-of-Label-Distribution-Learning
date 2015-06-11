# Tools-of-Label-Distribution-Learning
This respository is granted free of charge for research and education purposes only.
Scientific results produced using this repository provided shall cite the corresponding papers. 
If you use the algorithms -- AA-BP,AA-KNN,BFGS-LLD,IIS-LLD,PT-Bayes,PT-SVM 
Please cite the paper "Geng X, Ji R. Label distribution learning".
If you use the algorithms -- CPNN  
Please cite the paper "Yin C, Geng X. Facial age estimation by conditional probability neural network".
If you use the algorithms -- MSVR  
Please cite the paper "Tuia D, Verrelst J, Alonso L, et al. Multioutput support vector regression for remote 
sensing biophysical parameter estimation".

If you plan to use it for non-scientific purposes, please contact copyright owner.
If you plan to use the algorithms -- AA-BP,AA-KNN,BFGS-LLD,IIS-LLD,PT-Bayes,PT-SVM，CPNN
Please contact to "xgeng@seu.edu.cn"
If you plan to use the algorithms -- MSVR  
Please contact to "gcamps@uv.es"

When you agree to the above items，I will introduce this repository and how to use it.
To ensure this repository running normally, please start up Matlab using administrator rights.
This repository contains tools for Label Distribution Learning.
You can use these tools to learn the Label Distribution model ,mark prediction and conduct comparative experiment.
This repository contains eight label distribution learning algorithms,
they are ：
AA-BP,AA-KNN,BFGS-LLD,IIS-LLD,PT-Bayes,PT-SVM (Please refer to the paper "Geng X, Ji R. Label distribution learning").
CPNN  (Please refer to the paper "Yin C, Geng X. Facial age estimation by conditional probability neural network").
MSVR  (Please refer to the paper "Tuia D, Verrelst J, Alonso L, et al. Multioutput support vector regression for remote 
sensing biophysical parameter estimation").

In the repository you can see the following folders, their role is:

Algorithm: This folder contains the trainer module of the corresponding algorithm.In each algorithm's folder ,there is a file named Train.m.
           You just execute the Train.m file to train model by using corresponding algorithm.

DataSet: This folder contains the training set and test set,the trainer,predicting and testing module will use these two datasets.So you must
         input your dataset according to the following rules:
         The training set is saved as the file named TrainSet.mat.TrainSet.mat contains two matrixes named X and Y.X contains the features of instances
         and Y contains the label distribution of instances.In X and Y,each row represents a instance.Correspondingly,the test set is saved as the file 
         named TestSet.mat and has the same data struct.In TestSet.mat,you can just provide X only,and generate Y randomly.We have already provided a 
         demo dataset, you can overwrite the demo dataset by your own dataset.

Experiment: This folder contains the experiment module of this repository.There are few subfolders in this folder as follow.
            DataSet: This folder contains the total dataset which will be used to conduct the experiment. The total dataset is saved in a file named 
                     DataSet.mat. When conducting experiment, the module will automatically divide the total dataset into training set and test set.So 
                     you just provide total dataset without dividing them.The data struct of the DataSet.mat file is same as the TrainSet.mat introduced 
                     above.
            Record: This folder is used to record each experiment's outcome of cross validation experiment.
            Results:This folder is used to save the cross validation experiment outcome of each algorithm.
            Tools:This folder contains the tools used to conduct cross validation experiment.These tools are as follow:
                  create_summary.m:It is used to create a summary table of total experiment outcome.
                  cross_validation.m:It is used to conduct the selected algorithm's cross validation experiment.
                  cross_validation_algorithm.m:It is used to conduct all algorithms' cross validation experiments.
                  significance testing:This folder contains the tools used to conduct significance testing.

Model: This folder contains the model parameters of corresponding algorithm after finishing training.The model parameters are saved in the file named 
       model.mat.

Predict And Test:This folder contains the predicting and testing module.There are few subfolders in it, as follow:
                 Algorithm:This folder contains the tools used to predict and test.In the folder of corresponding algorithm,there are three tools you
                           will use. As follow:
                           predict.m:It is used to predict the label distribution of instances in test set.The test set is saved in TestSet.mat described 
                                     above.
                           test_performance.m::It is used to test the performance of each algorithm by given distances.
                           view_prediction.m:It is used to view the difference between real label distribution and the prediction. 
                 Auxiliary:This folder contains the auxiliary tools which will be used by predicting and testing module.
                 Distance:This folder contains six ditances which are used to test the performances of algorithms.You can refer to "Comprehensive survey on 
                          distance/similarity measures between probability density functions" for detail.
       
Prediction And Performance:This folder contains the prediction of instances in test set and performance of corresponding algorithm.This folder is used to 
                           store the outcome of predicting and testing module.
                           
                           