function y= gen_wave2(finger, rhythm, spec, hand, volume)
%% ���ò����ʵȱ���
    fs = 44100;
    amp = 2*pi*rhythm;
    xi = linspace(0,amp,floor(fs*rhythm));
    yi = zeros(1,floor(fs*rhythm));
    y = zeros(1,floor(fs*rhythm));
%     yw = [linspace(0, 1.5*amp, floor(fs*rhythm/5)), ...
%       linspace(1.5*amp, amp, floor(fs*rhythm/3)-floor(fs*rhythm/5)), ...
%       ones(1, floor(fs*rhythm*2/3)-ceil(fs*rhythm/3))*amp, ...
%       linspace(amp, 0, ceil(fs*rhythm)-ceil(fs*rhythm*2/3))]./exp(xi);
%% ���纯��
     ywl = (xi.^(1/15))./exp(xi./(2*pi*rhythm));
    
       
%% ���������εĴ���  
    i = 1;
    while i <= length(finger)
        if finger(i) == 0
            yo = sin(0*xi);
        % ����
        elseif finger(i) ~= 0
            for p =1:200
                if isempty(spec{finger(i),p}) == 1
                break
                end
                yi = yi + 5*sin(spec{finger(i),p}(1)*xi)*spec{finger(i),p}(2);                
            %  �������ø���Ҷ�任�Ӹ���������ȡ�ķ��������Ƶ��
            end
            if hand == 1
                yo = yi.*ywl*0.5;
%                 yo = yi.*0.5;
            elseif hand == 2
                yo = yi.*ywl;
%                 yo = yi;
            end
            %  ����
        end
        y = y + (1/(length(finger))).* yo;
        %  ���Ӷ������
        i = i + 1;
    end
    
%% ����    
    if volume == 1 %% f
        y = y*2.5;
    elseif volume == 2 %% mf
        y = y*2;
    elseif volume == 3 %% mp
        y = y*1.5;
    elseif volume == 4 %% p
        y = y*1;   
    end
    
end