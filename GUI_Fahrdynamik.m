function varargout = GUI_Fahrdynamik(varargin)
% GUI_FAHRDYNAMIK MATLAB code for GUI_Fahrdynamik.fig
%      GUI_FAHRDYNAMIK, by itself, creates a new GUI_FAHRDYNAMIK or raises the existing
%      singleton*.
%
%      H = GUI_FAHRDYNAMIK returns the handle to a new GUI_FAHRDYNAMIK or the handle to
%      the existing singleton*.
%
%      GUI_FAHRDYNAMIK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_FAHRDYNAMIK.M with the given input arguments.
%
%      GUI_FAHRDYNAMIK('Property','Value',...) creates a new GUI_FAHRDYNAMIK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Fahrdynamik_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Fahrdynamik_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Fahrdynamik

% Last Modified by GUIDE v2.5 12-May-2019 10:02:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Fahrdynamik_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Fahrdynamik_OutputFcn, ...
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


% --- Executes just before GUI_Fahrdynamik is made visible.
function GUI_Fahrdynamik_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Fahrdynamik (see VARARGIN)

% Choose default command line output for GUI_Fahrdynamik
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% a = str2double(get(handles.beschleunigung, 'String'));
% assignin('base','a',a);

x0 = str2double(get(handles.x0, 'String')); 
assignin('base','x0', x0);

dt = 0.001;

A = [1;0];
Ad = eye(2) + A * dt;
assignin('base','A',A);
assignin('base','Ad',Ad);
Bd = [dt^2/2;dt];
assignin('base','Bd',Bd);
C = eye(2);
assignin('base','C',C);
D = [0;0];
assignin('base','D',D);

m = str2double(get(handles.m, 'String')); 
assignin('base','m',m);

theta = str2double(get(handles.theta, 'String')); 
assignin('base','theta',theta);

Cv = str2double(get(handles.Cv, 'String')); 
assignin('base','Cv',Cv);

Ch = str2double(get(handles.Ch, 'String')); 
assignin('base','Ch',Ch);

h = str2double(get(handles.h, 'String')); 
assignin('base','h',h);

SG = str2double(get(handles.SG, 'String')); 
assignin('base','SG',SG);

EG = str2double(get(handles.EG, 'String')); 
assignin('base','EG',EG);

l = str2double(get(handles.l, 'String')); 
assignin('base','l',l);

lv = str2double(get(handles.lv, 'String')); 
assignin('base','lv',lv);

psi = lv/l;
assignin('base','psi',psi);
chi = h/l;
assignin('base','chi',chi);

z_top =(psi/chi);
assignin('base','z_top',z_top);
z_bottom = (-((1-psi)/chi));
assignin('base','z_bottom',z_bottom);

z = z_bottom:0.1:z_top;
assignin('base','z',z);
FBv = (z.*(1-psi+z.*chi));
assignin('base','FBv',FBv);
FBh = (z.*(psi-z.*chi));
assignin('base','FBh',FBh);

acc_brakes = [ 0 0 0 1 8 8];
assignin('base','acc_brakes',acc_brakes);
acc_breakpoints = 0:1:5;
assignin('base','acc_breakpoints',acc_breakpoints);

cla(handles.plot1)
cla(handles.plot2)
cla(handles.plot3)
cla(handles.plot4)
cla(handles.plot5)
cla(handles.plot6)
cla(handles.plot7)

% UIWAIT makes GUI_Fahrdynamik wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Fahrdynamik_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function beschleunigung_Callback(hObject, eventdata, handles)
% hObject    handle to beschleunigung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beschleunigung as text
%        str2double(get(hObject,'String')) returns contents of beschleunigung as a double


% --- Executes during object creation, after setting all properties.
function beschleunigung_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beschleunigung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function x0_Callback(hObject, eventdata, handles)
% hObject    handle to x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x0 as text
%        str2double(get(hObject,'String')) returns contents of x0 as a double


% --- Executes during object creation, after setting all properties.
function x0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dt_Callback(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dt as text
%        str2double(get(hObject,'String')) returns contents of dt as a double


% --- Executes during object creation, after setting all properties.
function dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m_Callback(hObject, eventdata, handles)
% hObject    handle to m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m as text
%        str2double(get(hObject,'String')) returns contents of m as a double


% --- Executes during object creation, after setting all properties.
function m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_Callback(hObject, eventdata, handles)
% hObject    handle to theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta as text
%        str2double(get(hObject,'String')) returns contents of theta as a double


% --- Executes during object creation, after setting all properties.
function theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Cv_Callback(hObject, eventdata, handles)
% hObject    handle to Cv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cv as text
%        str2double(get(hObject,'String')) returns contents of Cv as a double


% --- Executes during object creation, after setting all properties.
function Cv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch_Callback(hObject, eventdata, handles)
% hObject    handle to Ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch as text
%        str2double(get(hObject,'String')) returns contents of Ch as a double


% --- Executes during object creation, after setting all properties.
function Ch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_Callback(hObject, eventdata, handles)
% hObject    handle to h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h as text
%        str2double(get(hObject,'String')) returns contents of h as a double


% --- Executes during object creation, after setting all properties.
function h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function l_Callback(hObject, eventdata, handles)
% hObject    handle to l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of l as text
%        str2double(get(hObject,'String')) returns contents of l as a double


% --- Executes during object creation, after setting all properties.
function l_CreateFcn(hObject, eventdata, handles)
% hObject    handle to l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lv_Callback(hObject, eventdata, handles)
% hObject    handle to lv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lv as text
%        str2double(get(hObject,'String')) returns contents of lv as a double


% --- Executes during object creation, after setting all properties.
function lv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in tab_ld.
function tab_ld_Callback(hObject, eventdata, handles)
% hObject    handle to tab_ld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.panel_kreis, 'visible', 'off')
set(handles.panel_gr, 'visible', 'off')
set(handles.panel_param, 'visible', 'off')


% --- Executes on button press in tab_kf.
function tab_kf_Callback(hObject, eventdata, handles)
% hObject    handle to tab_kf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_kreis, 'visible', 'on')
set(handles.panel_gr, 'visible', 'off')
set(handles.panel_param, 'visible', 'off')




% --- Executes on button press in tab_gr.
function tab_gr_Callback(hObject, eventdata, handles)
% hObject    handle to tab_gr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_kreis, 'visible', 'on')
set(handles.panel_gr, 'visible', 'on')
set(handles.panel_param, 'visible', 'off')




function kf_geschw_Callback(hObject, eventdata, handles)
% hObject    handle to kf_geschw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kf_geschw as text
%        str2double(get(hObject,'String')) returns contents of kf_geschw as a double


% --- Executes during object creation, after setting all properties.
function kf_geschw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kf_geschw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kf_radius_Callback(hObject, eventdata, handles)
% hObject    handle to kf_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kf_radius as text
%        str2double(get(hObject,'String')) returns contents of kf_radius as a double


% --- Executes during object creation, after setting all properties.
function kf_radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kf_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in tab_fzgparam.
function tab_fzgparam_Callback(hObject, eventdata, handles)
% hObject    handle to tab_fzgparam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_kreis, 'visible', 'on')
set(handles.panel_gr, 'visible', 'on')
set(handles.panel_param, 'visible', 'on')


% --- Executes on button press in btn_fzgparam.
function btn_fzgparam_Callback(hObject, eventdata, handles)
% hObject    handle to btn_fzgparam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.btn_fzgparam,'Enable','off')
set(handles.btn_gr_start,'Enable','off')
set(handles.btn_start_geschw,'Enable','off')
set(handles.btn_start_radius,'Enable','off')
set(handles.btn_Laengsd,'Enable','off')



x0 = str2double(get(handles.x0, 'String')); 
assignin('base','x0', x0);

dt = 0.001;

A = [1;0];
Ad = eye(2) + A * dt;
assignin('base','A',A);
assignin('base','Ad',Ad);
Bd = [dt^2/2;dt];
assignin('base','Bd',Bd);
C = eye(2);
assignin('base','C',C);
D = [0;0];
assignin('base','D',D);

m = str2double(get(handles.m, 'String')); 
assignin('base','m',m);

theta = str2double(get(handles.theta, 'String')); 
assignin('base','theta',theta);

Cv = str2double(get(handles.Cv, 'String')); 
assignin('base','Cv',Cv);

Ch = str2double(get(handles.Ch, 'String')); 
assignin('base','Ch',Ch);

h = str2double(get(handles.h, 'String')); 
assignin('base','h',h);

SG = str2double(get(handles.SG, 'String')); 
assignin('base','SG',SG);

EG = str2double(get(handles.EG, 'String')); 
assignin('base','EG',EG);

l = str2double(get(handles.l, 'String')); 
assignin('base','l',l);

lv = str2double(get(handles.lv, 'String')); 
assignin('base','lv',lv);

psi = lv/l;
assignin('base','psi',psi);
chi = h/l;
assignin('base','chi',chi);

z_top =(psi/chi);
assignin('base','z_top',z_top);
z_bottom = (-((1-psi)/chi));
assignin('base','z_bottom',z_bottom);

z = z_bottom:0.1:z_top;
assignin('base','z',z);
FBv = (z.*(1-psi+z.*chi));
assignin('base','FBv',FBv);
FBh = (z.*(psi-z.*chi));
assignin('base','FBh',FBh);

acc_brakes = [ 0 0 0 1 8 8];
assignin('base','acc_brakes',acc_brakes);
acc_breakpoints = 0:1:5;
assignin('base','acc_breakpoints',acc_breakpoints);

set(handles.btn_fzgparam,'Enable','on')
set(handles.btn_gr_start,'Enable','on')
set(handles.btn_start_geschw,'Enable','on')
set(handles.btn_start_radius,'Enable','on')
set(handles.btn_Laengsd,'Enable','on')


% --- Executes on button press in btn_Laengsd.
function btn_Laengsd_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Laengsd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.btn_fzgparam,'Enable','off')
set(handles.btn_gr_start,'Enable','off')
set(handles.btn_start_geschw,'Enable','off')
set(handles.btn_start_radius,'Enable','off')
set(handles.btn_Laengsd,'Enable','off')

cla(handles.plot1)
cla(handles.plot2)
cla(handles.plot3)
cla(handles.plot4)

x0 = str2double(get(handles.x0, 'String')); 
assignin('base','x0', x0);

axes(handles.plot1);
axes(handles.plot2);
axes(handles.plot3);
axes(handles.plot4);
runLaengsdynamik(handles.plot2,handles.plot3,handles.plot4,handles.plot1);

set(handles.btn_fzgparam,'Enable','on')
set(handles.btn_gr_start,'Enable','on')
set(handles.btn_start_radius,'Enable','on')
set(handles.btn_start_geschw,'Enable','on')
set(handles.btn_Laengsd,'Enable','on')


% --- Executes on button press in btn_gr_start.
function btn_gr_start_Callback(hObject, eventdata, handles)
% hObject    handle to btn_gr_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.btn_fzgparam,'Enable','off')
set(handles.btn_gr_start,'Enable','off')
set(handles.btn_start_geschw,'Enable','off')
set(handles.btn_start_radius,'Enable','off')
set(handles.btn_Laengsd,'Enable','off')

cla(handles.plot7)

axes(handles.plot7);

%EG = 0.0058;
%SG = 0.0049;

m = evalin('base', 'm');
theta = evalin('base', 'theta');
lv = evalin('base', 'lv');
l = evalin('base', 'l');
lh = l-lv;
EG = evalin('base', 'EG');
SG = evalin('base', 'SG');

Plot_4_8(handles.plot7,9.81, lv, lh, EG, SG, 16, m, theta)

set(handles.btn_fzgparam,'Enable','on')
set(handles.btn_gr_start,'Enable','on')
set(handles.btn_start_geschw,'Enable','on')
set(handles.btn_start_radius,'Enable','on')
set(handles.btn_Laengsd,'Enable','on')


% --- Executes on button press in btn_start_geschw.
function btn_start_geschw_Callback(hObject, eventdata, handles)
% hObject    handle to btn_start_geschw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.btn_fzgparam,'Enable','off')
set(handles.btn_gr_start,'Enable','off')
set(handles.btn_start_geschw,'Enable','off')
set(handles.btn_start_radius,'Enable','off')
set(handles.btn_Laengsd,'Enable','off')

v2 = str2double(get(handles.kf_geschw, 'String')); 
assignin('base','v2', v2);
 
axes(handles.plot5);
radius = str2double(get(handles.kf_radius, 'String')); 
assignin('base','radius', radius);
%EG = 0.0058;
%SG = 0.0049;
 
m = evalin('base', 'm');
theta = evalin('base', 'theta');
lv = evalin('base', 'lv');
l = evalin('base', 'l');
lh = l-lv;
EG = evalin('base', 'EG');
SG = evalin('base', 'SG');

Plot_4_6(handles.plot5,'Plot_4_6_1', v2, 9.81, lv, lh, EG, SG, 16, m, theta)


set(handles.btn_fzgparam,'Enable','on')
set(handles.btn_gr_start,'Enable','on')
set(handles.btn_start_geschw,'Enable','on')
set(handles.btn_start_radius,'Enable','on')
set(handles.btn_Laengsd,'Enable','on')


% --- Executes on button press in btn_start_radius.
function btn_start_radius_Callback(hObject, eventdata, handles)
% hObject    handle to btn_start_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.btn_fzgparam,'Enable','off')
set(handles.btn_gr_start,'Enable','off')
set(handles.btn_start_geschw,'Enable','off')
set(handles.btn_start_radius,'Enable','off')
set(handles.btn_Laengsd,'Enable','off')

cla(handles.plot6)

radius = str2double(get(handles.kf_radius, 'String')); 
assignin('base','radius', radius);
%EG = 0.0058;
%SG = 0.0049;

m = evalin('base', 'm');
theta = evalin('base', 'theta');
lv = evalin('base', 'lv');
l = evalin('base', 'l');
lh = l-lv;

EG = evalin('base', 'EG');
SG = evalin('base', 'SG');

axes(handles.plot6);
Plot_4_6(handles.plot6, 'Plot_4_6_2',radius, 9.81, lv, lh, EG, SG, 16, m, theta)


set(handles.btn_fzgparam,'Enable','on')
set(handles.btn_gr_start,'Enable','on')
set(handles.btn_start_geschw,'Enable','on')
set(handles.btn_start_radius,'Enable','on')
set(handles.btn_Laengsd,'Enable','on')



function EG_Callback(hObject, eventdata, handles)
% hObject    handle to EG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EG as text
%        str2double(get(hObject,'String')) returns contents of EG as a double


% --- Executes during object creation, after setting all properties.
function EG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SG_Callback(hObject, eventdata, handles)
% hObject    handle to SG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SG as text
%        str2double(get(hObject,'String')) returns contents of SG as a double


% --- Executes during object creation, after setting all properties.
function SG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
