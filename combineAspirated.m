%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             apply aspirated model to source          %
%             Music Information Final Project          %
%                                                      %
% Author: Katy Lee                         2016/06/15  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% follow geneAsp2.m
%% make a spectrogram, and do inverse fourier transform to get the audio file
function sig = geneAsp2(pitch,dur,volumn)
    Fs = 65536;
    N = round(dur * Fs);
    time = (0:N-1) / Fs;
    sig = cos(2*pi*pitch*time);
%     w = 1024;
%     h = w/8;
%     nfft = w;
%     spec = stft(sig, w, h, nfft, Fs);
    
    spec = fft(sig,Fs);
    spec = spec(1:end/2);
    spec_abs = abs(spec);
    spec_angle = angle(spec);
    x = linspace(0,Fs/2,length(spec));
    [pitchval, pitchidx] = max(spec_abs);
    
    spec_abs = zeros(1,length(spec_abs));
    a = 10;
    b = 100;
    d = 10;
    e = 2;
    sampnum = length(spec)/d;
    for i = 1:sampnum
        p = round(rand * (length(spec)-1))+1;
        if pitchidx ~= p
            spec_abs(p) = pitchval * b / ( ( abs ( x(p) - pitch ) ^ e ) * a + b );
%             spec_abs(p) = pitchval / 1000;
        end
    end
    norm(spec_abs)
    spec_abs = volumn * spec_abs / norm(spec_abs);
    spec_ = complex(spec_abs.*cos(spec_angle), spec_abs.*sin(spec_angle));
    sig_ = ifft(spec_abs,Fs);
    sig = sig_;
    
    l = round(length(sig)*((1-dur)/2)); r = round(length(sig)*((1-dur)/2+dur));
    sig = sig(l:r);
    sig = sig .* hanning(length(sig))';
    
    plot(x,spec_abs);
    axis([0, 2000,0, pitchval]);
    endz
