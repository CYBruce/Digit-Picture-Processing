I=imread('baboon.bmp');%��ȡ�ļ�ͼƬ
subplot(131);
imshow(I);
title('ԭʼͼ��');
[M,N] = size(I);
F = zeros(M,N);
Wh = zeros(M,1);      
Wl = zeros(1,N);
expx = exp(-1i * 2 * pi/M); 
expy = exp(-1i * 2 * pi/N);
for x = 1:1:M                %Ԥ��������еĲ���Wm��������
    Wh(x,1)=expx^x;
end
for y = 1:1:N                %Ԥ��������еĲ���Wn��������
    Wl(1,y)=expy^y;
end

for u = 1:1:M               %��ά����Ҷ�任
    for v = 1:1:N
        fz = zeros(M,N);
        fz = Wh.^u * Wl.^v * double(I(u,v));
        F(u,v) = sum(sum(fz));
    end
end

FS = fftshift(F);%���任ͼ�����Ļ�
A = log(abs(FS));%����Ƶ��ͼ
B = (angle(FS)*180/pi);%��������ͼ
subplot(132);
imshow(A,[]);
title('Ƶ��ͼ');

subplot(133);
imshow(B,[])
title('��λͼ');