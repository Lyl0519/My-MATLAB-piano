clear; clc; close all;

%% 输入变量
fs = 44100;
load("piano.mat"); 
pianos = spec;
sound_name = "Greatest_art.xlsx"; % 音乐谱子的Excel名称
T_nor = 80; % 通常节奏
tune = -2; % G调

%% 播放音频
summary = get_mix(sound_name, T_nor, pianos, tune);
mix = summary{1};
lyrics = summary{2};
rhythm_right = summary{3};
T = summary{4};
sound(mix,fs);

%% 歌词

for s = 1:length(lyrics)
    if isnan(T(s)) == 1
        T(s) = T_nor;
    end
    if isempty(lyrics{s}) == 1
        pause(rhythm_right(s)*(60/T(s)))
    else
        disp(lyrics{s})
        pause(rhythm_right(s)*(60/T(s)))
    end
end

% %% 画图
% Path = 'draw\resources\mat\'; 
% File = dir(fullfile(Path,'*.mat')); 
% FileNames = {File.name}'; 
% load(strcat(Path,FileNames{1}),'IH','IW');
% f1 = figure(1); 
% axis([-IW/2 IW/2 -IH/2 IH/2]); 
% f2 = figure(2);
% 
% pause(1);
% disp('今天弹的是宝可梦的经典op，相信大家都听过！！！');
% pause(2);
% disp('音乐的生成：')
% disp('和之前视频一样，通过把谱子输成excel后利用钢琴波形函数读取');
% disp('进一步加入了音量和各种装饰音的音色优化');
% pause(2);
% disp('画图过程的生成：')
% disp('在宝可梦百科上找了十二张自己比较喜欢的御三家和皮卡丘的图片');
% disp('把png格式图片转化为多边形svg路径后通过傅立叶变换拟合得到轨迹');
% disp('理论上所有图片都可以实现，并且可以轻松批量处理');
% pause(2);
% disp('整个过程还是挺有意思的！');
% disp('谢谢大家！');
% disp('！！！');
% 
% for i = 1:size(FileNames,1)
% %     i = 10;
%     load(strcat(Path,FileNames{i}));
%     t_name = strcat(erase(erase(FileNames{i},'_fourier.mat'),'480px-'));
%     figure(2);
%     imshow(strcat('draw\resources\pic_raw\Pokemon_1\',erase(FileNames{i},'_fourier.mat'),'.png'));
%     hold off; 
%     for k = 1:length(path_all)
% %       k = 1;
% %         画原图
% %         plot(path_all{k,1},path_all{k,2}, "k");      
% %         axis([-IW/2 IW/2 -IH/2 IH/2]);  
% %         hold on
% %         pause(0.1)
% %         画拟合后的轨迹图
%         figure(1);
%         axis([-IW/2 IW/2 -IH/2 IH/2]);         
%         hold on 
%         title(strcat(t_name));
%         newcomet(x_mo{k},y_mo{k}, 0.01);    
%         pause(0.001)
%     end
%     pause(1)
%     if i ~= size(FileNames,1)
%         clf(f1,'reset')
%     end
% end




