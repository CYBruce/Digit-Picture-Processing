function [ a ] = in_stack()
global my_stack
global my_pointer
global bottom
global img_src1
global m_handles
if bottom<3  %��Ϊ�����˶�ջ�Ĵ�СΪ3
    bottom=bottom+1 %��ջ�ĵ׶�ָ���һ
end

my_stack(:,:,3)= my_stack(:,:,2)
my_stack(:,:,2)= my_stack(:,:,1)
my_stack(:,:,1)= img_src1 %һ��������
set(m_handles.Return,'enable','on')

end
