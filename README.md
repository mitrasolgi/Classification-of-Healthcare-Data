# Patient Appointment Data Analysis

This project analyzes a large dataset containing patient appointment information. The aim is to understand the factors contributing to patients not showing up for their appointments, which is of significant interest to clinics.

## Dataset Overview

- **Total Instances:**
  - **Training Set:** Approximately 84,000 instances
  - **Testing Set:** Approximately 20,000 instances

- **Class Distribution in Training Set:**
  - **Show:** Approximately 76,000 instances
  - **NoShow:** Approximately 8,000 instances

## Key Points

- Each instance in the dataset corresponds to one appointment.
- If a patient showed up on time, the instance is labeled as `Show`; otherwise, it is labeled as `NoShow`.
- The dataset is imbalanced, with a majority of records labeled as `Show` and a smaller number labeled as `NoShow`.
- The analysis focuses on identifying patterns and factors that contribute to the `NoShow` behavior.

## Project Goals

- **Understand the distribution** of `Show` and `NoShow` instances.
- **Identify key factors** influencing whether a patient shows up for their appointment.
- **Develop predictive models** to forecast the likelihood of a `NoShow` for future appointments.
