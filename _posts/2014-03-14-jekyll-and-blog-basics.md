---
layout: post
category : lessons
tagline: "First Post" 
tags : [intro,first,post]
---
{% include JB/setup %}

##Why a blog?

I need a place to document useful tidbits of information.

## Jekyll Basics

I am using Jekyll for this. I was impressed with its ease of setup, the "just works" feel,
and the included examples. It greatly reduced the activation energy required to get this started.
Starting from scratch on an Ubuntu 13.04 machine, I just did the following:

    sudo apt-get install ruby-full
    sudo apt-get install gem
    sudo gem install jekyll
    jekyll serve #serves the website, in my case this was generated by github pages 

On the flipside, you can only sort posts by date, no custom sort. I'd prefer that kind of info be stored within the markdown itself.

### How to do lists in markdown

I'll probably need to make some lists at some point, especially if I start makeing some real posts.
Here's how to do it:

    - List item 1 
    - List item 2
    - List item 3 
    - List item 4
    - etc.
