##Function returning minimum number of operations to get from zero to any integer using only two operations:
#x+1 and x*2

#requires integer input
zero_2_int <- function(x) {
  count = 0 #initialise counter for operations.
  m = 0
  #if x is zero, print the count immediately
  if (x == 0) {
    return(count)
  }
  else {
    count = 1
    m = 1 #first operation for a non-zero integer is always 0+1
    while (m != x) {
      if (m*2 <= x) {
        m = m*2
        count = count+1
      }
      else if (m*2 > x & m+1 <= x) {
        m = m+1
        count = count+1
      }
    }
    #print final number of minimum operations
    return(count)
  }
}

#the function works as expected
zero_2_int(2) #2
zero_2_int(3) #3

#but...at larger numbers, the number of operations requires becomes unrealistic
zero_2_int(1370) #357

#if you start from the non-zero integer and work backwards, you can clearly see that less than 357 operations are needed to get to zero
#going backward is faster than going forward
int_2_zero <- function(x) {
  count = 0 
  m = x
  if (x == 0) {
    #print(paste("Minimum number of operations to get from zero to",x,"is",count,collapse=" "))
    return(count)
  }
  else {
    #N.B. no need to change count to 1 because we are now starting from the final integer.
    m = x #now start from x instead of zero
    while (m != 0) {
      if (m%%2 == 1) {
        m = m-1
        count = count + 1
      }
      else {
        m = m/2
        count = count+1
      }
    }
    return(count)
  }
}
int_2_zero(1370) #16 operations are required now instead of 357!

#at low integer values, both functions require the same number of operations to reach the final integer or zero. At what integer does int_2_zero start overtaking zero_2_int?
#generate two lists, each with function values of up to 10,000
input_list <- c(1:10000)
list1 <- sapply(input_list,FUN=zero_2_int)
list2 <- sapply(input_list,FUN=int_2_zero) #this runs a lot faster than the first, showing how much more efficient working backwards is
plot(x=input_list,y=list1,type="l",xlab="Integer values",ylab="Number of minimum operations required",main="zero_2_int",col="blue") #plotting the forward algorithm
plot(x=input_list,y=list2,type="l",xlab="Integer values",ylab="Number of minimum operations required",main="int_2_zero",col="red")  #plotting the backwards algorithm

#plotting the two algorithms on the same graph
plot(x=input_list,y=list1,type="l",xlab="Integer values",ylab="Number of minimum operations required",col="blue") 
lines(x=input_list,y=list2,type="l",col="red")
legend(0,4000, legend=c("zero_2_int", "int_2_zero"),
       col=c("blue", "red"), lty=1:2, cex=0.8)
#shifting perspective: bit shifts
##caveat: bit shift adds by 2^n, not by 1
#why does this matter?
##priors - working backwards where you know the endpoint versus working forward blindly