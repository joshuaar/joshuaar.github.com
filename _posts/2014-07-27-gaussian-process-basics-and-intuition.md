---
layout: post
category : lessons
title: "Gaussian Processes"
tagline: "Basics and Intuition" 
tags : [statistics]
---
{% include JB/setup %}

##What is a Gaussian Process?


A gaussian process, put simply, is the extention of the multivariate normal
distribution into infinite dimensions. While this may seem scary, it's really
not too bad if you understand the properties of the multivariate normal.

Consider the following multivariate normal distribution:

$$Y \sim N(0,\Sigma)$$

In this case, \\(\Sigma\\), a positive semidefinite matrix, entirely defines the distribution. 

Here is an example of some draws for some random \\(\Sigma\\):
![draws from a multivariate normal]({{ site.url }}/assets/img/mnorm_c1.jpg)

the parameters for the distribution that these draws came from is defined below:

    sigma = 
    3.7799057  0.9942859  0.1426901 -2.14437150 -0.87656510
    0.9942859  4.6095693  0.5109240  0.23370453 -0.35542610
    0.1426901  0.5109240  2.5624934  3.05793805 -1.12699493
    -2.1443715  0.2337045  3.0579380  5.55169240  0.07973036
    -0.8765651 -0.3554261 -1.1269949  0.07973036  5.53095843

    mu = 
    0	0	0	0	0

Now, as mentioned before, a Gaussian process is just a multivariate normal distribution carried to infinite dimensions. But, if dimensions are infinite, then \\(\Sigma\\) is an infinite by infinite matrix. We get around this by defining \\(\Sigma\\) as a function rather than a finite dimensioned matrix.  

###Constructing a gaussian process

To construct the GP, we need some rules. First, we need a set \\(T\\). It doesn't
really matter what T is. It could be any set. The only requirement (to my knowledge) is that for any elements \\(t1 \in T\\) and \\(t2 \in T\\), some distance function \\(||t1-t2||\\) is defined. In order to make visualization easier, we will assume \\(T = \mathbb{R}\\). 

The important thing about T is that each element is assigned to one "dimension" in our gaussian process such that for any finite sequence 

\\((t1,t2,t3,...tn) \in T\\)

the multivariate random variable 

\\((X_{t1}, X_{t2}, X_{t3}, ..., X_{tn})\\)

is distributed multivariate normal. The relationship between the t's and X's will become clearer after introducing the concept of a kernel.

The second thing we need is some function to represent our infinite covariance matrix. Since we assume our mean vector is $$0$$, this important function, known as a __kernel__, will completely define our gaussian process. One example of a kernal is the 
[RBF kernel](http://en.wikipedia.org/wiki/Radial_basis_function_kernel)
which looks like this:

\\(K(t_a, t_b) = exp(-\frac{||t_a - t_b||^2}{2l^2})\\)

It has a single parameter, \\(l\\) which defines the "wiggliness" of the GP. This function enables us to translate elements from T into "dimensions" of the GP. You can find more examples of kernel functions [here](http://mlg.eng.cam.ac.uk/duvenaud/cookbook/index.html).

Remember, gaussian processes are just multivariate normal distributions with infinite dimensions. So, lets look at part of a gaussian process using integers \\(1:50\\) as our finite sequence. This should give us a multivariate gaussion from which we can take draws. Here is what these draws look like for various values of \\(l\\):


![draws from a gaussian process]({{ site.url }}/assets/img/4plots.jpg)

###Fitting gaussian processes to data

Fitting a gaussian process to observed data is trivial if you have fully defined and paramatarized your kernel function. Simply condition your gaussian process on your observed variables. Say, for our above example, we made the following observations:

    X  	Y
    5	3.3
    7	2.1
    10	0.5
    15	-1.0
    40	0.0

following the [formula](http://en.wikipedia.org/wiki/Multivariate_normal_distribution#Conditional_distributions) for getting a conditional distribution from a multivariate normal (it works the same for a gaussian process), we can put bounds on our gaussian process, and we get fits that look more orderly. Here are plots and 95% CI bounds for the GP dimensions corresponding to \\(1:50\\):

![Draws from conditioned gaussian process]({{ site.url }}/assets/img/4fittedplot.jpg)

Why do this, you might ask? Well, most people use gaussian processes to do some sort of prediction. You can see that between each datapoint is a range of values between the blue lines. This is the 95% confidence interval, meaning we're pretty confident that the missing data falls between these lines. Gaussian processes allow us to do prediciton.

###Hyperparameters

As you can see, our conditioned gaussian process depends strongly on our choice of the parameter \\(l\\). This is known as a hyperparameter, and choosing these is the domain of [Bayesian Statistics](http://en.wikipedia.org/wiki/Bayesian_statistics). 

The details of fitting hyperparameters to data is beyond the scope of this guide. Briefly, you assign a prior distribution over the hyperparameters of interest, then use an [MCMC](http://en.wikipedia.org/wiki/Markov_chain_Monte_Carlo) to estimate the posterior probabilities on those hyperparameters.

###Closing remarks

The examples shown here all were from a 1-dimensional set \\(T\\). This set need not be one dimensional, and in real world situations this may be many-dimensioned or even infinite-dimensioned. Further, there are many possible kernels and hyperparameters for building more complicated models. The intent of this guide is to provide an intuition for what gaussian processes are and how they are used. For a more rigerous introduction, see [this link](http://www.cs.toronto.edu/~hinton/csc2515/notes/gp_slides_fall08.pdf) 

Code for producing the plots can be found [here]({{ site.url }}/assets/code/gProcess.r).
