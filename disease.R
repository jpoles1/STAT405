#SIR Model of Disease Transmission
Sinit = 1000
Iinit = 10
Rinit = 0
S=Sinit
I=Iinit
R=Rinit
D=0
#history = data.frame(S=numeric(0),I=numeric(0),R=numeric(0),D=numeric(0));
history = data.frame()
stepDisease = function(Beta, Gamma, Theta){
  newS = S - (Beta*I*S)
  newI = I + (Beta*I*S) - (Gamma*I) - (Theta*I)
  newR = R + (Beta*I*S) - (Gamma*I)
  S = newS; I = newI; R = newR; D = (Theta*I);
  data.frame(S, I, R, D)
}
history = rbind(history, stepDisease(1.5, 1.5, 0))
