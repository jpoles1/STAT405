#Libraries
require(ggplot2)
require(reshape2)
#Get initial transistion matrix
input = "0 0.02 0.68 0.7 0.99 0.5 0 0 0 0 0 0.6 0 0 0 0 0 0.91 0 0 0 0 0 0.99 0"
vals = as.numeric(strsplit(input, " ")[[1]])
dim(vals) = c(5, 5)
initialMatrix = vals#t(vals)
#Get initial species counts
input = "10 20 2 10 15"
vals = as.numeric(strsplit(input, " ")[[1]])
initialCounts = vals
#Find Future Generations
x = 2;
numiter = 100;
gen = data.frame(t(initialCounts))
prevgen = initialCounts
while(x<numiter){
  newgen = prevgen%*%initialMatrix;
  gen = rbind(gen, data.frame(newgen))
  x=x+1;
  prevgen = newgen
}
gen[,"time"] = 1:dim(gen)[1]
#Plot Future Generations (ggplot)
meltgen = melt(gen, id.vars="time")
ggplot(data=meltgen, aes(x=time, y=value, color=variable))+geom_point()+geom_line()

