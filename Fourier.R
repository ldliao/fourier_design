
#***** calculate the number of events using the standard formula:

(1.96 + qnorm(0.9))^2/log(0.85)^2*4
[1] 1591.3

#** Using RCT design to get the same thing:


#**************** suppose that they actually want 1630 events in a fixed-samples study:
dsgn <- seqDesign(prob.model="hazard",test.type="less",alt.hypo=0.85,power=0.9)

fixed <- seqDesign(prob.model="hazard",test.type="less",sample.size=1630,alt.hyp=0.85,power="calculate")

#**************** designs with interim analyses:
dsgnIA.4 <- update(fixed,nbr.analyses=4)
dsgnIA.3 <- update(fixed,nbr.analyses=3)
dsgnIA.2 <- update(fixed,nbr.analyses=2)
seqPlotBoundary(dsgnIA.4,dsgnIA.3,dsgnIA.2)
seqPlotPower(dsgnIA.4,dsgnIA.3,dsgnIA.2,reference=fixed)
seqPlotASN(dsgnIA.4,dsgnIA.3,dsgnIA.2,reference=fixed)
seqPlotStopProb(dsgnIA.3)

zz <- seqOC(dsgnIA.3,theta=0.85)
tmp <- t(rbind(zz$lower.stop.prob,zz$upper.stop.prob,zz$stop.prob))
apply(tmp,2,sum)
sum(sampleSize(dsgnIA.3)*tmp[,3])
#[1] 1255.7

dsgnIA2.4 <- update(dsgnIA.4,test.type="two.sided")
dsgnIAnull.4 <- update(dsgnIA.4,early.stop="null")
dsgnIAalt.4 <- update(dsgnIA.4,early.stop="alt")
dsgnIAasym.4 <- update(dsgnIA.4,P=c(1,0.5))
seqPlotBoundary(dsgnIA.4,dsgnIAnull.4)
seqPlotPower(dsgnIA.4,dsgnIAnull.4,reference=fixed)
seqPlotASN(dsgnIA.4,dsgnIAnull.4,dsgnIAalt.4)
seqPlotBoundary(dsgnIA.4,dsgnIA2.4)

