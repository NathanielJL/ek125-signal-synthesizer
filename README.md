# Signal Synthesizer - MATLAB Project

## Project Overview

This project implements **Option 2: Signal Synthesizer** from the Engineering Applications assignment. The goal is to create and analyze electrical signals (sine, square, and triangle waveforms) under different noise conditions to understand signal processing concepts.

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

### Part 2: Analysis (Algorithm Developer)

Run the main analysis script:
```matlab
main_analysis
```

This will:
- Load all three CSV files
- Calculate signal quality metrics (RMS, peak-to-peak, zero crossings)
- Apply filtering
- Generate analysis results
- Export summary statistics

### Part 3: Visualization (Visualization Specialist)

Figures are generated as part of the analysis script and saved to `Results/Figures/`:

1. **scenario_comparison.png** - Multi-scenario comparison for 1 Hz sine wave (clean, low noise, high noise)
2. **frequency_comparison.png** - Frequency comparison showing 1 Hz, 5 Hz, 10 Hz sine waves on same plot
3. **quality_metrics.png** - Bar chart comparing RMS values for different signal types
4. **filtering_effect.png** - Before and after filtering demonstration
5. **signal_dashboard.png** - Comprehensive 2×2 dashboard with multiple metrics

---

## PART 1: Data Generation - Completion Checklist

✅ **Data Manager (Nathaniel Lee) Deliverables:**

- ✓ `generate_data.m` script created and documented
- ✓ Generates three signal types (sine, square, triangle)
- ✓ Generates three frequencies (1 Hz, 5 Hz, 10 Hz)
- ✓ Generates three noise scenarios (clean, low, high)
- ✓ Creates proper directory structure
  - ✓ `Data/Signals/Clean/`
  - ✓ `Data/Signals/LowNoise/`
  - ✓ `Data/Signals/HighNoise/`
- ✓ Exports CSV files with proper headers
  - ✓ `clean_signals.csv` (1000 × 10)
  - ✓ `low_noise_signals.csv` (1000 × 10)
  - ✓ `high_noise_signals.csv` (1000 × 10)
- ✓ Creates metadata file (`signal_info.txt`)
- ✓ All 27 signals generated correctly (3 types × 3 frequencies × 3 scenarios)
- ✓ README.md with complete documentation

**Files Ready for Algorithm Developer:**
- All three CSV files with complete signal data
- Metadata describing signal characteristics
- Clear documentation of data structure and column meanings

---

## Data Flow to Part 2

The Algorithm Developer (Kacper Wajler) will use the generated CSV files to:
1. Load all three scenario files using `readtable()`
2. Extract signal columns for analysis
3. Calculate RMS, peak-to-peak, and zero crossing metrics
4. Apply filtering and compare results
5. Generate analysis outputs for visualization

---

## Expected Signal Characteristics

### Clean 1 Hz Sine Wave
- Period: 1 second
- Number of cycles: 10 (over 10 seconds)
- Peak amplitude: 1.0
- Trough amplitude: -1.0
- Peak-to-peak amplitude: 2.0
- Zero crossings: ~20 (2 per cycle)
- RMS value: √2/2 ≈ 0.707
- Mean value: ≈ 0.0
- Standard deviation: ≈ 0.707

### Clean 5 Hz Sine Wave
- Period: 0.2 seconds
- Number of cycles: 50 (over 10 seconds)
- Peak-to-peak amplitude: 2.0
- Zero crossings: ~100
- RMS value: ≈ 0.707

### Clean 10 Hz Sine Wave
- Period: 0.1 seconds
- Number of cycles: 100 (over 10 seconds)
- Peak-to-peak amplitude: 2.0
- Zero crossings: ~200
- RMS value: ≈ 0.707

**Noise Impact:**
- Low noise (0.1): ~10% increase in RMS, peak-to-peak values increase
- High noise (0.5): ~50% increase in RMS, signal often obscured

## Using the Data

### For Algorithm Developer (Part 2)

Load the CSV files using:
```matlab
data_clean = readtable(fullfile('Data', 'Signals', 'Clean', 'clean_signals.csv'));
data_low_noise = readtable(fullfile('Data', 'Signals', 'LowNoise', 'low_noise_signals.csv'));
data_high_noise = readtable(fullfile('Data', 'Signals', 'HighNoise', 'high_noise_signals.csv'));
```

Extract columns:
```matlab
t = data_clean.Time;
sine_1hz = data_clean.Sine1Hz;
square_5hz = data_clean.Square5Hz;
tri_10hz = data_clean.Tri10Hz;
```

### For Visualization Specialist (Part 3)

Plot signals using:
```matlab
plot(t, sine_1hz);
xlabel('Time (s)');
ylabel('Amplitude');
title('1 Hz Sine Wave - Clean Signal');
grid on;
```

Compare scenarios:
```matlab
figure;
subplot(3,1,1); plot(t, data_clean.Sine1Hz); title('Clean');
subplot(3,1,2); plot(t, data_low_noise.Sine1Hz); title('Low Noise');
subplot(3,1,3); plot(t, data_high_noise.Sine1Hz); title('High Noise');
```

## File Sizes

| File | Size |
|------|------|
| clean_signals.csv | ~150 KB |
| low_noise_signals.csv | ~194 KB |
| high_noise_signals.csv | ~194 KB |
| signal_info.txt | ~2 KB |
| generate_data.m | ~5 KB |
| **Total** | **~550 KB** |

## Key Assumptions

1. **Time Vector**: Linearly spaced from 0 to 10 seconds at 100 Hz sampling rate
2. **Signal Amplitude**: All signals normalized to amplitude of ±1.0 before noise
3. **Noise Distribution**: Normally distributed random noise (Gaussian)
4. **Noise Independence**: Each noise realization is independent (different random values each run)
5. **Directory Structure**: Assumes `Data/Signals/{Clean, LowNoise, HighNoise}/` directories exist

## Troubleshooting

**Issue: "File not found" error**
- Ensure directory structure matches: `Data/Signals/Clean/`, etc.
- Use `fullfile()` for cross-platform compatibility
- Check current working directory with `pwd`

**Issue: CSV files not created**
- Verify write permissions to `Data/Signals/` directory
- Check that MATLAB can access the directory
- Ensure `Data/Signals/` folders exist before running script

**Issue: Data looks incorrect**
- Verify sampling rate is 100 Hz
- Check that time vector goes from 0 to 10 seconds
- Confirm 1000 total samples
- Use `readtable()` to inspect CSV structure

**Issue: Noise values seem too large**
- This is expected! High noise (0.5 amplitude) can make peak-to-peak reach ±2.5
- Noise is added on top of base ±1.0 amplitude signals

## Metadata File

See `Data/Signals/signal_info.txt` for:
- Complete signal generation parameters
- Detailed signal descriptions and formulas
- Noise level specifications
- CSV file structure explanation
- Expected signal characteristics

## Next Steps

1. **Algorithm Developer**: Use `main_analysis.m` to calculate RMS, peak-to-peak, zero crossings, and test filtering
2. **Visualization Specialist**: Create the 5 required figures showing signal comparisons and analysis
3. **Entire Team**: Document findings and prepare video presentation

## Reflection Questions

### Data Manager (Nathaniel Lee):

**How did organizing files and managing data flow affect the project? What file format choices did you make and why?**

Organizing the files in a clear hierarchical structure (Clean/LowNoise/HighNoise) made it easy for the team to locate specific scenarios and understand the data organization at a glance. This modular approach reduced confusion and made it straightforward for Kacper to load the data in Part 2.

I chose CSV format because:
1. **Readability** - CSV files are human-readable and can be opened in any text editor or spreadsheet application
2. **MATLAB compatibility** - MATLAB's `readtable()` function handles CSV files elegantly while preserving column names
3. **Portability** - CSV is a universal format that can be used in other programming languages if needed
4. **Simplicity** - For our structured data with fixed columns, CSV is sufficient and avoids unnecessary complexity

Including the `signal_info.txt` metadata file was crucial because it documents all parameters, formulas, and expectations. This reduces ambiguity and helps the Algorithm Developer understand what they're analyzing. The metadata acts as a reference for verifying that calculations are correct.

The decision to include all 27 signals (3 types × 3 frequencies × 3 scenarios) in single files rather than separate files kept the data organization clean and made comparative analysis more straightforward for Part 2.

### Algorithm Developer (Kacper Wajler):

**What tools or strategies helped you troubleshoot or extend your code? How did you ensure your script was well-documented and reusable?**

Testing every section helped catch issues early, like making sure file paths were correct before running the complete analysis. Adding print statements helped greatly in verifying that results matched the expected values in each step. Clear variable names and comments made the script easier to follow and to reuse.

---

## Workspace Documentation

After running `main_analysis.m` (Part 2), the following variables will be saved in `Results/analysis_results.mat`:

- **Signal data tables:** `clean_table`, `low_noise_table`, `high_noise_table` (tables containing all signal data)
- **Time vector:** `t` (1000 × 1 array, seconds)
- **RMS metrics:** `rms_all_signals` (matrix of RMS values for all signals)
- **Peak-to-peak metrics:** `peak_to_peak_all` (matrix of peak-to-peak values)
- **Zero crossing counts:** `zero_crossings_all` (matrix of zero crossing counts)
- **Filter results:** `filtered_signals`, `rms_filtered` (filtered signal data and metrics)
- **Summary statistics:** `summary_table` (table with organized comparative results)

**Variable naming convention:** Descriptive names with underscores (e.g., `sine_1hz_clean`, `square_5hz_low_noise`) maintain clarity across the project.

**Units and Dimensions:**
- Time: seconds (s)
- Signal amplitude: normalized to ±1.0 (dimensionless)
- RMS values: amplitude units
- Peak-to-peak: amplitude units
- Zero crossings: count (dimensionless)

---

## Key Findings Summary

*To be completed after Parts 2 and 3 are finished:*

1. **Noise Impact on Signal Quality** - RMS values increase quantifiably with noise level, demonstrating signal degradation
2. **Frequency Robustness** - [To be filled after analysis: How do different frequencies respond to noise?]
3. **Signal Type Comparison** - [To be filled after analysis: Which signal types are most/least robust to noise?]
4. **Filter Effectiveness** - Moving average filter with window size 5 reduces noise while preserving signal shape
5. **Practical Applications** - Understanding signal degradation is crucial for sensor design and signal processing in real engineering systems

---

## Notes

- All code is documented with proper headers and comments
- Cross-platform compatibility ensured with `fullfile()`
- Data is ready for immediate analysis in Part 2
- No external dependencies required (uses MATLAB base functions)
- Code follows best practices for reproducibility

---

**Generated:** April 2026  
**Project Option:** Option 2 - Signal Synthesizer  
**Course:** Engineering Applications with MATLAB  