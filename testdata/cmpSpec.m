function val = cmpSpec(specA, specB)
    [~,fundA] = max(specA)
    [~,fundB] = max(specB);
    lengtA = length(specA);
    lengtB = length(specB);
    exA = specA(fundA : fundA : lengtA);
    exB = specB(fundB : fundB : lengtB);
    edge = min([length(exA),length(exB)]);
    exA = exA(1:edge);
    exB = exB(1:edge);
%         exA = log(exA+1);exB = log(exB+1);
    exA = exA ./ exA(1);
    exB = exB ./ exB(1);
    subplot(3,1,1);
    plot(exA);
    subplot(3,1,2);
    plot(exB);
    subplot(3,1,3);
    plot(exA - exB);
    val = norm(exA - exB);
    
end