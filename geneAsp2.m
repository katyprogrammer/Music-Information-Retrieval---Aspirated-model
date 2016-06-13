function sig = geneAsp2(pitch,dur,volumn)
    close all;clc;
    Fs = 65536;
    N = round(dur * Fs);
    time = (0:N-1) / Fs;

    sig =volumn * cos(2*pi*pitch*time);
    
%     w = 1024;
%     h = w/8;
%     nfft = w;
%     spec = stft(sig, w, h, nfft, Fs);
    
    spec = fft(sig,Fs);
    spec = spec(1:end/2);
    spec_abs = abs(spec);
    spec_angle = angle(spec);
    x=linspace(0,Fs/2,length(spec));
    [pitchval, pitchidx] = max(spec_abs);
    
    a = 100;
    b = 1000;
    d = 10;
    e = 1;
    sampnum = length(spec)/d;
    for i = 1:sampnum
        p = round(rand * (length(spec)-1))+1;
        if pitchidx ~= p
            spec_abs(p) = pitchval * b / ( ( abs ( x(p) - pitch ) ^ e ) * a + b );
        end
    end
    
    plot(x,spec_abs);
    axis([0, 2000,0, pitchval]);

    spec_ = complex(spec_abs.*cos(spec_angle), spec_abs.*sin(spec_angle));
    sig = ifft(spec_,Fs);
    sig = sig .* hanning(length(sig))';
  
end