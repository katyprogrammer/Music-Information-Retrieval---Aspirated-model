function sig = geneAsp(pitch,dur,volumn)
    
    Fs = 65536;                    %# sampling frequency in Hz
    % Fs = 181120;
    dense = 1;
    % T = dur;                       %# length of one interval signal in sec
    % t = 0:1/Fs:T-1/Fs;             %# time vector
    % nfft = 2^nextpow2(Fs);         %# n-point DFT
    % numUniq = ceil((nfft+1)/2);    %# half point
    % f = (0:numUniq-1)'*Fs/nfft;    %'# frequency vector (one sided)

    N = round(dur * Fs) * dense;
    time = (0:N-1) / Fs;

    a = 100;
    b = 100;
    range = 3000;
    sampnum = 1000;
    exponential = 1;
    
    sig = zeros(1,N);
    sig = sig + volumn * cos(2*pi*pitch*time);
    pitch_ = 1;
    for i = 1 : sampnum
        sig = sig + (volumn * cos(2*pi*pitch_*time) * b / ( ( ( abs ( pitch_ - pitch ) ^ exponential ) * a + b )));
        pitch_ = pitch_ + rand*range/sampnum*2;
    end 

    sig = sig';
    sig = sig .* hanning(length(sig)) .* hanning(length(sig));
    filename = 'geneAsp.wav';
    audiowrite(filename,sig,Fs);  
    size(audioread(filename))
    p=audioplayer(sig, Fs); playblocking(p);
end