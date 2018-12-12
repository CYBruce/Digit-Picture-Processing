I=imread('baboon.bmp');%读取文件图片
subplot(131);
imshow(I);
title('原始图像');
[M,N] = size(I);
F = zeros(M,N);
Wh = zeros(M,1);      
Wl = zeros(1,N);
expx = exp(-1i * 2 * pi/M); 
expy = exp(-1i * 2 * pi/N);
for x = 1:1:M                %预计算关于行的参数Wm的列向量
    Wh(x,1)=expx^x;
end
for y = 1:1:N                %预计算关于行的参数Wn的行向量
    Wl(1,y)=expy^y;
end

for u = 1:1:M               %二维傅里叶变换
    for v = 1:1:N
        fz = zeros(M,N);
        fz = Wh.^u * Wl.^v * double(I(u,v));
        F(u,v) = sum(sum(fz));
    end
end

FS = fftshift(F);%将变换图像中心化
A = log(abs(FS));%绘制频谱图
B = (angle(FS)*180/pi);%绘制相谱图
subplot(132);
imshow(A,[]);
title('频谱图');

subplot(133);
imshow(B,[])
title('相位图');