# Signal Synthesizer - MATLAB Project

## Project Overview

This project implements **Option 2: Signal Synthesizer**.The goal is to create and analyze electrical signals (sine, square, and triangle waveforms) under different noise conditions to understand signal processing concepts.

## Team Members and Roles

| Name | Role |
|------|------|
| Nathaniel Lee | Data Manager |
| Kacper Wajler | Algorithm Developer |
| Suvanjal Dhungana | Visualization Specialist |

## Project Structure

```
SignalSynthesizer/
├── Data/
│   └── Signals/
│       ├── Clean/
│       │   └── clean_signals.csv
│       ├── LowNoise/
│       │   └── low_noise_signals.csv
│       ├── HighNoise/
│       │   └── high_noise_signals.csv
│       └── signal_info.txt
├── Scripts/
│   ├── generate_data.m
│   └── main_analysis.m
├── Results/
│   ├── Figures/
│   │   ├── scenario_comparison.png
│   │   ├── frequency_comparison.png
│   │   ├── quality_metrics.png
│   │   ├── filtering_effect.png
│   │   └── signal_dashboard.png
│   ├── analysis_results.mat
│   └── summary_statistics.csv
└── README.md
```

## Data Files

### File Locations and Contents

**Clean Signals** (`Data/Signals/Clean/clean_signals.csv`)
- Pure signals without any noise added
- Used as baseline for comparison
- 1000 samples × 10 columns

**Low Noise Signals** (`Data/Signals/LowNoise/low_noise_signals.csv`)
- Signals with 0.1 amplitude noise (10% of signal amplitude)
- Generation: `signal + 0.1 × randn(size(t))`
- Represents small random interference
- 1000 samples × 10 columns

**High Noise Signals** (`Data/Signals/HighNoise/high_noise_signals.csv`)
- Signals with 0.5 amplitude noise (50% of signal amplitude)
- Generation: `signal + 0.5 × randn(size(t))`
- Represents severe random interference
- 1000 samples × 10 columns

### CSV Column Structure

Each CSV file contains the following columns:

| Column | Description |
|--------|-------------|
| Time | Time values from 0 to 10 seconds |
| Sine1Hz | 1 Hz sine wave |
| Sine5Hz | 5 Hz sine wave |
| Sine10Hz | 10 Hz sine wave |
| Square1Hz | 1 Hz square wave |
| Square5Hz | 5 Hz square wave |
| Square10Hz | 10 Hz square wave |
| Tri1Hz | 1 Hz triangle wave |
| Tri5Hz | 5 Hz triangle wave |
| Tri10Hz | 10 Hz triangle wave |

### Data Specifications

**Time Vector:**
- Duration: 10 seconds
- Sampling Rate: 100 Hz
- Total Samples: 1000
- Time Step: 0.01 seconds
- Range: [0, 10]

**Signal Parameters:**

| Signal Type | Frequency | Amplitude | Cycles | Zero Crossings |
|-------------|-----------|-----------|--------|-----------------|
| Sine | 1 Hz | ±1.0 | 10 | ~20 |
| Sine | 5 Hz | ±1.0 | 50 | ~100 |
| Sine | 10 Hz | ±1.0 | 100 | ~200 |
| Square | 1 Hz | ±1.0 | 10 | ~20 |
| Square | 5 Hz | ±1.0 | 50 | ~100 |
| Square | 10 Hz | ±1.0 | 100 | ~200 |
| Triangle | 1 Hz | ±1.0 | 10 | ~20 |
| Triangle | 5 Hz | ±1.0 | 50 | ~100 |
| Triangle | 10 Hz | ±1.0 | 100 | ~200 |

## Signal Descriptions

### Sine Wave
**Formula:** A × sin(2π × f × t)
- Smooth continuous oscillation
- Amplitude: 1.0
- Symmetric positive and negative peaks
- Most commonly used signal in engineering

### Square Wave
**Formula:** sign(sin(2π × f × t))
- Alternates abruptly between +1 and -1
- Sharp transitions at zero crossings
- Represents digital signals
- Expected peak-to-peak amplitude: 2.0

### Triangle Wave
**Generated using:**
- First half of cycle: rises linearly from -1 to +1
- Second half of cycle: falls linearly from +1 to -1
- Sharp corners (not as smooth as sine)
- Less sharp than square wave

## Noise Model

**Noise Generation Method:**
```matlab
noisy_signal = clean_signal + noise_level × randn(num_samples, 1)
```

Where `randn()` produces normally distributed random values with mean 0 and standard deviation 1.

**Scenario A - Clean (No Noise)**
- Noise Level: 0.0
- Purpose: Baseline for comparison
- SNR: Infinite

**Scenario B - Low Noise**
- Noise Level: 0.1 (10% of signal amplitude)
- Purpose: Realistic signal degradation
- SNR: ~20 dB
- Visual Impact: Signal still clearly visible

**Scenario C - High Noise**
- Noise Level: 0.5 (50% of signal amplitude)
- Purpose: Severe signal degradation
- SNR: ~6 dB
- Visual Impact: Signal often obscured by noise

## Running the Code

### Part 1: Data Generation

**Prerequisites:**
- MATLAB R2020a or later
- Signal Processing Toolbox (optional, not required)

**Steps:**

1. Navigate to the project directory in MATLAB
2. Run the data generation script:
   ```matlab
   generate_data
   ```
3. Verify CSV files are created in `Data/Signals/{Clean, LowNoise, HighNoise}/`

**Expected Output:**
- 3 CSV files (clean_signals.csv, low_noise_signals.csv, high_noise_signals.csv)
- 1 metadata file (signal_info.txt)
- Each CSV: 1000 rows × 10 columns

### Part 2: Analysis 

**Steps:**

1. Make sure Part 1 has been run first and all CSV files exist in Data/Signals/
2. Navigate to the project root directory in MATLAB
3. Add the Scripts folder to the MATLAB path:
```matlab
   addpath('Scripts')
```
4. Run the analysis script:
```matlab
   main_analysis
```

**Expected Output:**
- analysis_results.mat (full workspace)
- summary_statistics.csv (metrics for all 9 signals)
- viz_data.mat (variables for visualization script)
- Console output showing RMS, peak-to-peak, zero crossings, and filter results


### Part 3: Visualization (Visualization Specialist)



### Reflection Questions

**Algorithm Developer (Kacper Wajler):**
- What tools or strategies helped you troubleshoot or extend your code? 
- How did you ensure your script was well-documented and reusable?

Testing every section helped catch issues early, like making sure file paths were correct before running the complete analysis. Adding print statemetns helped greatly in verifing that results matched the expected values in each step. Clear variable names and comments made the scrip easier to follow and to resuse. 

---

**Generated:** April 2026  
**Project Option:** Option 2 - Signal Synthesizer  
**Course:** Engineering Applications with MATLAB