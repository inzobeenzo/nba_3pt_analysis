# NBA Three-Point Shot Value Analysis

This project analyzes historical NBA shooting data to evaluate trends in three-point usage, efficiency, and scoring impact across NBA eras.
The analysis was created as part of an application and was presented through a short slide deck.

## Motivation
The modern NBA has seen a dramatic increase in three-point attempts. This project investigates whether the three-point shot provides disproportionate value relative to other shot types by analyzing efficiency and expected value over time.

## Data
The dataset consists of publicly available NBA shooting and team statistics compiled across multiple seasons on Kaggle.
All datasets used in the analysis are located in the `data/archive` directory.

If reproducing the analysis, ensure file paths remain relative (e.g., `data/filename.csv`).

## Data Sources
- NBA historical shooting data from Kaggle:
  https://www.kaggle.com/datasets/sumitrodatta/nba-aba-baa-stats/data

## Methods
- Data cleaning and exploratory analysis using tidyverse
- Expected value calculations for different shot types
- Visualization of league-wide trends using ggplot2

## Results
Results indicate that increased three-point usage is supported by higher expected value under modern shooting efficiencies, though conclusions are sensitive to accuracy assumptions and shot distribution.

## Deliverables
- `analysis.Rmd` — main analysis code
- `nba_3pt_value_analysis.pdf` — presentation slides
- `data/` — datasets used for analysis

## Tools
R, tidyverse, ggplot2
