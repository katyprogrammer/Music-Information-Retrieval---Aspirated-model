close all;clc;
% Fs = 65536;
% volumn = 10;
% dur = 1;
% N = round(dur * Fs);
% time = (0:N-1) / Fs;
% template = volumn * cos(2*pi*1*time) / (Fs/2);
% for i=2:Fs/2
%   template = template + volumn * cos(2*pi*i*time) / (Fs/2);
% end
% save template.mat template
%%
close all;clc;
Fs = 65536;
volumn = 100000;
notenum = 5;
midiseq = [67,65,64,62,60];
midiseq = midiseq(randperm(notenum))
durseq = [0.3,0.3,0.3,0.3,0.3];
% notenum = 24;
% midiseq = [67,64,64,65,62,62,60,62,64,65,67,67,67,67,64,64,65,62,62,60,64,67,67,60];
% durseq = [0.3,0.3,0.6,0.3,0.3,0.6,0.3,0.3,0.3,0.3,0.3,0.3,0.6,0.3,0.3,0.6,0.3,0.3,0.6,0.3,0.3,0.3,0.3,0.9];
% notenum = 1;
% midiseq = [60];
% durseq = [0.3];
freqseq = midi2freq(midiseq);

sig=[];
for i=1:notenum
    sig = [sig,geneAsp2(freqseq(i),durseq(i),volumn)];
end

p=audioplayer(sig, Fs); playblocking(p);
%%
% close all;clear;clc;
% Fs = 65536;
% dur = 1;
% N = round(dur * Fs);
% time = (0:N-1) / Fs;
% allsig = zeros(Fs/2,N);
% for i =1:Fs/2;
%     if(mod(i,100)==0)
%         i 
%     end
%     allsig(i,:) = cos(2*pi*i*time) / (Fs/2);
% end
% 
% spec = fft(sig,Fs);
% spec = spec(1:end/2);
% spec_abs = abs(spec);
% spec_angle = angle(spec);
% save sumallsig.mat sumallsig
%%
% load sumallsig
% Fs = 65536;
% volumn = 10;
% sig = geneAsp3(440,1,volumn,sumallsig);
% p=audioplayer(sig, Fs);
% playblocking(p);