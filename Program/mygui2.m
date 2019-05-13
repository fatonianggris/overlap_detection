function varargout = mygui2(varargin)
% MYGUI2 MATLAB code for mygui2.fig
%      MYGUI2, by itself, creates a new MYGUI2 or raises the existing
%      singleton*.
%
%      H = MYGUI2 returns the handle to a new MYGUI2 or the handle to
%      the existing singleton*.
%
%      MYGUI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYGUI2.M with the given input arguments.
%
%      MYGUI2('Property','Value',...) creates a new MYGUI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mygui2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mygui2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mygui2

% Last Modified by GUIDE v2.5 24-Apr-2019 14:45:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mygui2_OpeningFcn, ...
                   'gui_OutputFcn',  @mygui2_OutputFcn, ...
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


% --- Executes just before mygui2 is made visible.
function mygui2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mygui2 (see VARARGIN)
clc
set(handles.axes3,'XColor', 'none','YColor', 'none','Box','on');
title(handles.axes3,"Strel Size 3");
set(handles.axes4,'XColor', 'none','YColor', 'none','Box','on');
title(handles.axes4,"Strel Size 4");
set(handles.axes5,'XColor', 'none','YColor', 'none','Box','on');
title(handles.axes5,"Strel Size 5");
set(handles.axes6,'XColor', 'none','YColor', 'none','Box','on');
title(handles.axes6,"Strel Size 6");
set(handles.axes7,'XColor', 'none','YColor', 'none','Box','on');
title(handles.axes7,"Strel Size 7");

set(handles.axes11,'XColor', 'none','YColor', 'none','Box','on');
title(handles.axes11,"Enhance Result");
set(handles.axes12,'XColor', 'none','YColor', 'none','Box','on');
title(handles.axes12,"Segmented Result");
% Choose default command line output for mygui2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes mygui2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mygui2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbuttoninput.
function pushbuttoninput_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttoninput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename path]=uigetfile({'*.jpg';'*.bmp';'*.jpeg'},'Select the Image:');
axes1.visible='on';
axes2.visible='on';
Ig=imread(filename);
temp=size(Ig);
if length(temp) > 2
    Ig=rgb2gray(Ig);
else
    Ig=Ig;
end
handles.Ig=Ig;
guidata(hObject,handles);
axes(handles.axes1);
imshow(Ig);
axes(handles.axes2);
imhist(Ig);

%% Push Button Utama
% --- Executes on button press in pushbuttonprocess.
function pushbuttonprocess_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonprocess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectedobject = get(handles.pnlshape,'SelectedObject');
strelmode = selectedobject.String;
th = get(handles.cellthreshold,'String');
th = str2num(th);
selectedobject = get(handles.pnlenhance,'SelectedObject');
enhancemode = selectedobject.String;

Ig = handles.Ig;
% Bisa dirubah nanti pake enhance yang lain
Ie=adapthisteq(Ig);
It=im2bw(Ie,th);
axes(handles.axes11)
imshow(Ie);
axes(handles.axes12)
imshow(It);

axes(handles.axes3)
imshow(morphologiProcess(Ig, strelmode, 3, th, enhancemode));
title(handles.axes3,"Strel Size 3");
axes(handles.axes4)
imshow(morphologiProcess(Ig, strelmode, 4, th, enhancemode));
title(handles.axes4,"Strel Size 4");
axes(handles.axes5)
imshow(morphologiProcess(Ig, strelmode, 5, th, enhancemode));
title(handles.axes5,"Strel Size 5");
axes(handles.axes6)
imshow(morphologiProcess(Ig, strelmode, 6, th, enhancemode));
title(handles.axes6,"Strel Size 6");
axes(handles.axes7)
imshow(morphologiProcess(Ig, strelmode, 7, th,enhancemode));
title(handles.axes7,"Strel Size 7");
save('result.mat')





% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.tn=get(handles.slider1,'Value');
guidata(hObject,handles);
set(handles.cellthreshold,'string',num2str(handles.tn));
set(handles.cellthreshold256,'string',num2str(round(handles.tn * 256)));


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function cellthreshold_Callback(hObject, eventdata, handles)
% hObject    handle to cellthreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cellthreshold as text
%        str2double(get(hObject,'String')) returns contents of cellthreshold as a double
threshold=get(hObject,'string');
guidata(hObject,handles);
threshold=str2num(threshold);
set(handles.slider1,'Value',threshold);
set(handles.cellthreshold256,'string',num2str(round(threshold * 256)));


% --- Executes during object creation, after setting all properties.
function cellthreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cellthreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobuttondisk.
function radiobuttondisk_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttondisk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttondisk



function cellthreshold256_Callback(hObject, eventdata, handles)
% hObject    handle to cellthreshold256 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cellthreshold256 as text
%        str2double(get(hObject,'String')) returns contents of cellthreshold256 as a double
threshold=get(hObject,'string');
guidata(hObject,handles);
threshold=str2num(threshold);
set(handles.slider1,'Value',threshold/256);
set(handles.cellthreshold,'string',num2str(threshold/256));


% --- Executes during object creation, after setting all properties.
function cellthreshold256_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cellthreshold256 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
