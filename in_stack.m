function [ a ] = in_stack()
global my_stack
global my_pointer
global bottom
global img_src1
global m_handles
if bottom<3  %因为设置了堆栈的大小为3
    bottom=bottom+1 %堆栈的底端指针加一
end

my_stack(:,:,3)= my_stack(:,:,2)
my_stack(:,:,2)= my_stack(:,:,1)
my_stack(:,:,1)= img_src1 %一次往后退
set(m_handles.Return,'enable','on')

end
