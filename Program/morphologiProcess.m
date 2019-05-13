function R=morphologiProcess(Ig,strelShape,strelSize,th,enhancemode)
%Morphologi terdiri dari Eroding, Dilation dengan strelShape dan strelSize
Ie=enhance(Ig,enhancemode);
% Ie = Ig;
[baris kolom] = size(Ie);
It=im2bw(Ie,th);
SE = strel(strelShape, strelSize);
Ier=imerode(It,SE);
Idil=imdilate(Ier,SE);
R=Ig*0;
% for i=1:baris
%     for j=1:kolom
%         if Idil(i,j)==0
%             R(i,j)=Ig(i,j);
%         else
%             R(i,j)=0;
%         end
%     end
% end
R = Idil;
end

