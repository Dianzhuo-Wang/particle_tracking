% Define all the parameters at Parameters_Define.m
ParametersPath = Parameters_Define();
load(ParametersPath)

% add path
addpath(genpath(CodeFolder)); %genpath: all the subfolders
% change directory
cd(InfoFolder)

TIF_first_frame = imread(RawDataPath);
save('first_frame.mat','TIF_first_frame')
disp('First frame saved.')
