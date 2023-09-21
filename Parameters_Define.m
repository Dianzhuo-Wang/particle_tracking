function save_path = Parameters_Define()
% Define all the parameters needed and save to mat
% Create path to save processing and result data

% path information

% RawDataFolder = '/n/scratch2/ys258/test_vedios';
% TIF_File_Name = '20180824_M1p5_1umBSA_1.tif';
% RawDataPath = fullfile(RawDataFolder, TIF_File_Name); %fullfile: generate file path name
% CodeFolder = '/n/scratch2/ys258/lxytest';
RawDataFolder = '/n/scratch2/ys258/20180824';
TIF_File_Name = '20180824_M1p5_1umBSA_1.tif';
RawDataPath = fullfile(RawDataFolder, TIF_File_Name); %fullfile: generate file path name
CodeFolder = '/n/scratch2/ys258/lxytest/Particle_Tracking';

% cerate folder for saving
Data_Name = regexp(TIF_File_Name, '\.', 'split');
Data_Name = char(Data_Name(1)); % extract string before '.tif'
InfoFolder = fullfile(RawDataFolder, Data_Name);
mkdir(InfoFolder);

% tif file infomation
TimeInterval = 0.01; % interval between each frame
TIF_frame_num = 20005;

%Parameters:
Particle_Radius = 4; % size of particle in pixel
Imin = 6000; % min brightness
scale_limit_distance = 10; % discard too close points (distance in pixel)
gyration_radius_uplimit = 20; % uplimit of radius?
eccentricity_uplimit = 0.2; % Eccentricity: 0 to be circle and 1 to be line. For single particle, should near 1.
IdivRg = 300;  % minimum ratio of Intensity/pixel to be accepted (integrated intensity / Rg squared of feature)



% tracking
TRACK_maxdisp = 5; % (optional) specifies the maximum displacement (in pixels) a feature may make between successive frames
TRACK_goodenough = 20005; % (optional) the minimum length requirement for a trajectory to be retained
TRACK_memory = 1; % (optional) specifies how many consecutive frames a feature is allowed to skip.

disp('------')
disp('Please check paths below correct before start. If not, quit and change it.')
disp(['Code Folder:',CodeFolder])
disp(['Raw Data Folder:',RawDataFolder])
disp(['Video Name:',TIF_File_Name])
disp(['Path to save processing data:',InfoFolder])
disp(['Time interval between each frame:', TimeInterval])
disp(['Total frame number:', TIF_frame_num])

disp('---')
disp('Parameters now:')
disp(['Size of particle in pixel (Particle_Radius):', num2str(Particle_Radius)])
disp(['Minimum brightness (value in matrix) to consider as signal (Imin):', num2str(Imin)])
disp(['Exclude points with in distance (in pixel) (scale_limit_distance):', num2str(scale_limit_distance)])
disp(['Radius of gyration uplimit (gyration_radius_uplimit):', num2str(gyration_radius_uplimit)])
disp(['Eccentricity uplimit (eccentricity_uplimit):', num2str(eccentricity_uplimit)])
disp(['Minimum ratio of Intensity/pixel to be accepted (IdivRg):', num2str(IdivRg)])

disp('---')
disp('Tracking Parameters:')
disp(['Maximum displacement between two frame allowed:', num2str(TRACK_maxdisp)])
disp(['The minimum length requirement for a trajectory to be retained:', num2str(TRACK_goodenough)])
disp(['How many consecutive frames a feature is allowed to skip:', num2str(TRACK_memory)])

% disp('Press keys to continue')
% pause
save_path = fullfile(InfoFolder, 'Parameters.mat');
disp('Parameters saved.')
save(save_path);
