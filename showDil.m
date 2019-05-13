function Img = showDil(qq,I,candidate)
n = length(candidate);
Img = I;
    for c = 1 : n
        for i = 1:qq(candidate(c)).Area
            PL = qq(candidate(c)).PixelList;
            Img(PL(i,2),PL(i,1)) = 1;
        end
    end
end