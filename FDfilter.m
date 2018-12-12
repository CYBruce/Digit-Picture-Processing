function varargout = FDfilter(varargin)
% FDFILTER MATLAB code for FDfilter.fig
%      FDFILTER, by itself, creates a new FDFILTER or raises the existing
%      singleton*.
%
%      H = FDFILTER returns the handle to a new FDFILTER or the handle to
%      the existing singleton*.
%      FDFILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FDFILTER.M with the given input arguments.
%
%      FDFILTER('Property','Value',...) creates a new FDFILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FDfilter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FDfilter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FDfilter

% Last Modified by GUIDE v2.5 10-Jun-2018 11:10:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FDfilter_OpeningFcn, ...
                   'gui_OutputFcn',  @FDfilter_OutputFcn, ...
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


% --- Executes just before FDfilter is made visible.
function FDfilter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FDfilter (see VARARGIN)

% Choose default command line output for FDfilter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FDfilter wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global img_src1;
global S;  %�洢���
global lv; %����ѡ���ͨ
global hv; %����ѡ���ͨ
axes(handles.axes2)
imshow(img_src1)
Bmpfft = fft2(img_src1);%��ԭͼ���ж�ά����Ҷ�任����д�������й�����
S = fftshift(Bmpfft);%���任ͼ�����Ļ�
axes(handles.axes1)
imshow(log(abs(S)),[])
lv=0;
hv=0;



% --- Outputs from this function are returned to the command line.
function varargout = FDfilter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function h_filter_Callback(hObject, eventdata, handles)
% hObject    handle to h_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global lv;
global hv;
lv = 0;
hv = 1;%���ø�ͨ

% --------------------------------------------------------------------
function l_filter_Callback(hObject, eventdata, handles)
% hObject    handle to l_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global lv;
global hv;
lv = 1;%���õ�ͨ
hv = 0;

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
global lv;
global hv;
global ss;
if lv==0 && hv==0;
    sl = get(handles.slider1,'Value');%slΪ�뾶���ű���
    set(handles.edit1,'string',int2str(sl));
else
    s = S;
    sl = get(handles.slider1,'Value');%slΪ�뾶���ű���
    set(handles.edit1,'string',int2str(sl));
    [a,b] = size(s); %sΪ����Ҷ�任���Ƶ��
    a0 = round(a/2);
    b0 = round(b/2);
    d = sl; %�뾶
    for i = 1:a      
        for j = 1:b      
            distance=sqrt((i-a0)^2+(j-b0)^2);
            if distance <= d
                h = lv;
            else
                h = hv;
            end;      
            s(i,j) = h*s(i,j);
        end;
    end;
    axes(handles.axes1)
    imshow(log(abs(s)),[])
    ss = uint8(real(ifft2(ifftshift(s)))); %������Ҷ�任
    axes(handles.axes2)
    imshow(ss)
end


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
global lv;
global hv;
global ss;
%�ͻ���callback������ͬ
if lv==0 && hv==0;
    E = get(handles.edit1,'string');
    set(handles.slider1,'Value',str2num(E));%�ͻ���ͬ��
else
    s = S;
    E = get(handles.edit1,'string');
    set(handles.slider1,'Value',str2num(E));
    [a,b] = size(s); %sΪ����Ҷ�任���Ƶ��
    a0 = round(a/2);
    b0 = round(b/2);
    d = str2num(E); %�뾶
    for i = 1:a      
        for j = 1:b      
            distance=sqrt((i-a0)^2+(j-b0)^2);
            if distance <= d
                h = lv;
            else
                h = hv;
            end;      
            s(i,j) = h*s(i,j);
        end;
    end;
    axes(handles.axes1)
    imshow(log(abs(s)),[])
    ss = uint8(real(ifft2(ifftshift(s)))); 
    axes(handles.axes2)
    imshow(ss)
end

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ss
global img_src1
img_src1=ss
global m_handles
axes(m_handles.axes1)
imshow(ss)
close(handles.figure1)%���ȷ�Ϲرմ��ڲ�����ͼƬ������������
