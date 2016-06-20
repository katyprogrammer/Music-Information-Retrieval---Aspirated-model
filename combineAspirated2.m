%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             apply aspirated model to source          %
%             Music Information Final Project          %
%                                                      %
% Author: Katy Lee                         2016/06/15  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% follow geneAsp2.m
close all;clear;clc; 
fs = 65536;
%% import audio file of songs

PATH_SONG = './song'
listOfSongs = listfile(PATH_SONG);
song = [];
for i = 1:length(listOfSongs)-2
        
        [sig, fs] = audioread(listOfSongs{i});
        sig = sig(end/100*10:end/100*50,1);
        w = 1024;
        h = w/8;
        nfft = w;
        spec = stft(sig, w, h, nfft, fs);
      
        spec_abs = abs(spec);
        spec_angle = angle(spec);
        x = linspace(0,fs/2,w/2+1);
 
        spec_ = complex(spec_abs.*cos(spec_angle), spec_abs.*sin(spec_angle));
        sig_ = istft(spec_, h, nfft, fs);

        aspsig = geneAsp4(fs,523,length(sig)/fs,1000);
        for k = 1:size(spec_abs,2);
            energy = sum(spec_abs(:,k));
            aspsig((k-1)*h+1:(k-1)*h+w) = aspsig((k-1)*h+1:(k-1)*h+w) * (energy^1/300);
        end
        aspsig = aspsig(1:length(sig_));
        sig_ = sig_ + aspsig;
        
        filename = 'combinedAspirated.wav';
        audiowrite(filename,sig_,fs);
        p = audioplayer(sig_, fs);
        playblocking(p);
end


