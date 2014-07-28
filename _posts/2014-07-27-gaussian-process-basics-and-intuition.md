---
layout: post
category : lessons
title: "Gaussian Processes"
tagline: "Basics and Intuition" 
tags : [statistics]
---
{% include JB/setup %}

Code for producing the plots can be found [here](https://gist.github.com/joshuaar/0be2845c29043c85f6ff).

##What is a Gaussian Process?


A gaussian process is the extention of the multivariate normal
distribution into infinite dimensions. While this may seem scary, it's
not too bad if you understand the properties of the multivariate normal/gaussian.

Consider the following multivariate distribution:

$$Y \sim N(0,\Sigma)$$

In this case, the mean vector is \\(0\\) and \\(\Sigma\\), a positive semidefinite covariance matrix, entirely defines the distribution. 

Here is an example of some draws for some random \\(\Sigma\\):
![draws from a multivariate normal]({{ site.url }}/assets/img/mnorm_c1.jpg)

Each point on the x axis is a dimension of the gaussian, and lines are drawn between points from the same draw.
the covariance matrix generating these draws is:

    3.7799057  0.9942859  0.1426901 -2.14437150 -0.87656510
    0.9942859  4.6095693  0.5109240  0.23370453 -0.35542610
    0.1426901  0.5109240  2.5624934  3.05793805 -1.12699493
    -2.1443715  0.2337045  3.0579380  5.55169240  0.07973036
    -0.8765651 -0.3554261 -1.1269949  0.07973036  5.53095843

Now, as mentioned before, a Gaussian process is just a multivariate 
normal distribution carried to infinite dimensions, but \\(ND\\) gaussians
require an \\(N * N\\) matrix.

How to make an \\(\infty D\\) gaussian aka Gaussian Process? 

###Constructing a gaussian process
  
To construct the GP, we need some rules. 
First, we need a set \\(T\\).
The only requirements on \\(T\\) are that for any elements 
\\(t_i \in T\\) and \\(t_j \in T\\), that there is some 
notion of distance \\(D(t_i, t_j)\\) between two elements of 
the set. If \\(T = \mathbb{R}^d \\) then \\(D=||t_i-t_j||\\) is a 
valid choice. For now we will assume \\(T = \mathbb{R}\\). 

The important thing about T is that each 
element is assigned to one "dimension" 
in our gaussian process such that for any 
finite sequence 

$$(t_1,t_2,t_3,...t_n) \in T$$

the random vector 

$$(X_{t1}, X_{t2}, X_{t3}, ..., X_{tn})$$

is distributed multivariate normal. 

In order to meet this requirement 
we will use something called a __kernel__ of which our distance function
from above is an important part.

The kernel allows us to generate our infinite covariance matrix. 
This important function will completely define our gaussian process. 
One example is the 
[RBF kernel](http://en.wikipedia.org/wiki/Radial_basis_function_kernel)
which looks like this:

$$K(t_i, t_j) = exp(-\frac{||t_i - t_j||^2}{2l^2})$$

It has a single parameter, \\(l\\) which determines the "wiggliness" of the GP.
This function enables us to translate elements from T into "dimensions" of the
GP. You can find more examples of kernel 
functions [here](http://mlg.eng.cam.ac.uk/duvenaud/cookbook/index.html).

Lets sample from a part of a gaussian process 
along the integers \\(1:50 \subset T\\) as our finite sequence. This 
should allow us to compute a multivariate gaussion from which we can
 take draws. 
Here is what these draws look like for various values of \\(l\\):

![draws from a gaussian process]({{ site.url }}/assets/img/4plots.jpg)

###Fitting gaussian processes to data

When computing gaussian processes, you're really just computing multivariate
distributions with covariances determined by a kernel. 
To incorporate observations, simply condition the gaussian process 
on the observed variables. Say, for the above example, we made the
following observations:

    T  	Y
    5	3.3
    7	2.1
    10	0.5
    15	-1.0
    40	0.0

By computing the [conditional distrubution](http://en.wikipedia.org/wiki/Multivariate_normal_distribution#Conditional_distributions) 
on the observations, we constrain the GP producing fits that look more orderly. Here are plots and 95% CI bounds for the GP dimensions corresponding to \\(1:50\\):

![Draws from conditioned gaussian process]({{ site.url }}/assets/img/4fittedplot.jpg)

The first thing you might notice in these plots is that there is no noise at the five points corresponding to observations. This is due to the simplistic way I defined my gaussian process. More sophistocated methods will add noise to these observations to make a more realistic model, which is purposefully ignored here for simplicity.

Why are conditioned gaussian processes useful, you might ask? Well, most people use gaussian processes to do some sort of prediction.
A kalman filter, for example, is very similar to a gaussian process and is well known as a good localization predictor. Other uses include gaussian process regression.

 You can see that between each datapoint is a range of values between the blue lines. This is the 95% confidence interval, meaning we're pretty confident that the missing data falls between these lines. Gaussian processes allow us to do prediciton.

###Hyperparameters

As you can see, our conditioned gaussian process depends strongly on our choice of the parameter \\(l\\). This is known as a hyperparameter, and choosing these is the domain of [Bayesian Statistics](http://en.wikipedia.org/wiki/Bayesian_statistics). 

The details of fitting hyperparameters to data is beyond the scope of this guide. Briefly, you assign a prior distribution over the hyperparameters of interest, then use an [MCMC](http://en.wikipedia.org/wiki/Markov_chain_Monte_Carlo) to estimate the posterior probabilities on those hyperparameters.

###Closing remarks

The examples shown here all were from a 1-dimensional set \\(T\\). This set need not be one dimensional, and in real world situations this may be many-dimensioned or even infinite-dimensioned. Further, there are many possible kernels and hyperparameters for building more complicated models. The intent of this guide is to provide an intuition for what gaussian processes are and how they are used. For a more detailed introduction, see [this link](http://www.cs.toronto.edu/~hinton/csc2515/notes/gp_slides_fall08.pdf) 

[an even better introduction](https://www.cs.ubc.ca/~hutter/EARG.shtml/earg/papers05/rasmussen_gps_in_ml.pdf)

[code alternate link]({{ site.url }}/assets/code/gProcess.r).
