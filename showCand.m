function showCand(candidate,qq)
n = length(candidate);
figure;
    for c = 1 : n
        koor=qq(candidate(c)).Centroid;
        x = round(koor(1));
        y = round(koor(2));
        subplot(1,n,c)
        imshow(qq(candidate(c)).Image);
%             title(['region ke :',num2str(c)]);
        title(['region ke :',num2str(candidate(c)),' Centroid: ',num2str(x),' ',num2str(y)]);
        hold on
    end
hold off
end