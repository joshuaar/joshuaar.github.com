---
layout: post
category : lessons
title: "Calculating Significance of Venn Diagram Overlaps in R"
tagline: "just for reference" 
tags : [statistics]
---
{% include JB/setup %}

##Calculating Venn Diagram Significance

Say you have a venn diagram, showing two sets, both a subset of some larger population. These sets may have some overlap, that is, some number of identical elements. This is the union of thr two subsets. This is easily visualized by a venn diagram.

![Venn Diagram Example]({{ site.url }}/assets/img/venn.png)

This venn diagram came from a population of 9750 unique elements. Each set, the blue one and the yellow one, were drawn independantly according to some criterion (not important). A natural question is: how likely is this middle overlap given the population size, the number of elements in the two big circles, and the overlap in the middle.

This can easily be computed with the hypergeometric distribution in R.

    population_total = 9750
    first_draw = 324
    second_draw = 788
    overlap = 28
    phyper(overlap, first_draw, population_total, second_draw)

This returns the following p value:

    [1] 0.7515316

So the overlap is not significant in this case.

##What is happening

Basically you are removing some elements from the total population, in this case consisting of 9750 elements. You make the left draw (blue), then look at the elements and take note. These are the "successes" in the language of the hypergeometric distribution. Put those elements back, and draw the right side (yellow). Now consider how many in the yellow set come also from the right set. Hypergeometric distribution allows calculation of this p value

###Disclaimer

I spent like 5 minutes on this. It might have some errors. Use with caution and don't believe everything you read on the internet.
