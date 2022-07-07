clear;
clc;
fs = 44100;  %88音采样率
[a,note_name] = xlsread("note.xlsx");   %88音名称
cent= logspace(log10(440),log10(1760), 25);
C5 = round(cent(4:15)'*(2^-5)); C4 = round(cent(4:15)'*(2^-4));
C3 = round(cent(4:15)'*(2^-3)); C2 = round(cent(4:15)'*(2^-2));
C1 = round(cent(4:15)'*(2^-1)); C0 = round(cent(4:15)'*(2^0)); 
c1 = round(cent(4:15)'*(2^1)); c2 = round(cent(4:15)'*(2^2));
c3 = round(cent(4:15)'*(2^3));
freqs_raw = [C5; C4; C3; C2; C1; C0; c1; c2; c3];
freqs = freqs_raw(10:97);  %通过十二平均律提取88音基音频率

% rhythm = 1;
% fir_filter_bandpass = fir1(128, [28*2/fs 4186*2/fs],"bandpass");
% fmt_filter = filter(fir_filter_bandpass, 1, fmt);

scale = {};
% cell数组scale，存放88个音的：名称，基音频率，真实波形，频谱分布
spec = {};
% cell数组spec，存放从频谱分布中提取出的88个音分别的泛音频率与振幅

for i = 1:88
    scale(i,1) = note_name(i); %名称
    scale{i,2} = freqs(i); %频率
    [fmti,fs] = audioread(strcat("piano88\",note_name{i},".mp3"));
    scale{i,3} = fmti(:,1); %钢琴音波形,
%     i = 1;
%     sound(scale{i,3},fs); 
    spectum = abs(fft(scale{i,3}));
    real_amp = spectum(1:floor(length(spectum)/2))/(length(spectum)/2);
    real_spec = fs * (1:floor(length(spectum)/2))/ length(spectum);
    scale{i,4} = [real_spec', real_amp];
%     plot(real_spec, real_amp);
    k = 1; 
    for j = 1:length(real_amp)
    if real_amp(j) > 5*10^-4
        spec{i,k} = [real_spec(j),real_amp(j)];
        k = k + 1;
    end
    end    
%     for p =1:length(speci)
%         yi = yi + sin(speci{p}(1)*xi)*speci{p}(2);
%     end
%     scale{i,5} = yi.*yw;
end
save("piano.mat","scale","spec");
