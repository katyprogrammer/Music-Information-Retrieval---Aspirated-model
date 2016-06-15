%% under experiment 
function sig = geneAsp2(pitch,dur,volumn,template)
    close all;clc;
    Fs = 65536;
    a = 100;
    b = 100;
    d = 10;
    e = 0.5;

    sig = template;
    
%     N = round(dur * Fs);
%     time = (0:N-1) / Fs;
%     sig = sig + volumn * cos(2*pi*pitch*time);
    
    spec = fft(sig,Fs);
    spec = spec(1:end/2);
    spec_abs = abs(spec);
    spec_angle = angle(spec);
    x=linspace(0,Fs/2,length(spec));
    
    filter = volumn .* b ./ ( ( abs ( (1:Fs/2) - pitch ) .^ e ) .* a + b );
    spec_abs = spec_abs .* filter;
    spec_ = complex(spec_abs.*cos(spec_angle), spec_abs.*sin(spec_angle));
    sig_ = ifft(spec,Fs);
    sig = sig_;
%     sig = sig_ .* hanning(length(sig))';
    
%     plot(x,spec_abs);
%     axis([0, 2000,0, max(spec_abs)]);
    plot(sig);
end