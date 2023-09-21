RawDataFolder = '/n/scratch2/ys258/Helen/0Zn';
TIF_File_Name = '20180702_PEG_1V_0Zn.tif';
stack_name = fullfile(RawDataFolder, TIF_File_Name); %fullfile: generate file path name


% cerate folder for saving
Data_Name = regexp(TIF_File_Name, '\.', 'split');
Data_Name = char(Data_Name(1)); % extract string before '.tif'
InfoFolder = fullfile(RawDataFolder, Data_Name);
mkdir(InfoFolder);

cd(InfoFolder)


read_frames = [3722 4299];
Nframes = 20005;
%get data block size
info1 = imfinfo(stack_name);
stripOffset = info1(1).StripOffsets;
stripByteCounts = info1(1).StripByteCounts;

%get image size
sz_x=info1(1).Width;
sz_y=info1(1).Height;



fID = fopen (stack_name, 'r');

% if info1(1).BitDepth==16
%     stack_out = zeros([sz_y sz_x Nframes],'uint16');
% else
%     stack_out = zeros([sz_y sz_x Nframes],'uint8');
% end

start_point = stripOffset(1) + (0:1:(Nframes-1)).*stripByteCounts;

for i = read_frames
    %fprintf ('loading image ... %d\n', i);
    fseek (fID, start_point(i)+1, 'bof');
    
    if info1(1).BitDepth==16
        A = fread (fID, [sz_x sz_y], 'uint16=>uint16');
    else
        A = fread (fID, [sz_x sz_y], 'uint8=>uint8');
    end
    
%     stack_out(:,:,i) = A';
    frame = A';
    save(['frame', num2str(i), '.mat'],'frame');
    clear frame A
    
 
end
