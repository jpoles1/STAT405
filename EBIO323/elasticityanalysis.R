#Libraries
require(ggplot2)
require(reshape2)
require(rgl)
source("EBIO323/util.R")
#Creating Transition Matrices
ageclass=c("Age 0", "Age 1", "Age 2", "Age 3", "Age 4+")
survival = c(.5, .6, .91, .99, 0)
#from assignment 
fecundity = c(0, .02, .68, .7, .4)
#Testing
#fecundity = c(0, .02, .68, .7, .4)
initialMatrix = createTransitionMatrix(ageclass, survival, fecundity)
#Get initial species counts
input = "10 20 2 10 15"
vals = as.numeric(strsplit(input, " ")[[1]])
initialCounts = vals
#Plot Future Generations (ggplot)
meltgen = melt(runSim(initialMatrix, initialCounts, ageclass, 100), id.vars="time")
ggplot(data=meltgen, aes(x=time, y=value, color=variable))+geom_point()+geom_line()+xlab("Time")+ylab("# of Individuals")
#3D Elasticity Analysis X=Time; Y=Population Size; Z=Percent Change in Matrix Vals
nudgevals = 1+(seq(-10, 10, length.out=100)/100)
rgl.open()
for(nudge in nudgevals){
  nudgematrix = matrix(nudge, ncol=5, nrow=5)
  nudgedMatrix = initialMatrix * nudgematrix
  gen = runSim(nudgedMatrix, initialCounts, ageclass, 10);
  rgl.points(x=gen$time, y=rowSums(gen), z=nudge*100)
}
rgl.bbox(color = "#333377")