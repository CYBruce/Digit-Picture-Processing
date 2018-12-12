function varargout = devide(varargin)
% DEVIDE MATLAB code for devide.fig
%      DEVIDE, by itself, creates a new DEVIDE or raises the existing
%      singleton*.
%
%      H = DEVIDE returns the handle to a new DEVIDE or the handle to
%      the existing singleton*.
%
%      DEVIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEVIDE.M with the given input arguments.
%
%      DEVIDE('Property','Value',...) creates a new DEVIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before devide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to devide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help devide

% Last Modified by GUIDE v2.5 09-Jun-2018 15:33:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @devide_OpeningFcn, ...
                   'gui_OutputFcn',  @devide_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before devide is made visible.
function devide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to devide (see VARARGIN)

% Choose default command line output for devide
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes1)
global img_src1
imshow(img_src1)
% UIWAIT makes devide wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = devide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global devide
global img_src1
global m_handles
img_src1 = devide
axes(m_handles.axes1)
imshow(devide)
close(handles.figure1)



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1
global devide
[height,length]=size(img_src1);  
totalNum=height*length;  %���ȷ���ָ���ֵ
pixelCount=zeros(1,256);%ͳ�Ƹ�������ֵ�ĸ���  
for i=1:length  
    for j=1:height  
        number=img_src1(j,i)+1;  %����ֵΪ0~255,����Ϊ1~256
        pixelCount(number)=pixelCount(number)+1;  
    end  
end  
pf=pixelCount/totalNum;  %pfΪ��ռ����
deltaMax=0;  
a=1:256;  
maxmax=max(max(img_src1));  %���ĻҶ�ֵ
for i=1:maxmax  
      
    w1=sum(pf(1:i));  
    w2=1-w1;  
    mean1=sum(pf(1:i).*a(1:i))/sum(pf(1:i));  
    mean2=sum(pf(i+1:maxmax).*a(i+1:maxmax))/sum(pf(i+1:maxmax));  
    mean=w1*mean1+w2*mean2;
    delta=w1*(mean1-mean)^2+w2*(mean2-mean)^2;  %���������䷽��
    if delta>deltaMax  
        deltaMax=delta;  
        threshold=i;  
    end    
end  
imageout=img_src1>=threshold
devide = 255*imageout
axes(handles.axes2)
imshow(devide)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1
global devide
b=double(img_src1);                   
maxmax=double(max(max(img_src1))) % ���ͼ�������ĻҶ� 
minmin=double(min(min(img_src1))) % ��С�ĻҶ�  
T=double((maxmax+minmin))/2;     % T����ֵ��Ϊ���ֵ����Сֵ��ƽ��ֵ 
[height,length]=size(img_src1);           
count=double(0);   % ��¼����ѭ�� 
while 1    % ���������ֵ�ָ��㷨 
    count=count+1; 
    S0=0.0; n0=0.0;                   %Ϊ����Ҷȴ�����ֵ��Ԫ�صĻҶ���ֵ��������ֵ 
    S1=0.0; n1=0.0;                   %Ϊ����Ҷ�С����ֵ��Ԫ�صĻҶ���ֵ��������ֵ 
    for i=1:height
        for j=1:length
            if double(img_src1(i,j))>=T
                S1=S1+double(img_src1(i,j));  %��������ֵͼ���Ҷ�ֵ�ۼ�
                n1=n1+1;                %��������ֵͼ�������ۼ�
            else 
                S0=S0+double(img_src1(i,j));  %С������ֵͼ���Ҷ�ֵ�ۼ�
                n0=n0+1;                %С�ڷ���ֵͼ�������ۼ�
            end 
        end 
    end  
    T0=S0/n0; %��С�ڷ���ֵ��ֵ
    T1=S1/n1; %����ڷ���ֵ��ֵ
    if abs(T-((T0+T1)/2))<0.1     %������ ǰ�����η���ֵ����Ϊ0ʱ ֹͣ������
        break;
    else
       T=(T0+T1)/2;                 %����ֵT�£�������ֵ�ļ������ 
   end 
end 
imageout=img_src1>=T
devide = 255*imageout
axes(handles.axes2)
imshow(devide)