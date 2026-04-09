% GENERATE_DATA - Signal Generation & Data Export for Signal Synthesizer
%
% Team Members: Nathaniel Lee (Data Manager)
% Date: April 2026
%
% Description:
% This script generates three types of electrical signals (sine, square, triangle)
% at three different frequencies (1 Hz, 5 Hz, 10 Hz) under three noise conditions
% (clean, low noise, high noise). Organizes all data into appropriate directory
% structure and exports to CSV files.
%
% Inputs: None (all parameters defined in script)
% Outputs: 
%   - CSV files in Data/Signals/{Clean, LowNoise, HighNoise}/
%   - signal_info.txt with metadata

clear; clc; close all;

%% Parameters
duration = 10;              % 10 seconds
sampling_rate = 100;        % 100 samples per second
num_samples = duration * sampling_rate;  % 1000 total samples
t = linspace(0, duration, num_samples)';  % Time vector as column

frequencies = [1, 5, 10];
noise_level_low = 0.1;
noise_level_high = 0.5;

%% Create directories
base_dir = 'Data/Signals';
clean_dir = fullfile(base_dir, 'Clean');
low_noise_dir = fullfile(base_dir, 'LowNoise');
high_noise_dir = fullfile(base_dir, 'HighNoise');

% Create base directory
if ~isfolder(base_dir)
    mkdir(base_dir);
end

% Create subdirectories
if ~isfolder(clean_dir)
    mkdir(clean_dir);
end

if ~isfolder(low_noise_dir)
    mkdir(low_noise_dir);
end

if ~isfolder(high_noise_dir)
    mkdir(high_noise_dir);
end

%% Scenario A: Clean Signals
clean_table = table();
clean_table.Time = t;

for i = 1:length(frequencies)
    freq = frequencies(i);
    
    % Sine wave
    sine_col_name = sprintf('Sine%dHz', freq);
    clean_table.(sine_col_name) = generate_sine_wave(1, freq, t);
    
    % Square wave
    square_col_name = sprintf('Square%dHz', freq);
    clean_table.(square_col_name) = generate_square_wave(freq, t);
    
    % Triangle wave
    tri_col_name = sprintf('Tri%dHz', freq);
    clean_table.(tri_col_name) = generate_triangle_wave(freq, t);
end

clean_file_path = fullfile(clean_dir, 'clean_signals.csv');
writetable(clean_table, clean_file_path);

%% Scenario B: Low Noise Signals
low_noise_table = clean_table;

signal_columns = clean_table.Properties.VariableNames(2:end);

for i = 1:length(signal_columns)
    col_name = signal_columns{i};
    noise = noise_level_low * randn(num_samples, 1);
    low_noise_table.(col_name) = clean_table.(col_name) + noise;
end

low_noise_file_path = fullfile(low_noise_dir, 'low_noise_signals.csv');
writetable(low_noise_table, low_noise_file_path);

%% Scenario C: High Noise Signals
high_noise_table = clean_table;

for i = 1:length(signal_columns)
    col_name = signal_columns{i};
    noise = noise_level_high * randn(num_samples, 1);
    high_noise_table.(col_name) = clean_table.(col_name) + noise;
end

high_noise_file_path = fullfile(high_noise_dir, 'high_noise_signals.csv');
writetable(high_noise_table, high_noise_file_path);

%% signal_info.txt - Metadata File
info_file_path = fullfile(base_dir, 'signal_info.txt');
fid = fopen(info_file_path, 'w');

fprintf(fid, '========================================\n');
fprintf(fid, 'SIGNAL SYNTHESIZER - DATA INFORMATION\n');
fprintf(fid, '========================================\n\n');

fprintf(fid, 'SIGNAL GENERATION PARAMETERS:\n');
fprintf(fid, '------------------------------------\n');
fprintf(fid, 'Duration: %d seconds\n', duration);
fprintf(fid, 'Sampling Rate: %d Hz\n', sampling_rate);
fprintf(fid, 'Total Samples per Signal: %d\n', num_samples);
fprintf(fid, 'Time Step: %.3f seconds\n\n', 1/sampling_rate);

fprintf(fid, 'FREQUENCIES:\n');
fprintf(fid, '------------------------------------\n');
fprintf(fid, 'Low Frequency: 1 Hz (1 cycle per second)\n');
fprintf(fid, 'Medium Frequency: 5 Hz (5 cycles per second)\n');
fprintf(fid, 'High Frequency: 10 Hz (10 cycles per second)\n\n');

fprintf(fid, 'SIGNAL TYPES:\n');
fprintf(fid, '------------------------------------\n');
fprintf(fid, '1. Sine Wave: A * sin(2*pi*f*t)\n');
fprintf(fid, '   Amplitude: 1.0\n\n');

fprintf(fid, '2. Square Wave: sign(sin(2*pi*f*t))\n');
fprintf(fid, '   Amplitude: ±1.0\n\n');

fprintf(fid, '3. Triangle Wave: Custom linear ramps\n');
fprintf(fid, '   Amplitude: ±1.0\n\n');

fprintf(fid, 'NOISE CONDITIONS:\n');
fprintf(fid, '------------------------------------\n');
fprintf(fid, 'Scenario A - Clean: No noise (0.0)\n');
fprintf(fid, 'Scenario B - Low Noise: 0.1 amplitude (10%%)\n');
fprintf(fid, 'Scenario C - High Noise: 0.5 amplitude (50%%)\n\n');

fprintf(fid, 'CSV COLUMNS:\n');
fprintf(fid, '------------------------------------\n');
fprintf(fid, 'Time | Sine1Hz | Sine5Hz | Sine10Hz | Square1Hz | Square5Hz | Square10Hz | Tri1Hz | Tri5Hz | Tri10Hz\n\n');

fclose(fid);
fprintf('  ✓ Saved to: %s\n\n', info_file_path);

%% Signal Generation Functions

function sine = generate_sine_wave(amplitude, frequency, time)
    % Generate sine wave
    % sine = amplitude * sin(2*pi*frequency*time)
    sine = amplitude * sin(2 * pi * frequency * time);
end

function square = generate_square_wave(frequency, time)
    % Generate square wave using sign function
    % Alternates between +1 and -1
    square = sign(sin(2 * pi * frequency * time));
end

function triangle = generate_triangle_wave(frequency, time)
    % Generate triangle wave
    % Rises from -1 to +1 in first half of cycle
    % Falls from +1 to -1 in second half of cycle
    
    period = 1 / frequency;
    triangle = zeros(size(time));
    
    for i = 1:length(time)
        % Position within current cycle (0 to 1)
        cycle_pos = mod(time(i), period) / period;
        
        if cycle_pos <= 0.5
            % Rising edge: -1 to +1
            triangle(i) = -1 + 4 * cycle_pos;
        else
            % Falling edge: +1 to -1
            triangle(i) = 3 - 4 * cycle_pos;
        end
    end
end

fprintf('Data generation complete! All files saved in %s\n', base_dir);