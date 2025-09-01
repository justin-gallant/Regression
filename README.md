# Bayesian Online Learning Adaption under Distribution Shift
By Justin Gallant

2025 May 27

> **Portfolio Project** – Applying the Described Technique  
> ["Detecting and Adapting to Irregular Distribution
Shifts in Bayesian Online Learning (Li et al., 2020)"](https://arxiv.org/abs/2012.08101)
---

## Overview

This project implements a novel technique in bayesian online learning to infer/predict distribution shift for a new data point, by using a smart prior which adapts to new information. This technique was proposed by Li et Al. (2020) in their paper cited above.

The method consists of creating a smart prior variable and updating this prior based on inferring distribution shifts and data freshness.

The project will implement the technique and compare it against classical prior designs, using a dataset built for in distribution shift benchmarking from the tableshift repository.

---

## Conceptual Breakdown of the Shift-Aware Bayesian Updating Technique, from 0 to 100
Ideal Requirements:
- Calculus based Probability
- Some understanding of machine learning and basic notation.

### Bayesian Learning
Bayesian Learning is a technique in machine learning, which uses Bayes Formula to treat a model's parameters as random variables, denoted by the set $\theta$; with respective distributions as opposed to a fixed float value.

#### Bayes Formula
Bayes formula is a formula for computing conditional probabilities. In simple terms,

$p(A\mid B) = \frac{p(B \mid A) \ p(A)}{p(B)}$

In our scenario we use it as follows,

$p(\theta \mid D) = \frac{p(D \mid \theta) \ p(\theta)}{p(D)}$

In plain english,

$Posterior= \frac{Likelihood \cdot Prior}{Marginal \ Likelihood}$

These terms are explained below:

#### Prior, Likelihood, Marginal Likelihood, and Posterior
#### Prior: 
A prior is defined as our beliefs about our parameters $\theta$ before seeing any data. 

Denoted $p(\theta)$.

#### Likelihood:
The Likelihood is defined how probable the observed dataset, $D = \{(x_i, y_i)\}_{i=1}^N$, is given the model parameters $\theta$,

$p(D \mid \theta) = \prod_{i=1}^N p(y_i \mid x_i, \theta)$

We assume that each observation $(x_i, y_i)$ is independent and identically distributed (i.i.d.), so every data point contributes equally to our understanding of the parameters. 
The likelihood expresses how well a particular set of parameters explains all the observed data.

#### Marginal Likelihood (Model Evidence)
The Marginal Likelihood is how well a model explains the data, given the entire set of parameters. We evaluate $p(D)$ as

$p(D) = \int p(D \mid \theta) \ p(\theta)\ d\theta$

Think of it as averaging the likelihood over all plausible parameter values according to the prior.
The formula follows naturally from Bayes’ theorem and standard probability rules, a more mathematical yet intuitive explanation can be provided [here](https://stats.stackexchange.com/questions/519422/in-the-most-basic-sense-what-is-marginal-likelihood).

#### Posterior
Our posterior is defined as: 

$p(\theta \mid D)$

It is our updated belief about the parameters after seeing data. What parameters make the most sense given the data i've seen.

### Online Learning
Online learning is a specific method in machine learning which uses new information to continuously update the model parameters after being trained. Simply put, continued training while deployed.

This technique is often very useful in time series or sequential datasets where new data, in sequence, is fed into the model after training.

### Bayesian Updating
Bayesian Updating is the technique used to update our likelihood, essentially how a bayesian model would implement online learning. 
Standard bayesian updating uses bayes formula from above. 

We can describe a simple posterior update in practice as 

$p(\theta \mid D_1) \propto p(D_1 \mid \theta) \ p(\theta)$

We refer to our data as $D_1$ since we assume it follows the same distribution in training and in evaluation, ie. the first distribution. In our model this is different.

In practice, we ignore $p(D)$ from bayes theorem since we care more about the shape of the posterior than if the result is normalized (follows a valid probability distribution), as it is computationally expensive. 
Most models also normalize the samples for us or optimize over the posterior, ignoring the need for $p(D)$.

We **DO** need $p(D)$ when we do need absolute probabilities, this is when we are comparing models via their marginal likelihood or are computing a predictive probability.

### Distribution Shift
In a perfect world with machine learning, we assume that the actual distribution of evaluatable data will remain identical to training data. 
Distribution shift refers to the divergence/changing of distributions between the training data and newly evaluated data. 

This causes our models to become less accurate and more biased to past trends.

For our project, we are integrating online learning specifically with bayesian modelling to update the prior beliefs of our model given a sequential dataset, with the goal of improving our model. 

### Proposed Shift-Aware Likelihood
The goal of using smart online learning to be aware of distribution shift in active model deployment and updating our model with more information as it is learned.

Essentially, our technique boils down to: while evaluating the likelihood, we are asking "How surprising is this new data, given my previous observations?"

To accomplish our smart likelihood, our bayesian update of our posterior takes on an updated format.

$p(\theta \mid D_{1:t}) \propto \tilde{p}(D_t \mid \theta) \ p(\theta \mid D_{1:t-1})$

$\text{new posterior} \propto \text{shift-aware likelihood of data given params} \ \cdot \ \text{old posterior}$

Where our likelihood of the new data given our parameters is:

$\tilde{p}(D_t \mid \theta)=w_t(D_t) \ p(D_t \mid \theta),$ 

$\text{shift-aware likelihood of data given params} = \text{weighted surprise} \ \cdot \ \text{likelihood of data given params}$

Where $w_t(D_t)=f(surprise(x_t,y_t))$, which is a weighted surprise defined by some function $f$. 
This function can often possess a hyperparameter controlling weight sensitivity. 
Surprise is calculated by a model in evaluation, intuitively it is exactly what it sounds like.

The update of our posterior given our weighted surprise allows us to gauge if a distribution shift has actually occured or not. 

Conceptually, we are evaluating $\text{new knowledge} = \text{evidence} \ \cdot \ \text{previous knowledge}$,
The intuitive explanation is that regions of $\theta$ which explain the new data are upweighted, and regions that don't are downweighted. The model will learn more from data which reinforces its past assumptions, but will also align with shocking data violating or differing from its previous assumptions.

We've simply gone in and added a calculation to add new data to the posterior, instead of assuming the posterior follows an identical distribution to training.

---

##  Project Structure
```plaintext
project_root/
├── README.md
├── requirements.txt
├── data/
├── notebooks/
│ ├── 0_data_exploration.ipynb
│ ├── 1_replicate_baselines.ipynb
│ ├── 2_calibration_analysis.ipynb
│ ├── 3_extension_bayesian_updates.ipynb
│ ├── 4_extension_streaming_service.ipynb
│ └── 5_tabular_finance_shift.ipynb
├── scripts/
├── results/
└── reports/
```

---

## Datasets

- **TableShift** – Tabular datasets with simulated covariate shift  
  [https://github.com/mlfoundations/tableshift](https://github.com/mlfoundations/tableshift)

---

## Get Started!
### Requirements:
Pyenv

Python version >=3.11.4

### 1. Clone the Repository to get started
```zsh
git clone https://github.com/justin-gallant/bayesian-learning-under-distribution-shift.git
cd bayesian-learning-under-distribution-shift/
```
### 2. Create the .venv
You can use zsh to set up the env!
```zsh
./setup.zsh
```
### 3. Run the setup script to get the repository running!
```zsh
python3 main.py
```

### 4. To clean up when done
\<TODO\>
```zsh
python3 clean.py
```

---

## References
Seligmann et al. (2023) – Beyond Deep Ensembles: A Large-Scale Evaluation of Bayesian Deep Learning under Distribution Shift

Koh et al. (2021) – WILDS: A Benchmark of in-the-Wild Distribution Shifts

