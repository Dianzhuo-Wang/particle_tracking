function MT_final = ConstractMT(Selected_Points_Info, points_num, TimeInterval,TIF_frame_num)


disp('---')
disp('Construct MT_final for tracking')
MT_final = zeros(sum(points_num),6);

for i =1:TIF_frame_num
    d = sum(points_num(1:i-1));
    a = points_num(i);
    MT_final(d+1:a+d,1:5) = Selected_Points_Info{i};
    MT_final(d+1:a+d,6) = i;
    MT_final(d+1:a+d,7) = i*TimeInterval;
end

end
