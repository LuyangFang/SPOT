# SPOT


# SPOT: An Active Learning Framework for Deep Neural Networks

**This repository contains code for the paper "SPOT: An Active Learning Framework for Deep Neural Networks"**


### Overview

We introduce the **SPOT** algorithm, a novel active learning algorithm that integrates space-filling (SP) designs with the optimal transport (OT) technique.
SPOT utilizes optimal transport to effectively manage data from complex manifolds by mapping it to a uniformly distributed hypercube. Additionally, the space-filling design facilitates a faster asymptotic convergence rate, ensuring that the selected subset encompasses the entire dataset more effectively than other sampling methods, such as random sampling.


### Tutorial

The `SPOT_func` function provides an implementation of the SPOT algorithm to select a subset of points from a given dataset. By integrating optimal transport mapping and space-filling designs, this method ensures the selected subset preserves the structure and diversity of the original data.

**key features**
- Utilizes optimal transport to map data to a uniform hypercube.
- Employs MaxPro space-filling designs for efficient subset selection.
- Supports 2D visualization for intuitive understanding of the subset selection process.
- Handles optional true labels to display class distributions in the selected subset.


#### Arguments
- `data`: The input dataset (matrix or dataframe). Each row represents a data point, and each column is a feature.
- `d`: Dimensionality of the dataset (number of columns in `data`).
- shot: The desired size of the subset to be selected.
- true_label: (Optional) A vector of true labels for the data points. Used for visualization purposes (default: NA).
- seed: Random seed for reproducibility (default: 2022).
- plot: Boolean flag to enable visualization for 2D datasets (default: FALSE).


#### Requirement

The function is built on R version 4.1.1. The [requirement.txt](https://github.com/Luyang8991/MultiCOP/blob/main/requirements.txt) file lists all the packages the notebook depends on. 


#### How to use

A demonstration of the SPOT algorithm is available in the [demo.Rmd] file. This file provides step-by-step guidance and usage examples, including detailed visualizations for 2D datasets.


The script [utils.R](https://github.com/Luyang8991/MultiCOP/blob/main/code/utils.R) contains all the utility functions that are essential for the operations carried out in the project. The script [main.R](https://github.com/Luyang8991/MultiCOP/blob/main/code/main.R) hosts the main function of the project. An example for implementing MultiCOP is available in [example.R](https://github.com/Luyang8991/MultiCOP/blob/main/code/example.R). This example shows how to implement the second scenario in the simulation section.





### License

Copyright © 2024 [Luyang](https://github.com/Luyang8991). <br />
This project is [MIT](https://github.com/Luyang8991/SPOT/blob/main/LICENSE) licensed.

