%������˹��ͨ�˲�
[M,N]=size(img)
n1=floor(M/2)
n2=floor(N/2)
%d0 = 5,15,45,65
d0=5
for i=1:M
    for j=1:N
        d=sqrt((i-n1)^2+(j-n2)^2);
        h=1/(1/(d/d0)^(2*n))
        g(i,j)=h*g(i,j)
    end
end
figure;  
subplot(221);  
imshow(img);title('ԭͼ��')  
subplot(222);  
imshow(uint8(real(ifft2(ifftshift(g)))));title('�˲����ͼ��')  
subplot(223);  
imshow(log(angle(F)*180/pi),[]);title('ԭͼ����') 
subplot(224);  
imshow(log(angle(f)*180/pi),[]);title('�˲�������') 

%gauss��ͨ�˲�
[M,N]=size(img)
n1=floor(M/2)
n2=floor(N/2)
%d0 = 5,15,45,65
d0=5
for i=1:M
    for j=1:N
        d=sqrt((i-n1)^2+(j-n2)^2);
        h=exp(-d^2/2/d0^2)
        g(i,j)=h*g(i,j)
    end
end
figure;  
subplot(221);  
imshow(img);title('ԭͼ��')  
subplot(222);  
imshow(uint8(real(ifft2(ifftshift(g)))));title('�˲����ͼ��')  
subplot(223);  
imshow(log(angle(F)*180/pi),[]);title('ԭͼ����') 
subplot(224);  
imshow(log(angle(f)*180/pi),[]);title('�˲�������') 