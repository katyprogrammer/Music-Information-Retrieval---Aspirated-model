%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             apply aspirated model to source          %
%             Music Information Final Project          %
%                                                      %
% Author: Katy Lee                         2016/06/15  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% follow geneAsp2.m


%[sig, fs] = audioread('audioclip.wav');
% p=audioplayer(sig, fs); playblocking(p);
fragmentsNum = 100;
fs = 65536;
% [wholeSig, fs] = audioread('audioclip.wav');
% p=audioplayer(sig, fs); playblocking(p);
%% import audio file of songs
PATH_SONG = './song'
listOfSongs = listfile(PATH_SONG)
song = [];
for i = 1:length(listOfSongs)
    % for audioIndex = 1:fragmentsNum
        s% ignal = wholeSig(audioIndex : audioIndex * round(( length(wholeSig) / fragmentsNum )));
        signal = wholeSig;
        w = 1024;
        h = w/8;
        nfft = w; % size of the fft
        spec = fft(signal, fs);
        % spec = stft(sig, w, h, nfft, fs);
        % generate aspirated model and add it on audio 

        size(geneAspSpectrogram(440, (size(signal) / 65536), 100))
        size(spec_abs)
        spec_abs = abs(spec);
        spec_abs = spec_abs + (geneAspSpectrogram(440, (size(signal) / 65536), 100))';
        spec_angle = angle(spec);
        x = linspace(0,fs/2,w/2+1);
        % reconstruct the audio through iSTFT
        spec_ = complex(spec_abs.*cos(spec_angle), spec_abs.*sin(spec_angle));
        sig_ = istft(spec_, h, nfft, fs);
        filename = 'combinedAspirated.wav';
        audiowrite(filename,sig_,fs);
        p = audioplayer(sig_, fs);
        playblocking(p);
        song = [song; sig_];
    % end
     
end
player = audioplayer(song, fs);
playblocking(p);


