clear;clc;
Fs = 65536;                    %# sampling frequency in Hz
T = 1;                         %# length of one interval signal in sec
t = 0:1/Fs:T-1/Fs;             %# time vector
nfft = 2^nextpow2(Fs);         %# n-point DFT
numUniq = ceil((nfft+1)/2);    %# half point
f = (0:numUniq-1)'*Fs/nfft;    %'# frequency vector (one sided)
dense = 1;
%%
sigwhole = [];
fftMagwhole = [];
pitchseq = [261,293,329,349,392,440];
num = 6;
for n = 1:num
    pitch = pitchseq(n);
    dur = 0.3;
    N = round(dur * Fs) * dense;
    time = (0:N-1) / Fs;
    maxe = 100;
    volumn = 100;
    a = 100;
    b = 100;
    range = 3000;
    sampnum = 1000;
    exponential = 1;
    sig = zeros(1,N);
    pitch_ = pitch;
    
    for i = 1 : sampnum
        sig = sig + (maxe * cos(2*pi*pitch_*time) / ( ( ( abs ( pitch_ - pitch ) ^ exponential ) * a + b )));
        pitch_ = rand * range;
    end 
    sig = sig / norm(sig, 2) * volumn;   
    % sig = sig';
    % adding harmonic 
    harmonicnum = 5;
    harmonicexponential = 2;
    factor_second = 1;
    factor_third = 1;
    factor_fourth = 1;
    for i = 1 : harmonicnum
       pitch_ = pitch * i
       % sig = sig + (maxe * cos(2*pi*pitch_*time) / ( ( ( abs ( pitch_ - pitch ) ^ harmonicexponential ) * a + b )));
      sig = sig + (0.5 * cos(2 * pi * pitch * time)); 
    end
    sig = sig';
    sig = sig .* hanning(length(sig));

   
    fftMag = 10*log10( abs(fft(sig,nfft)));
    [maxmag,fundfreq] = max(fftMag);
    
    
    
    sigwhole(:,n) = sig;
    fftMagwhole(:,n) = fftMag(1:numUniq);
end
sigcon = [];
for n = 1:num
    sig = sigwhole(:,n);
    sigcon = [sigcon;sig];
    fftMag = fftMagwhole(:,n);
    figure(2);
    plot(f, fftMag(1:numUniq));
    axis([0,4000,0,100]);
    drawnow;
    p=audioplayer(sig .* hanning(length(sig)), Fs); playblocking(p);
end
% p=audioplayer(sigcon, Fs); playblocking(p);