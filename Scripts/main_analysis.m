% MAIN_ANALYSIS - Signal Processing and Analysis for Signal Synthesizer
%
% Team Members: Kacper (Algorithm Developer)
% Date: April 2026
%
% Description:
%   This script loads the signal data files created by the Data Manager
%   and analyzes them. It calculates signal quality metrics like RMS,
%   peak-to-peak amplitude, and zero crossings for each signal. It also
%   applies a moving average filter to reduce noise and saves all results.
%
% Inputs:
%   - Data/Signals/Clean/clean_signals.csv
%   - Data/Signals/LowNoise/low_noise_signals.csv
%   - Data/Signals/HighNoise/high_noise_signals.csv
%
% Outputs:
%   - Results/analysis_results.mat
%   - Results/summary_statistics.csv

clear; clc; close all;

%% Setup - create output folders if they don't exist yet

if ~isfolder('Results')
    mkdir('Results');
end

if ~isfolder('Results/Figures')
    mkdir('Results/Figures');
end

%% Load the three CSV files

% Check that the files actually exist before trying to load them
if ~isfile('Data/Signals/Clean/clean_signals.csv')
    error('Could not find clean_signals.csv - make sure you run generate_data.m first');
end
if ~isfile('Data/Signals/LowNoise/low_noise_signals.csv')
    error('Could not find low_noise_signals.csv - make sure you run generate_data.m first');
end
if ~isfile('Data/Signals/HighNoise/high_noise_signals.csv')
    error('Could not find high_noise_signals.csv - make sure you run generate_data.m first');
end

% Load each file into a table (readtable keeps the column names)
clean_data = readtable(fullfile('Data', 'Signals', 'Clean', 'clean_signals.csv'));
low_data   = readtable(fullfile('Data', 'Signals', 'LowNoise', 'low_noise_signals.csv'));
high_data  = readtable(fullfile('Data', 'Signals', 'HighNoise', 'high_noise_signals.csv'));

fprintf('Files loaded successfully!\n');
fprintf('Each table has %d rows and %d columns\n\n', size(clean_data, 1), size(clean_data, 2));

% Pull out the time vector (same for all three files)
t = clean_data.Time;

%% Extract all the signals into individual variables
% This makes it easier to work with each signal by name

% Clean signals
clean_sine1   = clean_data.Sine1Hz;
clean_sine5   = clean_data.Sine5Hz;
clean_sine10  = clean_data.Sine10Hz;
clean_sq1     = clean_data.Square1Hz;
clean_sq5     = clean_data.Square5Hz;
clean_sq10    = clean_data.Square10Hz;
clean_tri1    = clean_data.Tri1Hz;
clean_tri5    = clean_data.Tri5Hz;
clean_tri10   = clean_data.Tri10Hz;

% Low noise signals
low_sine1   = low_data.Sine1Hz;
low_sine5   = low_data.Sine5Hz;
low_sine10  = low_data.Sine10Hz;
low_sq1     = low_data.Square1Hz;
low_sq5     = low_data.Square5Hz;
low_sq10    = low_data.Square10Hz;
low_tri1    = low_data.Tri1Hz;
low_tri5    = low_data.Tri5Hz;
low_tri10   = low_data.Tri10Hz;

% High noise signals
high_sine1   = high_data.Sine1Hz;
high_sine5   = high_data.Sine5Hz;
high_sine10  = high_data.Sine10Hz;
high_sq1     = high_data.Square1Hz;
high_sq5     = high_data.Square5Hz;
high_sq10    = high_data.Square10Hz;
high_tri1    = high_data.Tri1Hz;
high_tri5    = high_data.Tri5Hz;
high_tri10   = high_data.Tri10Hz;

%% Calculate RMS for every signal
% RMS = root mean square = sqrt(mean(signal^2))
% This measures the average power of a signal

% Clean RMS values
rms_clean_sine1   = sqrt(mean(clean_sine1.^2));
rms_clean_sine5   = sqrt(mean(clean_sine5.^2));
rms_clean_sine10  = sqrt(mean(clean_sine10.^2));
rms_clean_sq1     = sqrt(mean(clean_sq1.^2));
rms_clean_sq5     = sqrt(mean(clean_sq5.^2));
rms_clean_sq10    = sqrt(mean(clean_sq10.^2));
rms_clean_tri1    = sqrt(mean(clean_tri1.^2));
rms_clean_tri5    = sqrt(mean(clean_tri5.^2));
rms_clean_tri10   = sqrt(mean(clean_tri10.^2));

% Low noise RMS values
rms_low_sine1   = sqrt(mean(low_sine1.^2));
rms_low_sine5   = sqrt(mean(low_sine5.^2));
rms_low_sine10  = sqrt(mean(low_sine10.^2));
rms_low_sq1     = sqrt(mean(low_sq1.^2));
rms_low_sq5     = sqrt(mean(low_sq5.^2));
rms_low_sq10    = sqrt(mean(low_sq10.^2));
rms_low_tri1    = sqrt(mean(low_tri1.^2));
rms_low_tri5    = sqrt(mean(low_tri5.^2));
rms_low_tri10   = sqrt(mean(low_tri10.^2));

% High noise RMS values
rms_high_sine1   = sqrt(mean(high_sine1.^2));
rms_high_sine5   = sqrt(mean(high_sine5.^2));
rms_high_sine10  = sqrt(mean(high_sine10.^2));
rms_high_sq1     = sqrt(mean(high_sq1.^2));
rms_high_sq5     = sqrt(mean(high_sq5.^2));
rms_high_sq10    = sqrt(mean(high_sq10.^2));
rms_high_tri1    = sqrt(mean(high_tri1.^2));
rms_high_tri5    = sqrt(mean(high_tri5.^2));
rms_high_tri10   = sqrt(mean(high_tri10.^2));

fprintf('RMS calculation done.\n');
fprintf('Clean 1Hz sine RMS = %.4f (should be around 0.707)\n', rms_clean_sine1);
fprintf('Clean 1Hz square RMS = %.4f (should be around 1.000)\n\n', rms_clean_sq1);

%% Calculate Peak-to-Peak Amplitude for every signal
% Peak-to-peak = max value minus min value
% For a clean signal this should be about 2.0 (goes from -1 to +1)
% Noise makes this number bigger

p2p_clean_sine1   = max(clean_sine1)  - min(clean_sine1);
p2p_clean_sine5   = max(clean_sine5)  - min(clean_sine5);
p2p_clean_sine10  = max(clean_sine10) - min(clean_sine10);
p2p_clean_sq1     = max(clean_sq1)    - min(clean_sq1);
p2p_clean_sq5     = max(clean_sq5)    - min(clean_sq5);
p2p_clean_sq10    = max(clean_sq10)   - min(clean_sq10);
p2p_clean_tri1    = max(clean_tri1)   - min(clean_tri1);
p2p_clean_tri5    = max(clean_tri5)   - min(clean_tri5);
p2p_clean_tri10   = max(clean_tri10)  - min(clean_tri10);

p2p_low_sine1   = max(low_sine1)  - min(low_sine1);
p2p_low_sine5   = max(low_sine5)  - min(low_sine5);
p2p_low_sine10  = max(low_sine10) - min(low_sine10);
p2p_low_sq1     = max(low_sq1)    - min(low_sq1);
p2p_low_sq5     = max(low_sq5)    - min(low_sq5);
p2p_low_sq10    = max(low_sq10)   - min(low_sq10);
p2p_low_tri1    = max(low_tri1)   - min(low_tri1);
p2p_low_tri5    = max(low_tri5)   - min(low_tri5);
p2p_low_tri10   = max(low_tri10)  - min(low_tri10);

p2p_high_sine1   = max(high_sine1)  - min(high_sine1);
p2p_high_sine5   = max(high_sine5)  - min(high_sine5);
p2p_high_sine10  = max(high_sine10) - min(high_sine10);
p2p_high_sq1     = max(high_sq1)    - min(high_sq1);
p2p_high_sq5     = max(high_sq5)    - min(high_sq5);
p2p_high_sq10    = max(high_sq10)   - min(high_sq10);
p2p_high_tri1    = max(high_tri1)   - min(high_tri1);
p2p_high_tri5    = max(high_tri5)   - min(high_tri5);
p2p_high_tri10   = max(high_tri10)  - min(high_tri10);

fprintf('Peak-to-peak calculation done.\n');
fprintf('Clean 1Hz sine peak-to-peak = %.4f (should be close to 2.0)\n\n', p2p_clean_sine1);

%% Calculate Zero Crossings for every signal
% A zero crossing is when the signal switches from positive to negative or vice versa
% diff(sign(signal)) gives a nonzero value wherever the sign changes
% For a 1 Hz signal over 10 seconds we expect about 20 crossings (2 per cycle)

zc_clean_sine1   = sum(diff(sign(clean_sine1))  ~= 0);
zc_clean_sine5   = sum(diff(sign(clean_sine5))  ~= 0);
zc_clean_sine10  = sum(diff(sign(clean_sine10)) ~= 0);
zc_clean_sq1     = sum(diff(sign(clean_sq1))    ~= 0);
zc_clean_sq5     = sum(diff(sign(clean_sq5))    ~= 0);
zc_clean_sq10    = sum(diff(sign(clean_sq10))   ~= 0);
zc_clean_tri1    = sum(diff(sign(clean_tri1))   ~= 0);
zc_clean_tri5    = sum(diff(sign(clean_tri5))   ~= 0);
zc_clean_tri10   = sum(diff(sign(clean_tri10))  ~= 0);

zc_low_sine1   = sum(diff(sign(low_sine1))  ~= 0);
zc_low_sine5   = sum(diff(sign(low_sine5))  ~= 0);
zc_low_sine10  = sum(diff(sign(low_sine10)) ~= 0);
zc_low_sq1     = sum(diff(sign(low_sq1))    ~= 0);
zc_low_sq5     = sum(diff(sign(low_sq5))    ~= 0);
zc_low_sq10    = sum(diff(sign(low_sq10))   ~= 0);
zc_low_tri1    = sum(diff(sign(low_tri1))   ~= 0);
zc_low_tri5    = sum(diff(sign(low_tri5))   ~= 0);
zc_low_tri10   = sum(diff(sign(low_tri10))  ~= 0);

zc_high_sine1   = sum(diff(sign(high_sine1))  ~= 0);
zc_high_sine5   = sum(diff(sign(high_sine5))  ~= 0);
zc_high_sine10  = sum(diff(sign(high_sine10)) ~= 0);
zc_high_sq1     = sum(diff(sign(high_sq1))    ~= 0);
zc_high_sq5     = sum(diff(sign(high_sq5))    ~= 0);
zc_high_sq10    = sum(diff(sign(high_sq10))   ~= 0);
zc_high_tri1    = sum(diff(sign(high_tri1))   ~= 0);
zc_high_tri5    = sum(diff(sign(high_tri5))   ~= 0);
zc_high_tri10   = sum(diff(sign(high_tri10))  ~= 0);

fprintf('Zero crossings calculation done.\n');
fprintf('Clean 1Hz sine zero crossings = %d (should be around 20)\n\n', zc_clean_sine1);

%% Calculate Descriptive Statistics
% Mean should be close to 0 for all signals (they are symmetric around zero)
% Standard deviation measures how spread out the values are - grows with noise
% Variance is the standard deviation squared

mean_clean_sine1  = mean(clean_sine1);
std_clean_sine1   = std(clean_sine1);
var_clean_sine1   = var(clean_sine1);

mean_low_sine1    = mean(low_sine1);
std_low_sine1     = std(low_sine1);
var_low_sine1     = var(low_sine1);

mean_high_sine1   = mean(high_sine1);
std_high_sine1    = std(high_sine1);
var_high_sine1    = var(high_sine1);

fprintf('Descriptive stats for 1Hz sine wave:\n');
fprintf('  Clean     - Mean: %.4f  Std: %.4f  Var: %.4f\n', mean_clean_sine1, std_clean_sine1, var_clean_sine1);
fprintf('  Low Noise - Mean: %.4f  Std: %.4f  Var: %.4f\n', mean_low_sine1,   std_low_sine1,   var_low_sine1);
fprintf('  High Noise- Mean: %.4f  Std: %.4f  Var: %.4f\n\n', mean_high_sine1, std_high_sine1, var_high_sine1);

%% Calculate Degradation Percentage
% This tells us how much the noise changed each signal compared to the clean version
% Formula: |clean_rms - noisy_rms| / clean_rms * 100

degrade_low_sine1   = abs(rms_clean_sine1  - rms_low_sine1)  / rms_clean_sine1  * 100;
degrade_low_sine5   = abs(rms_clean_sine5  - rms_low_sine5)  / rms_clean_sine5  * 100;
degrade_low_sine10  = abs(rms_clean_sine10 - rms_low_sine10) / rms_clean_sine10 * 100;
degrade_low_sq1     = abs(rms_clean_sq1    - rms_low_sq1)    / rms_clean_sq1    * 100;
degrade_low_sq5     = abs(rms_clean_sq5    - rms_low_sq5)    / rms_clean_sq5    * 100;
degrade_low_sq10    = abs(rms_clean_sq10   - rms_low_sq10)   / rms_clean_sq10   * 100;
degrade_low_tri1    = abs(rms_clean_tri1   - rms_low_tri1)   / rms_clean_tri1   * 100;
degrade_low_tri5    = abs(rms_clean_tri5   - rms_low_tri5)   / rms_clean_tri5   * 100;
degrade_low_tri10   = abs(rms_clean_tri10  - rms_low_tri10)  / rms_clean_tri10  * 100;

degrade_high_sine1   = abs(rms_clean_sine1  - rms_high_sine1)  / rms_clean_sine1  * 100;
degrade_high_sine5   = abs(rms_clean_sine5  - rms_high_sine5)  / rms_clean_sine5  * 100;
degrade_high_sine10  = abs(rms_clean_sine10 - rms_high_sine10) / rms_clean_sine10 * 100;
degrade_high_sq1     = abs(rms_clean_sq1    - rms_high_sq1)    / rms_clean_sq1    * 100;
degrade_high_sq5     = abs(rms_clean_sq5    - rms_high_sq5)    / rms_clean_sq5    * 100;
degrade_high_sq10    = abs(rms_clean_sq10   - rms_high_sq10)   / rms_clean_sq10   * 100;
degrade_high_tri1    = abs(rms_clean_tri1   - rms_high_tri1)   / rms_clean_tri1   * 100;
degrade_high_tri5    = abs(rms_clean_tri5   - rms_high_tri5)   / rms_clean_tri5   * 100;
degrade_high_tri10   = abs(rms_clean_tri10  - rms_high_tri10)  / rms_clean_tri10  * 100;

fprintf('RMS Degradation under high noise:\n');
fprintf('  Sine  1Hz:   %.2f%%\n', degrade_high_sine1);
fprintf('  Sine  5Hz:   %.2f%%\n', degrade_high_sine5);
fprintf('  Sine  10Hz:  %.2f%%\n', degrade_high_sine10);
fprintf('  Square 1Hz:  %.2f%%\n', degrade_high_sq1);
fprintf('  Tri    1Hz:  %.2f%%\n\n', degrade_high_tri1);

%% Apply Moving Average Filter to reduce noise
% movmean smooths a signal by replacing each point with the average of
% itself and its neighbors. Window size of 5 means 5 consecutive points
% are averaged together. A bigger window gives a smoother result but can
% blur the shape of the original waveform.

window_size = 5;
filtered_signal = movmean(high_sine1, window_size);

% Compare RMS before and after filtering
rms_before    = sqrt(mean(high_sine1.^2));
rms_after     = sqrt(mean(filtered_signal.^2));
rms_clean_ref = sqrt(mean(clean_sine1.^2));

fprintf('Moving Average Filter (window = %d points):\n', window_size);
fprintf('  RMS before filtering: %.4f\n', rms_before);
fprintf('  RMS after filtering:  %.4f\n', rms_after);
fprintf('  RMS of clean signal:  %.4f\n', rms_clean_ref);

% Calculate how much the filter improved the signal
improvement = (abs(rms_before - rms_clean_ref) - abs(rms_after - rms_clean_ref)) ...
              / abs(rms_before - rms_clean_ref) * 100;
fprintf('  Improvement toward clean signal: %.1f%%\n\n', improvement);

%% Save Results

% Save the entire workspace to a .mat file so everything can be reloaded later
save(fullfile('Results', 'analysis_results.mat'));
fprintf('Workspace saved to Results/analysis_results.mat\n');

% Build summary table with the key metrics for all 9 signals
signal_names_col = {'Sine1Hz'; 'Sine5Hz'; 'Sine10Hz'; ...
                    'Square1Hz'; 'Square5Hz'; 'Square10Hz'; ...
                    'Tri1Hz'; 'Tri5Hz'; 'Tri10Hz'};

rms_clean_col = [rms_clean_sine1; rms_clean_sine5; rms_clean_sine10; ...
                 rms_clean_sq1;   rms_clean_sq5;   rms_clean_sq10; ...
                 rms_clean_tri1;  rms_clean_tri5;  rms_clean_tri10];

rms_low_col   = [rms_low_sine1; rms_low_sine5; rms_low_sine10; ...
                 rms_low_sq1;   rms_low_sq5;   rms_low_sq10; ...
                 rms_low_tri1;  rms_low_tri5;  rms_low_tri10];

rms_high_col  = [rms_high_sine1; rms_high_sine5; rms_high_sine10; ...
                 rms_high_sq1;   rms_high_sq5;   rms_high_sq10; ...
                 rms_high_tri1;  rms_high_tri5;  rms_high_tri10];

p2p_clean_col = [p2p_clean_sine1; p2p_clean_sine5; p2p_clean_sine10; ...
                 p2p_clean_sq1;   p2p_clean_sq5;   p2p_clean_sq10; ...
                 p2p_clean_tri1;  p2p_clean_tri5;  p2p_clean_tri10];

p2p_high_col  = [p2p_high_sine1; p2p_high_sine5; p2p_high_sine10; ...
                 p2p_high_sq1;   p2p_high_sq5;   p2p_high_sq10; ...
                 p2p_high_tri1;  p2p_high_tri5;  p2p_high_tri10];

degrade_high_col = [degrade_high_sine1; degrade_high_sine5; degrade_high_sine10; ...
                    degrade_high_sq1;   degrade_high_sq5;   degrade_high_sq10; ...
                    degrade_high_tri1;  degrade_high_tri5;  degrade_high_tri10];

summary_table = table(signal_names_col, rms_clean_col, rms_low_col, rms_high_col, ...
                      p2p_clean_col, p2p_high_col, degrade_high_col, ...
    'VariableNames', {'Signal', 'RMS_Clean', 'RMS_LowNoise', 'RMS_HighNoise', ...
                      'P2P_Clean', 'P2P_HighNoise', 'Degradation_Pct'});

writetable(summary_table, fullfile('Results', 'summary_statistics.csv'));
fprintf('Summary saved to Results/summary_statistics.csv\n\n');

% Save a separate file with just what the visualization specialist needs
save(fullfile('Results', 'viz_data.mat'), ...
    't', ...
    'clean_sine1', 'clean_sine5', 'clean_sine10', ...
    'low_sine1',   'high_sine1', ...
    'clean_sq1',   'low_sq1',   'high_sq1', ...
    'clean_tri1',  'low_tri1',  'high_tri1', ...
    'filtered_signal', ...
    'rms_clean_col', 'rms_low_col', 'rms_high_col', ...
    'p2p_clean_col', 'p2p_high_col', ...
    'degrade_high_col', ...
    'zc_clean_sine1', 'zc_low_sine1', 'zc_high_sine1', ...
    'rms_before', 'rms_after', 'rms_clean_ref', ...
    'signal_names_col');

fprintf('Visualization data saved to Results/viz_data.mat\n');
fprintf('\nAnalysis complete!\n');