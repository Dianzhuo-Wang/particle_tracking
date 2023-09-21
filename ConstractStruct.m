function TracksStruct = ConstractStruct(res_track, TIF_frame_num)

TracksStruct = struct;
total_points_num = res_track(size(res_track,1),8); % the last index
for i=1:total_points_num
    %find all rows for ith point
    position_of_ith_point = find(res_track(:,8)==i);
    TracksStruct(i,1).frameNum = res_track(position_of_ith_point,6)-1;
    TracksStruct(i,1).points = res_track(position_of_ith_point,1:2);
end

% % Check if points trace in TracksStruct complete and remove those
% % incomplete ones.
% disp('---')
% disp('Select Points')
% remove_list = [];
% for i=1:length(TracksStruct)
%     if length(TracksStruct(i).frameNum) ~= TIF_frame_num
%         remove_list = [remove_list, i];
%     end
% end
% TracksStruct = TracksStruct(setdiff(1:i,remove_list));
% 
% end
