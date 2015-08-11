---
layout: post
category : musings
tagline: "is it useful?" 
tags : [analytics, machine learning, healthcare]
---
{% include JB/setup %}

#Machine Learning in Healthcare

There has been a lot of attention and talk in recent years on machine learning on healthcare. If only we could do for clinical data what google does for internet searches we could live longer, healthier lives and spend less money! This sounds good and makes reasonable sense; why should we not learn from our existing data in order to predict and prevent disease? What new questions can be answered if only we understood the world's longitudinal health records? Here I try to lay out the possibilities and challenges around using machine learning as a tool for medical knowledge discovery and clinical decision support.

##What Data are Available?

The most common and easily accessable form of healthcare data is claims data. These are submitted to insurers whenever a patient needs to pay for a clinical service. This contains information about the type of service performed, the dollar amount that was charged, any associated diagnoses, lengths of hospital stays, and other information that an insurance company may be interested. This data never includes lab results, xrays, physicians charts, or any other information required only by the provider of care or patient. 

Claims data is easier to get, more structured and more complete than clinical data. After all, a claim must be submitted each time a provider wants to collect money for rendered services. It follows that it is the data most used for analysis and machine learning. Indeed, insurance companies have been doing lots of things with claims data for many years. They have actuaries that develop sophistocated risk models from claims data to ensure that their companies remain profitable. While risk and resource usage is a good thing for insuance companies to know about, it does not help the patient or physician utilize this data fo affect positive health outcomes. 

Researchers also have had looks at claims data. Since the mid 90's, people have been predicting [Length of Stay](http://www.sciencedirect.com/science/article/pii/0895435694002022?np=y), [resource usage](http://acg.jhsph.org/), and [30-day readmission risk](http://circoutcomes.ahajournals.org/content/1/1/29.short) based on claims data. Notice none of these problems attempt to predict risk for individual diseases or provide much insight to doctors on how to proceed with a given patient. I personally believe this is an inherent limitation of the data that it has limited use for diagnois or to inform specific treatments. Ask yourself if you were a physician with access to only a patient's past claims, would you be able to make good decisions on how to approach that patient's healtcare?

Unfortunately, claims data is not very rich as it does not contain information about how a diagnosis was arrived at, or why a specific procedure was done. One can observe that a patient saw a doctor, but there is no indication of their symptoms, lab results, xray results, genomic data (if it exists), etc. The machine is working with one hand tied behind its back, so to speak, because it does not have access to the same information as the physician. 

###Clinical Data

Clinical data, while rich, present their own set of problems due to its complexity. This can encompass anything from radiology results to notes on a patient's chart. Only some of it is in electronic form, even less is structured, and much is never stored permanently. What is stored and how it is stored varies by site, and it is designed for access by physicians, not analysts. Obtaining and putting this data to meaningful use is a challenge, but healthcare is changing rapidly and systems designed to [share data between healthcare organizations](http://www.healthit.gov/providers-professionals/health-information-exchange/what-hie) are becoming more commonplace.

Even in a world where healthcare data is totally connected and accessable to researchers, the problem remains that healthcare organizations do not bother to structure data that they do not need to turn over to payers! This means that much of the valuable information; the stuff that the physician uses to make decisions, is inaccessable to the computer. This begs the question: What can we do with available clinical and claims data?

##What to Do with Healthcare Data

Given all the hurdles and nastiness surrounding clinical data, what useful things can we do with it? I think it is importantt to relize up front that we are not going to cure cancer with any clinical data existing in clinical systems today. However, there is much to be done to assist clinical knowledge discovery and validation. There is a wealth of longitudinal data available for millions of patients that has never been looked at by a scientist. Surely there are some useful and interesting questions that could be answered using this trove!

There are two predominent studies that contribute to human medical knowledge. These are retrospective and prospective studies. 

(MORE COMING SOON)



