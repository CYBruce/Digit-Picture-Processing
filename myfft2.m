%快速傅里叶变换（FFT）
%input:m,p;y0,y1....y(2m-1)
function z=FFTmatlab(a)
N=length(a);N1=N;p=0
while p<=N
    p=p+1;r=N1/2;
    if r==1
        break
    end
    N1=r
end
w=exp(-i*2*pi/N);
for q=1:p
    n=2^q
    for k=0:N/n-1
        for j=0:n/2-1
            m=k*n
            b(m+j+1)=a(m/2+j+1)+a(m/2+j+1+N/2)
            b(m+j+1+n/2)=a(m/2+j+1)-a(m/2+j+1+N/2)*w^(m/2)
        end
    end
    a=b
end
z=a