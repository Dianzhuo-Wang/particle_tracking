% Run all analyze on the server
% Parameters should be determined first
% Use parallel computing, core 20

%%
% Initialize
%clear
disp('Initialize')

% Define all the parameters at Parameters_Define.m
ParametersPath = Parameters_Define();
load(ParametersPath)

% add path
addpath(genpath(CodeFolder)); %genpath: all the subfolders
% change directory
cd(InfoFolder)
%%
%-------
disp('------')
disp('Import Video')
%tic
imread_big_giveNframe_filesave(TIF_frame_num, RawDataPath);

%t = toc;
%disp(['Vedio imported used ', num2str(t), 's'])

%%
disp('-----')
disp('Evaluate points in each frame.')
%tic
[Selected_Points_Info, points_num] = Evaluate_Frames_load(ParametersPath);
MT_final = ConstractMT(Selected_Points_Info, points_num, TimeInterval, TIF_frame_num);
%t = toc;
%disp(['Analyze each frame costed: ', num2str(t), 's'])
save('Select_Info.mat','Selected_Points_Info', 'points_num', 'TIF_frame_num', 'MT_final')
% clear some varables
clear TIF  % tif too big and won't use later
%%

% 
% tic
% disp('------')
% disp('Start tracking.')
tic
res_track = trackmem( MT_final, TRACK_maxdisp, 2, TRACK_goodenough, TRACK_memory ); % 2D space

%save('RawResult.mat','res_track')
t = toc;
disp(['Tracking: ', num2str(t), 's'])

%%
tic
disp('------')
disp('Select result and echange track result into form of struct.')

% Change Data Form to Struct
% construct TracksStruct used later
% final result as res_track
TracksStruct = ConstractStruct(res_track, TIF_frame_num);
save('TracksStruct.mat', 'TracksStruct');
disp('TracksStruct saved.')
disp([num2str(length(TracksStruct)), ' points in final.'])
t = toc;
disp(['Tracking: ', num2str(t), 's'])

%% Identify points in first frame
% if start analyze after get TracksStruct, run init first and load in TracksStruct.mat
% load('TracksStruct.mat')
disp('------')
disp('Circle points tracked on the first frame.')
TIF_first_frame = imread(RawDataPath);
Final_Points_num = length(TracksStruct);
Final_Points_xy = zeros(Final_Points_num,2);
for i=1:Final_Points_num
    Final_Points_xy(i,:) = TracksStruct(i).points(1,1:2);
end

% figure
selected_points_fig_save(TIF_first_frame, Final_Points_xy, Particle_Radius*2);
disp('Figure saved.')

% delete frame.mat
for i=1:TIF_frame_num
    delete(['frame', num2str(i), '.mat'])
end
