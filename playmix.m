clear; clc; close all;

%% �������
fs = 44100;
load("piano.mat"); 
pianos = spec;
sound_name = "Greatest_art.xlsx"; % �������ӵ�Excel����
T_nor = 80; % ͨ������
tune = -2; % G��

%% ������Ƶ
summary = get_mix(sound_name, T_nor, pianos, tune);
mix = summary{1};
lyrics = summary{2};
rhythm_right = summary{3};
T = summary{4};
sound(mix,fs);

%% ���

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

% %% ��ͼ
% Path = 'draw\resources\mat\'; 
% File = dir(fullfile(Path,'*.mat')); 
% FileNames = {File.name}'; 
% load(strcat(Path,FileNames{1}),'IH','IW');
% f1 = figure(1); 
% axis([-IW/2 IW/2 -IH/2 IH/2]); 
% f2 = figure(2);
% 
% pause(1);
% disp('���쵯���Ǳ����εľ���op�����Ŵ�Ҷ�����������');
% pause(2);
% disp('���ֵ����ɣ�')
% disp('��֮ǰ��Ƶһ����ͨ�����������excel�����ø��ٲ��κ�����ȡ');
% disp('��һ�������������͸���װ��������ɫ�Ż�');
% pause(2);
% disp('��ͼ���̵����ɣ�')
% disp('�ڱ����ΰٿ�������ʮ�����Լ��Ƚ�ϲ���������Һ�Ƥ�����ͼƬ');
% disp('��png��ʽͼƬת��Ϊ�����svg·����ͨ������Ҷ�任��ϵõ��켣');
% disp('����������ͼƬ������ʵ�֣����ҿ���������������');
% pause(2);
% disp('�������̻���ͦ����˼�ģ�');
% disp('лл��ң�');
% disp('������');
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
% %         ��ԭͼ
% %         plot(path_all{k,1},path_all{k,2}, "k");      
% %         axis([-IW/2 IW/2 -IH/2 IH/2]);  
% %         hold on
% %         pause(0.1)
% %         ����Ϻ�Ĺ켣ͼ
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




