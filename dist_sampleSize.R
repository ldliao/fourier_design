dist_sampleSize <- function(alpha = .05, pow = .8, theta, theta0 = 0 , var){
  z.alpha <- qnorm(1-alpha/2) #two sided
  z.beta <- qnorm(pow) 
  
  #sample size
  n <- ((z.alpha + z.beta)/(theta-theta0))^2 *var
  
  #standard error
  se <- sqrt(var/n)
  
  #critical value
  if (theta - theta0 < 0)
    cv <- theta0 + qnorm(1-alpha/2)*se
  else if (theta - theta0 > 0)
    cv <- theta0 + qnorm(1-alpha/2)*se #***question
  
  #95% CI at the critical value
  upper <- cv + qnorm(.975)*se
  lower <- cv + qnorm(.025)*se
  
  cat(" sample size:", n, "critical value:", cv, 
      "95CI:", lower, "to", upper)
  
  #power curve
  sigma <- sqrt(var)
  
  # plot() x theta 
  
  ## Plot The Power Function, gamma(theta), theta <= theta0
  curve(1-pnorm(sqrt(n)*(x - theta0)/sigma - z.alpha), 
        from=theta0,                   # Left endpoint of the domain
        to=theta0+3.7*sigma/sqrt(n),   # Right endopint of the domain
        col="blue",                    # Try different colors
        main="Power Function",         # The Main Title
        xlab=expression(theta),        # Label the horizontal axis
        ylab='power', # Label the vertical axis
        lwd=2)                      
  
  abline(h=pow,       # Plot a horizontal line
         col="red",   # Choose the color
         lwd=2)       # Choose the line width.
  
  abline(v= (z.alpha+z.beta)*se - cv,  # Plot a vertical line
         col="green",                              # Choose the color
         lwd=2)                                    # Choose the line width
  
}

dist_sampleSize(.05,.91,log(.85),0,4)

