function Points_Info = Select_Points(Points_Info, eccentricity_uplimit, scale_limit_distance, gyration_radius_uplimit, IdivRg)
% Remove data points not satisfy reqirements
% Functions mostly same as "mpretrack_init.m", both used to determine 
% parameters used. Differents: 
% 1.should run "feature2D" first, just used to select features.
% 2.without filename reqirements.
% 3.delet those points who are close to each other.
% 4.won't plot out the result.
% 
% Functions:
% 1.remove points with too big eccentricity
% 2.remove points with too big radius of gyration
% 3.remove two very close data points: since data of points ascending order
%   according to x and y, chech if any two point's x,y with in a distant 
%  (scale limit distancce), delete both points.
% 4.IdivRg: minimum ratio of Intensity/pixel to be accepted (integrated
%   intensity / Rg squared of feature) should less than a seted value
point_num = size(Points_Info,1);
abandon_points_list = [];
for i = 1 : point_num
   % Points_Info(:,4) : gyration radius ; Points_Info(:,5) : eccentricity
   if (Points_Info(i, 4) > gyration_radius_uplimit )||(Points_Info(i,5) > eccentricity_uplimit) || (Points_Info(i, 3)/Points_Info(i, 4)<IdivRg)
% Remove data points not satisfy reqirements
       abandon_points_list = union(abandon_points_list,i);
       continue
   end
   
   % Loop to select close points
   iadd = 0;
   while true
       iadd = iadd + 1;
       if i+iadd > point_num
           break
       elseif abs(Points_Info(i+iadd,1)-Points_Info(i,1)) < scale_limit_distance % check if x close enough
           if abs(Points_Info(i+iadd,2)-Points_Info(i,2)) < scale_limit_distance % check if y close enough
               abandon_points_list = union(abandon_points_list,[i,i+iadd]);
               continue
           end
       else
           break
       end
   end
end

reserve_points_list = setdiff(1:point_num,abandon_points_list);
Points_Info = Points_Info(reserve_points_list,:);




end