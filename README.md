# SPOT


# SPOT: An Active Learning Framework for Deep Neural Networks

**This repository contains code for the paper "SPOT: An Active Learning Framework for Deep Neural Networks"**


### Introduction

We introduce the **SPOT** algorithm, a novel active learning algorithm that integrates space-filling (SP) designs with the optimal transport (OT) technique.
SPOT utilizes optimal transport to effectively manage data from complex manifolds by mapping it to a uniformly distributed hypercube. Additionally, the space-filling design facilitates a faster asymptotic convergence rate, ensuring that the selected subset encompasses the entire dataset more effectively than other sampling methods, such as random sampling.


### Tutorial

SPOT requires two data tables in matrix form as input, denoted as **X** and **Y**, each with dimensions of n_sample by n_feature. 

The script [utils.R](https://github.com/Luyang8991/MultiCOP/blob/main/code/utils.R) contains all the utility functions that are essential for the operations carried out in the project. The script [main.R](https://github.com/Luyang8991/MultiCOP/blob/main/code/main.R) hosts the main function of the project. An example for implementing MultiCOP is available in [example.R](https://github.com/Luyang8991/MultiCOP/blob/main/code/example.R). This example shows how to implement the second scenario in the simulation section.

#### Requirement

The function is built on R version 4.1.1. The [requirement.txt](https://github.com/Luyang8991/MultiCOP/blob/main/requirements.txt) file lists all the packages the notebook depends on. 


### License

Copyright © 2024 [Luyang](https://github.com/Luyang8991). <br />
This project is [MIT](https://github.com/Luyang8991/SPOT/blob/main/LICENSE) licensed.

