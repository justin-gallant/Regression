# Bayesian Deep Learning under Distribution Shift – Replication & Extension
By Justin Gallant

2025 May 27

> **Portfolio Project** – Replicating and extending  
> ["Beyond Deep Ensembles: A Large-Scale Evaluation of Bayesian Deep Learning under Distribution Shift" (Seligmann et al., 2023)](https://arxiv.org/abs/2306.12306)

---

## Overview

This project reproduces key experiments from the 2023 paper, which evaluates multiple Bayesian Deep Learning (BDL) methods for robustness under real-world distribution shifts.  
It then **extends** the work with:
- Bayesian **online updating** under shift,
- A **streaming prediction service** with uncertainty monitoring,

---

## Goals

1. **Replication** – Match reported results for:
   - **ERM** (Empirical Risk Minimization)
   - **Deep Ensembles**
   - **Variational Inference** (Bayes by Backpropagation)
   - **SWAG** (Stochastic Weight Averaging Gaussian)

2. **Analysis** – Evaluate:
   - Accuracy
   - Calibration metrics (ECE, reliability diagrams)
   - Worst-group performance (WILDS group labels)

3. **Extension** – Demonstrate:
   - Bayesian online adaptation post-shift
   - Real-time drift monitoring via a model-serving API
   - Cross-domain robustness (finance tabular datasets)

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

- **WILDS CivilComments** – Text classification under subgroup shift  
  [https://wilds.stanford.edu/](https://wilds.stanford.edu/)

- **TableShift** – Tabular datasets with simulated covariate shift  
  [https://github.com/mlfoundations/tableshift](https://github.com/mlfoundations/tableshift)

---

## Get Started!
### Requirements:
Pyenv

Python version >=3.11.4

### 1. Clone the Repository to get started
```zsh
git clone https://github.com/justin-gallant/regression.git
cd Regression/
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

