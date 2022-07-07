function y= get_mix(file_name,pace,pianos,tune)
fs = 44100;
%% 调用钢琴音的傅立叶级数
type = pianos;
%% 编码音符
Fix_tune = [3, 15, 27, 39, 51, 63, 75, 87];
c = Fix_tune + tune ; 
do = c+1; doR = c+2;
re = c+3; reR = c+4;
mi = c+5;
fa = c+6; faR = c+7;
sol = c+8; solR = c+9;
la = c+10; laR = c+11; siF = c+11;
si = c+12;
air = 0;
% center = 4;

%% 导入编码好的excel乐谱文件，并设置节奏
[rhythm_all, tone_all] = xlsread (strcat('resources\',file_name));  % 输入编码好的乐谱excel名称
T_normal = pace; % 输入节奏

%% 音量与歌词
volume = tone_all(:,13);
f = 1; mf = 2; mp = 3; p = 4;
y{2} = tone_all(:,14); 
%% 创建左手
rhythm_left = rhythm_all(:,9);
tone_all_left = tone_all(:,8:11);
pace_left = rhythm_all(:,14);
y_l=[];
for i = 1:length(rhythm_left)
    if isnan(rhythm_left(i)) == 1
        continue
    end
    tone_left_i = tone_all_left(i,:);
    for j = 1:length(tone_left_i)
        if isempty(tone_left_i{j}) == 0
            finger_left(i,j) = eval(tone_left_i{j});
        else
            finger_left(i,j) = 0;
        end
    end
    volume_i = eval(volume{i});
    if isnan(pace_left(i)) == 1
        t = 60/T_normal;
    else
        t = 60/pace_left(i);
    end
    yi_l = gen_wave2(finger_left(i,:),t*rhythm_left(i),type,1,volume_i);
    y_l = [y_l,yi_l];
end

%% 创建右手
rhythm_right = rhythm_all(:,2);
tone_all_right = tone_all(:,1:4);
pace_right = rhythm_all(:,7);
y_r=[];
for i = 1:length(rhythm_right)
    if isnan(rhythm_right(i)) == 1
        continue
    end
    tone_right_i = tone_all_right(i,:);
    for j = 1:length(tone_right_i)
        if isempty(tone_right_i{j}) == 0
            finger_right(i,j) = eval(tone_right_i{j});
        else
            finger_right(i,j) = 0;
        end
    end
    volume_i = eval(volume{i});
    if isnan(pace_right(i)) == 1
        t = 60/T_normal;
    else
        t = 60/pace_right(i);
    end
    yi_r = gen_wave2(finger_right(i,:),t*rhythm_right(i),type,2,volume_i);
    y_r = [y_r,yi_r];
end    

%% 校正左右手音轨并组合，产生音轨mix和歌词
duration = max(length(y_l),length(y_r));
y_l = [y_l,zeros(1,duration-length(y_l))];
y_r = [y_r,zeros(1,duration-length(y_r))];
y{1} = [y_l',y_r'];
y{3} = rhythm_right;
y{4} = pace_right;


%% 播放 并同时disp歌词
%  sound(y_l,fs)
%  sound(y_r,fs)    
%  sound(mix,fs)
% 
% for s = 1:length(lyric)
%     if isempty(lyric{s}) == 1
%         pause(rhythm_right(s)*t)
%     else
%         disp(lyric{s})
%         pause(rhythm_right(s)*t)
%     end
% end
end
