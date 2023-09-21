function selected_points_fig_save(img, Points_Info, circle_r)
% Draw circle aroud points selected on the image
% copyed from 'mpretrack_init.m'
% circle_r: size of each point
% will not display but save directly

set(0,'DefaultFigureVisible','off')

figure
%imagesc(img,[0,255]),colormap(gray);
imshow(img)
hold on
saveas(gcf, 'first_frame.jpg'); 

% Making a circle the size of the feature around each feature.

theta = 0:0.001:2*pi;
for c = 1:length(Points_Info(:,1))
    cx = Points_Info(c,1) + circle_r*cos(theta)*2;
    cy = Points_Info(c,2) + circle_r*sin(theta)*2;
    plot(cx,cy,'g-','linewidth',1.5)
end

saveas(gcf, 'points_in_first_frame.jpg'); 
hold off
set(0,'DefaultFigureVisible','on')


end