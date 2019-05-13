function R=morphProcess(Ig,strelShape,strelSize)
%Morphologi terdiri dari Eroding, Dilation dengan strelShape dan strelSize
%Input Gambar (Ig) merupakan Binary
%Output R merupakan hasil Morphologi
[baris kolom] = size(Ig);
SE = strel(strelShape, strelSize);
Ier=imerode(Ig,SE);
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

