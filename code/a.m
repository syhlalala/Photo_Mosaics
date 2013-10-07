function varargout = a(varargin)
% A M-file for a.fig
%      A, by itself, creates a new A or raises the existing
%      singleton*.
%
%      H = A returns the handle to a new A or the handle to
%      the existing singleton*.
%
%      A('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in A.M with the given input arguments.
%
%      A('Property','Value',...) creates a new A or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before a_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to a_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help a

% Last Modified by GUIDE v2.5 02-May-2013 15:26:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @a_OpeningFcn, ...
                   'gui_OutputFcn',  @a_OutputFcn, ...
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


% --- Executes just before a is made visible.
function a_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to a (see VARARGIN)

% Choose default command line output for a
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes a wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global recommend
axes(handles.axes1);
im=imread('qiubi.jpg');
imshow(im);
axes(handles.axes2);
im=imread('welcome.jpg');
imshow(im);
recommend = [858 751 878 1182 704 753 587 646 659];


% --- Outputs from this function are returned to the command line.
function varargout = a_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global partition
global width
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val=get(hObject,'Value');
partition=floor(val*width);
set(handles.text1,'String',['blending at ' int2str(partition)]);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global im1
global im2
global recommend
pic = get(hObject,'value');
if (pic == 1)
    im1 = imread('data/g1/2.png');
    im2 = imread('data/g1/3.png');
end
if (pic == 2)
    im1 = imread('data/g1/3.png');
    im2 = imread('data/g1/4.png');
end
if (pic == 3)
    im1 = imread('data/g1/4.png');
    im2 = imread('data/g1/5.png');
end
if (pic == 4)
    im1 = imread('data/g1/5.png');
    im2 = imread('data/g1/6.png');
end
if (pic == 5)
    im1 = imread('data/g5/a1.jpg');
    im2 = imread('data/g5/a3.jpg');
end
if (pic == 6)
    im1 = imread('data/g2/01.jpg');
    im2 = imread('data/g2/02.jpg');
end
if (pic == 7)
    im1 = imread('data/g2/02.jpg');
    im2 = imread('data/g2/03.jpg');
end
if (pic == 8)
    im1 = imread('data/g3/12.jpg');
    im2 = imread('data/g3/13.jpg');
end
if (pic == 9)
    im1 = imread('data/g4/21.jpg');
    im2 = imread('data/g4/22.jpg');
end
axes(handles.axes1);
imshow(im1);
axes(handles.axes2);
imshow(im2);
%recommend = [604 623 623 906 704];
st = ['Recommend: ' int2str(recommend(pic))];
set(handles.text3,'String',st);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im1
global im2
global height
global width
global cut
global sx
global sy
global r
warning off all
set(handles.text2, 'String', 'Extracting image 1...');
p1 = extract(im1, 100);
set(handles.text2, 'String', 'Extracting image 2...');
p2 = extract(im2, 100);
set(handles.text2, 'String', 'Getting homography...');
[sx sy] = main(im1,im2,p1,p2,'ou1.png','ou2.png',1);
set(handles.text2, 'String', 'Done!');
ima1 = imread('ou1.png');
ima2 = imread('ou2.png');
[h w tmp] = size(ima1);
height = h;
width = w;
r = w;
axes(handles.axes1);
imshow(ima1);
axes(handles.axes2);
imshow(ima2);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global partition
global height
global width
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text2, 'String', 'Blending...');
blending('ou1.png', 'ou2.png', partition, 'result.jpg');
set(handles.text2, 'String', 'Done!');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (get(handles.radiobutton1,'value'))
    dotheater
end
if (get(handles.radiobutton2,'value'))
    docampus
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sx
global sy
global r
global width
imres = imread('result.jpg');
[h w tmp] = size(imres);
r = sqrt((1.25*width)^2+w^2/4);
%r = round(w*0.8);
tocylin('result.jpg',r,0,sy+round(w/2));
