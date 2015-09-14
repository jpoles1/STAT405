import pandas as pd
from matplotlib import pyplot as plt
#SIR Model of Disease Transmission
#Eventually, should add capacity to model two competing diseases (when an inidividual has one, can they have another?)
Sinit = 1000
Iinit = 10
Rinit = 0
#history = data.frame(S=numeric(0),I=numeric(0),R=numeric(0),D=numeric(0));
class Disease():
    def __init__(self, Sinit, Iinit, Rinit, Beta, Gamma, Theta):
        self.S=Sinit
        self.I=Iinit
        self.R=Rinit
        self.D=0
        self.Beta = Beta
        self.Gamma = Gamma
        self.Theta = Theta
        self.history = pd.DataFrame(columns=('S', 'I', 'R', 'D'))
        self.addToHistory()
    def stepDisease(self):
        newS = self.S - (self.Beta*self.I*self.S) 
        newI = self.I + (self.Beta*self.I*self.S) - (self.Gamma*self.I) - (self.Theta*self.I)
        newR = self.R + (self.Beta*self.I*self.S) - (self.Gamma*self.I)
        newD = self.D+(self.Theta*self.I);
        self.S = newS; self.I = newI; self.R = newR; self.D = newD;
        self.addToHistory()
    def addToHistory(self):
        self.history = self.history.append({"S": self.S, "I": self.I, "R": self.R, "D":self.D}, ignore_index=True)
    def takeSteps(self,numsteps):
        for step in range(numsteps):
            self.stepDisease();
jvirus = Disease(Sinit, Iinit, Rinit, .5, 1.5, 0)
jvirus.stepDisease()
jvirus.history
jvirus.takeSteps(5)
history = jvirus.history