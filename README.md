# Amazon Sales Dashboard

## Overview

This application is a Shiny dashboard built with Shiny for R to explore an Amazon sales dataset. The dashboard allows users to filter the data by year and view revenue information. By selecting different years, users can see how revenue changes over time and compare trends across months.

The goal of this dashboard is to help users quickly understand sales patterns and how revenue evolves over time. This information can help clients or business teams identify periods of higher or lower sales and adjust their strategies accordingly, such as planning promotions, managing inventory, or preparing for peak sales periods.

Users can:
- Select one or more years using a checkbox input
- View the total revenue in a value box
- See the revenue trend over time in a line chart

## Deployed Application

The deployed version of the dashboard can be accessed here:

**Deployed App:** https://019ced2f-6fb6-7b60-f035-5dcfb65d32ab.share.connect.posit.cloud/

## Environment Setup

1. Clone this repository:
    ```bash
    git clone https://github.com/Yuji03b/DSCI-individual-amazon.git
    cd DSCI-individual-amazon
    ```

2. Create a conda environment based on the provided `environment.yml` file:
    ```bash
    conda env create -f environment.yml
    ```

3. Activate the environment:

    ```bash
    conda activate amazon-r
    ```
    
## Running the Application Locally

1. After activating the environment, run the app in R:

    ```r
    shiny::runApp("src")
    ```

2. Open the URL shown in the terminal (e.g., `http://127.0.0.1:4618`) in your browser to access the dashboard.

## Data

- Dataset: Amazon Sales Dataset
- Source: Kaggle
- Link: https://www.kaggle.com/datasets/aliiihussain/amazon-sales-dataset
- Stored locally in: `data/raw/amazon_sales_dataset.csv`
- Size: ~4.2 MB

The dataset is included in the repository for reproducibility. No external download is required.

