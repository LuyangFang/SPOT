library(rgl)
library(MaxPro)
library(transport)
library(DiceDesign)
library(mvtnorm)
library(MASS)


simu.X.generate <- function(n,d,p.type,scale = TRUE,seed=1){
  X = matrix(0,nrow= n, ncol = d)
  set.seed(seed)
  
  r = 2*pi*runif(n)
  X.12 = mvrnorm(n,c(0,0),0.4^2*diag(2))+cbind(r*sin(2*r),r*cos(2*r))
  X.rest = matrix(rnorm(n*(d-2)),nrow = n)
  X = cbind(X.12,X.rest)
  
  colnames(X) = paste0("X",1:d)
  if(scale == TRUE){
    X.scale = list(mu = apply(X, 2, mean),sd = apply(X,2,sd))
    X = scale(X)
    var.out = list(X=X,X.scale = X.scale)
  }else{
    var.out = X
  }
  return(var.out)
}



SPOT_func = function(data, d, shot, true_label=NA, seed=2022, plot=FALSE){
  # """
  # SPOT Algorithm Implementation:
  # This function uses the SPOT (Space-filling Optimal Transport) algorithm to select a subset of the input data.
  #
  # Args:
  #   data: The input dataset, assumed to be a matrix or dataframe.
  #   d: The dimensionality of the dataset.
  #   shot: The size of the subset to be selected.
  #   true_label: Optional, true labels for the data points (default = NA).
  #   seed: Random seed for reproducibility (default = 2022).
  #   plot: Boolean flag to enable visualization for 2D datasets (default = FALSE).
  #
  # Returns:
  #   ind_trans: Indices of the selected data points in the original dataset.
  # """
  
  ## (1) Generate uniform reference data in a d-dimensional hypercube
  ref_unif = c()
  set.seed(seed)
  for (i in 1:d){
    tmp = runif(dim(data)[1])
    ref_unif = cbind(ref_unif, tmp)
  }
  
  ## (2) Build the OT map between the original data and the uniform reference data
  star = Sys.time()
  xx = pp(data)
  yy = pp(ref_unif)
  trans = transport(xx,yy)
  print("OT time:")
  print(Sys.time() - star)
  
  ## (3) Determine space-filling design points using MaxPro
  star = Sys.time()
  lhs = MaxProLHD(n = shot, p = d)
  lhs_design = lhs$Design
  # print(paste("criterion measure:", lhs$measure))
  print("Space filling time:")
  print(Sys.time() - star)
  
  # (4) Select the nearest neighbors for `lhs_design` from `ref_unif`
  star = Sys.time()
  dis_min_ind = c()
  for (ss in 1:shot){
    ref = lhs_design[ss,]
    dis = apply(ref_unif, 1, function(x) sum((x-ref)^2))
    dis_min_ind[ss] = which.min(dis)
  }
  

  ind_trans = which(trans$to %in% dis_min_ind) # Map selected points back to the original dataset
  print("Nearest neighbour time:")
  print(Sys.time() - star)
  print(table(paste("type:", true_label[ind_trans])))
  
  
  ## Visualization for 2D datasets
  if (plot & dim(data)[2]==2){
    if (sum(is.na(true_label))>0){true_label = rep(1, dim(data)[1])}
    col = c("azure4", "khaki2", "chartreuse4")[true_label]
    # plot of original data:
    par(mfrow=c(2,2))
    plot(data, pch=".", 
         col=col,
         cex=2, cex.axis=1.2, mgp=c(3,0.5,0),
         cex.lab=1.5,
         ann = F)
    title(xlab= expression(X[1]), ylab = expression(X[2]), line = 2, cex.lab=1.5, main='original data')
    # Plot data mapped to the uniform hypercube via OT, with color representing class information
    col_unif = rep(0, length(true_label))
    col_unif[trans$to] = col[trans$from]
    plot(ref_unif[,1], ref_unif[,2],
         pch=".", col=col_unif, cex=2, 
         cex.axis=1.2, mgp=c(3,0.5,0),
         cex.lab=1.5,
         ann = F)
    title(xlab= expression(U[1]), ylab = expression(U[2]), line = 2, cex.lab=1.5, main='Optimal Transport')
    # Plot space-filling points in the hypercube (red points)
    plot(ref_unif[,1], ref_unif[,2],
         pch=".", col=col_unif, cex=2, 
         cex.axis=1.2, mgp=c(3,0.5,0),
         cex.lab=1.5,
         ann = F)
    title(xlab= expression(U[1]), ylab = expression(U[2]), line = 2, cex.lab=1.5, main='space filling points')
    points(ref_unif[dis_min_ind,1], ref_unif[dis_min_ind,2], col="red", pch=19, cex=0.6)
    # Plot selected subset in the original dataset (red points)
    select = data[ trans[ind_trans,1] , ]
    plot(data, pch=".", col=col, cex=2,
         cex.axis=1.2, mgp=c(3,0.5,0),
         cex.lab=1.5,
         ann = F)
    title(xlab= expression(X[1]), ylab = expression(X[2]), line = 2, cex.lab=1.5, main='proposed method')
    points(select, col="red", pch=19, cex=0.6)
  }
  
  return(ind_trans) # Return indices of selected points
}



