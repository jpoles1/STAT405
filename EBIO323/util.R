#Create transition matrix
createTransitionMatrix = function(ageclass, survival, fecundity){
  survivaldiag = diag(survival[-length(survival)])
  matrixshape = dim(survivaldiag)[1]
  transmatrix = cbind(survivaldiag, matrix(0, nrow = matrixshape, ncol = 1))
  transmatrix = rbind(fecundity, transmatrix)
  transmatrix[matrixshape+1, matrixshape+1] = survival[length(survival)]
  rownames(transmatrix) = paste("To", ageclass, sep=" ")
  colnames(transmatrix) = paste("From", ageclass, sep=" ")
  return(transmatrix)
}
#Run N timesteps
runSim = function(initialMatrix, initialCounts, ageclass, numiter=100){
  x = 2;
  gen = t(data.frame(initialCounts))
  colnames(gen) = ageclass
  prevgen = initialCounts;
  while(x<numiter){
    newgen = prevgen%*%initialMatrix;
    prevgen = newgen
    newgen = data.frame(newgen)
    colnames(newgen) = ageclass
    gen = rbind(gen, newgen)
    x=x+1;
  }
  gen[,"time"] = 1:dim(gen)[1]
  return(gen);
}