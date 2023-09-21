function [Selected_Points_Info, points_num] = Evaluate_Frames_load(ParametersPath)

%load parameters
load(ParametersPath) ;
% Particle_Radius = data.Particle_Radius;
% Imin = data.Imin;
% eccentricity_uplimit = data.eccentricity_uplimit;
% scale_limit_distance = data.scale_limit_distance;
% gyration_radius_uplimit = data.gyration_radius_uplimit;
% IdivRg = data.IdivRg;
% TimeInterval = data.TimeInterval;


disp('---')
disp('Identify points')
% recognize and select points
%Selected_Points_Info = zeros(500, 6, TIF_frame_num); % at most 500 points or change value '1000'
Selected_Points_Info = cell(TIF_frame_num,1);
points_num = zeros(TIF_frame_num,1);

tic
for i = 1 : TIF_frame_num 
    load(['frame', num2str(i), '.mat'])
    recognized_result = feature2D(frame, 1, Particle_Radius, 0, Imin);
    select_points = Select_Points(recognized_result, eccentricity_uplimit, scale_limit_distance, gyration_radius_uplimit, IdivRg);
    [points_num_i, c] = size(select_points);
    points_num(i) = points_num_i;
    Selected_Points_Info{i} = select_points;
    
     %print out information every 100 frames
    if mod(i,100)==0
        disp(['Evaluating ', num2str(i)])
        toc
    end
end



end