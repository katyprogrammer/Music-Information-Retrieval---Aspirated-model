function freq = midi2freq(midi)
    freq = 2.^((midi - 69)/12).*440;
end