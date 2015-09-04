#PROBLEM 1
A = c(1,4,7,2,5,8,3,6,9)
dim(A) = c(3,3)
B = c(2,1,0,1,1,1,1,0,2)
dim(B) = c(3,3)
#Q1a1
A*B
#Q1a1 Solution
#      [,1] [,2] [,3]
#[1,]    2    2    3
#[2,]    4    5    0
#[3,]    0    8   18

#Q1a2
solve(B)
#Q1a2 Solution
#      [,1]       [,2]       [,3]
#[1,]  0.6666667 -0.3333333 -0.3333333
#[2,] -0.6666667  1.3333333  0.3333333
#[3,]  0.3333333 -0.6666667  0.3333333

#Q1a3
det(A)
#Q1a3 Solution: 6.661338e-16

#Q1b1 - Get the value in the second row and the second column
A[2,2]
#Q1b2 - Get the third row
A[3,]
#Q1b3 - Get the first column
A[,1]
#Q1b4 - Exclude the second column
A[,-2]

#Q1c1
B[-3,-3]

#Q1c2
sum(A[2,] %*% B[,2])
#Q1c2 Solution = 15

#PROBLEM 2

#Q2-1
seq(from=1, to=25, by=2)
#Q2-2
rep(x=c(1:9), times=c(1:9))
#Q2-3
seq(from=0, to=1, by=.05)
#Q2-4
seq(from=0, to=1, length.out=15)

#PROBLEM 3

#Q3a
A=c(.6,.2,.4,.8)
dim(A) = c(2,2)
print(A)
A = matrix(data=c(.6,.2,.4,.8), nrow=2, ncol=2)
print(A)
A = rbind(c(.6,.4), c(.2,.8))
print(A)

#Q3b
A = rbind(c(.6,.4), c(.2,.8))
V = eigen(A)$vectors
Vinv = solve(V)

