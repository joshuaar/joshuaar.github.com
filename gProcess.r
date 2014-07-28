rbf=function(a,b,l,s=1)s*exp(-((a-b)^2) / (2*l^2))
cov=function(x1,x2,K)sapply(x2,function(i)sapply(x1,function(j)K(i,j)))

K = function(a,b)rbf(a,b,5)

conditional = function(x1, x2, y2, K){ #x1,x2,y1,u1,u2 are all vectors	
	K11 = cov(x1,x1,K)
	K12 = cov(x1,x2,K)
	K22_1 = solve(cov(x2,x2,K))
	K21 = cov(x2,x1,K)
	#mu = u1 + K12 %*% K22_1 %*% (y2 - u2)
	mu = K12 %*% K22_1 %*% (y2)
	sigma = K11 - K12 %*% K22_1 %*% K21 
	list(sigma,mu,cbind(x2,y2))
}

rbfGP = function(obs, xs, l, s){
	K = function(a,b)rbf(a,b,l,s)
	x2 = obs[,1]
	y2 = obs[,2]
	conditional(xs,x2,y2,K)
	
}

plt = function(res,n,title="plt"){
	r2=mvrnorm(n,res[[2]][,1],res[[1]])
	quantiles = apply(r2,2,function(i)quantile(i,probs=c(0.05,0.5,0.95)))	
	ylim = c(min(quantiles),max(quantiles))
	plot(quantiles[2,],xlab="GP Dimension",ylab="Y",ylim=ylim,type="l", lty=2, lwd=2,col="red",main=title)
	lines(quantiles[1,],col="blue")	
	lines(quantiles[3,],col="blue")
	points(res[[3]],col="black")	
#	for(i in 1:nrow(r2)){
#		lines(r2[i,])
#	}
}

pltdraws = function(x,rbfk,n,title){
	c1 = cov(x,x,rbfk)
	draws = mvrnorm(n,rep(0,length(x)),c1)
	ylim = c(min(draws),max(draws))
	plot(draws[1,],ylim=ylim,xlab="Dimension",ylab="Y",main=title)
	for(i in 1:nrow(draws)){
		lines(draws[i,])
	}
}

plt4GPs = function(){
	x = 1:50
	rbf1 = function(a,b)rbf(a,b,1)
	rbf5 = function(a,b)rbf(a,b,5)
	rbf10 = function(a,b)rbf(a,b,10)
	rbf20 = function(a,b)rbf(a,b,20)
	par(mfrow=c(2,2))
	pltdraws(x,rbf1,10,"L = 1")
	pltdraws(x,rbf5,10,"L = 5")
	pltdraws(x,rbf10,10,"L = 10")
	pltdraws(x,rbf20,20,"L = 20")
}

plt4FittedGPs = function(){
	x = 1:50
	obs = cbind(c(5,7,10,15,40),c(3.3,2.1,.5,-1,0))
	par(mfrow=c(2,2))
	plt(rbfGP(obs,1:50,1,5),10,title="L = 1")
	plt(rbfGP(obs,1:50,5,5),10,"L = 5")
	plt(rbfGP(obs,1:50,10,5),10, "L = 15")
	plt(rbfGP(obs,1:50,20,5),10, "L = 20")
	
	
}


