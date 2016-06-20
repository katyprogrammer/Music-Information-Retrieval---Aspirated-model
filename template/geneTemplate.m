clear;close all;clc;
fs = 65536;
w = 4096; h = w / 8; nfft = w;
k = 3;beta = 3;nIter = 30;
rangel = 48;rangeh = 94;rangen = rangeh - rangel + 1;
dur = 1;
N = round(dur * fs);
time = (0:N-1) / fs;
d = 10;
%%
% volumn = 100000;
% dur = 1;
% W = [];
% sig = [];
% % for i = 48:120
% %     pitch = midi2freq(i);
% %     sig = [sig, geneAsp2(pitch,dur,volumn)];
% % end
% % spec = stft(sig, w, h, nfft, fs);
% % spec_abs = abs(spec);
% % spec_angle = angle(spec);
% % W = betaNTF(spec_abs, rangen,'beta', beta, 'nIter', 30);
% 
% randtemp = round(rand(1,round(fs/2/d)) * (length(fs/2)-1))+1;
% for i = rangel:rangeh
%     pitch = midi2freq(i);
%     %sig = geneAsp2_2(pitch,dur,volumn,randtemp);
%     sig = geneAsp2(pitch,dur,volumn);
%     sig = real(sig);
% %     p=audioplayer(sig,fs); playblocking(p);
%     
%     spec = stft(sig, w, h, nfft, fs);
%     spec_abs = abs(spec);
% %     spec_angle = angle(spec);
% %     spec_ = complex(spec_abs.*cos(spec_angle), spec_abs.*sin(spec_angle));
% %     sig_ = istft(spec_, h, nfft, fs);
%     
% %     specd = fft(sig,fs);
% %     specd = abs(specd(1:end/2));
% %     x=linspace(0,fs/2,length(specd));
% %     plot(x,specd);
% %     axis([0,2000,0,max(specd)]);
%     
% %     for k = 1:size(spec_abs,2)
% %         plot(spec_abs(:,k));
% %         drawnow;
% %         axis([0, 2000,0, max(spec_abs(:,k))]);
% %     end
%     
%     W_single = betaNTF(spec_abs, k,'beta', beta, 'nIter', nIter);
%     W = [W, W_single];
% end
% save W_3.mat W

%%
load  W_3.mat

[sig, fs] = audioread('song4.mp3');
sig = sig(:,1);
spec = stft(sig, w, h, nfft, fs);
spec_abs = abs(spec);
spec_angle = angle(spec);
[~, H_test] = betaNTF(spec_abs, rangen*k, 'fixedW', 1, 'W', W,'beta', beta, 'nIter', 30);
H_test = H_test';
for i = 1:size(H_test,2)
    H_this = H_test(:,i);
    [~,idx] = sort(H_this);
    H_this(idx(1:end-10)) = 0;
    H_test(:,i) = H_this;
end

spec_abs_ = W * H_test;

spec_ = complex(spec_abs_.*cos(spec_angle), spec_abs_.*sin(spec_angle));

sig_ = istft(spec_, h, nfft, fs);
p=audioplayer(sig_, fs); playblocking(p);