
#SIR Model of Disease Transmission
Sinit = 1000
Iinit = 10
Rinit = 0
S=Sinit
I=Iinit
R=Rinit
D=0
history = data.frame(S=S,I=I,R=R,D=D);
#history = data.frame()
stepDisease = function(Beta, Gamma, Theta){
  newS = pmax(S - (Beta*I*S), 0)
  newI = pmax(I + (Beta*I*S) - (Gamma*I) - (Theta*I), 0)
  newR = pmax(R + (Beta*I*S) - (Gamma*I), 0)
  newD = pmax(D + (Theta*I), 0)
  S <<- newS; I <<- newI; R <<- newR; D <<- newD;
  return(data.frame(S, I, R, D))
}
nreps = 300
for(i in 1:nreps){
  history = rbind(history, stepDisease(.001, .05, 0))
}
require(reshape2)
require(ggplot2)
plotdat = melt(history)
ggplot(data=plotdat, aes(1:dim(plotdat)[1], value))+geom_point(aes(color=variable))
