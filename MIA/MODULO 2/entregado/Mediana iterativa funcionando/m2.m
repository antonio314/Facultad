function varargout = m2(varargin)
% M2 MATLAB code for m2.fig
%      M2, by itself, creates a new M2 or raises the existing
%      singleton*.
%
%      H = M2 returns the handle to a new M2 or the handle to
%      the existing singleton*.
%
%      M2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in M2.M with the given input arguments.
%
%      M2('Property','Value',...) creates a new M2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before m2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to m2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help m2

% Last Modified by GUIDE v2.5 08-Dec-2013 16:24:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @m2_OpeningFcn, ...
                   'gui_OutputFcn',  @m2_OutputFcn, ...
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


% --- Executes just before m2 is made visible.
function m2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to m2 (see VARARGIN)

% Choose default command line output for m2
handles.output = hObject;


set(handles.a,'String','-5');
set(handles.b,'String','5');
set(handles.media,'String','0.0');
set(handles.varianza,'String','1.0');
set(handles.alfa,'String','0.1');
set(handles.sal,'String','5');
set(handles.pimienta,'String','5');

set(handles.mse,'String','0.0');
set(handles.snr,'String','0.0');

set(handles.tamfiltro,'String','3');
set(handles.isnr,'String','0.0');

set(handles.snr2,'String','0.0');
set(handles.mse2,'String','0.0');

set(handles.iteraciones,'String','10');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes m2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = m2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in abrir.
function abrir_Callback(hObject, eventdata, handles)
% hObject    handle to abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
axes(handles.axes1);
handles.img = imread(imgetfile());

tama = size(size(handles.img));
tam=size(handles.img);

if tama(2)==3
    handles.img = rgb2gray(handles.img);
end

imshow(handles.img);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in uniformeaditivo.
function uniformeaditivo_Callback(hObject, eventdata, handles)
% hObject    handle to uniformeaditivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of uniformeaditivo

set(handles.gaussianoaditivo,'Value',0);
set(handles.gaussianomultiplicativo,'Value',0);
set(handles.salpimienta,'Value',0);

% Update handles structure
guidata(hObject, handles);


function a_Callback(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a as text
%        str2double(get(hObject,'String')) returns contents of a as a double


% --- Executes during object creation, after setting all properties.
function a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_Callback(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b as text
%        str2double(get(hObject,'String')) returns contents of b as a double


% --- Executes during object creation, after setting all properties.
function b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gaussianoaditivo.
function gaussianoaditivo_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianoaditivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gaussianoaditivo

set(handles.uniformeaditivo,'Value',0);
set(handles.gaussianomultiplicativo,'Value',0);
set(handles.salpimienta,'Value',0);

% Update handles structure
guidata(hObject, handles);


function media_Callback(hObject, eventdata, handles)
% hObject    handle to media (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of media as text
%        str2double(get(hObject,'String')) returns contents of media as a double


% --- Executes during object creation, after setting all properties.
function media_CreateFcn(hObject, eventdata, handles)
% hObject    handle to media (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function varianza_Callback(hObject, eventdata, handles)
% hObject    handle to varianza (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of varianza as text
%        str2double(get(hObject,'String')) returns contents of varianza as a double


% --- Executes during object creation, after setting all properties.
function varianza_CreateFcn(hObject, eventdata, handles)
% hObject    handle to varianza (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gaussianomultiplicativo.
function gaussianomultiplicativo_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianomultiplicativo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gaussianomultiplicativo

set(handles.uniformeaditivo,'Value',0);
set(handles.gaussianoaditivo,'Value',0);
set(handles.salpimienta,'Value',0);


% Update handles structure
guidata(hObject, handles);


function alfa_Callback(hObject, eventdata, handles)
% hObject    handle to alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alfa as text
%        str2double(get(hObject,'String')) returns contents of alfa as a double


% --- Executes during object creation, after setting all properties.
function alfa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in salpimienta.
function salpimienta_Callback(hObject, eventdata, handles)
% hObject    handle to salpimienta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of salpimienta

set(handles.uniformeaditivo,'Value',0);
set(handles.uniformeaditivo,'Value',0);
set(handles.gaussianomultiplicativo,'Value',0);

% Update handles structure
guidata(hObject, handles);



function sal_Callback(hObject, eventdata, handles)
% hObject    handle to sal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sal as text
%        str2double(get(hObject,'String')) returns contents of sal as a double


% --- Executes during object creation, after setting all properties.
function sal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pimienta_Callback(hObject, eventdata, handles)
% hObject    handle to pimienta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pimienta as text
%        str2double(get(hObject,'String')) returns contents of pimienta as a double


% --- Executes during object creation, after setting all properties.
function pimienta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pimienta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in aplicarRuido.
function aplicarRuido_Callback(hObject, eventdata, handles)
% hObject    handle to aplicarRuido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(get(handles.uniformeaditivo,'Value')==1)

    a = double(str2num(get(handles.a,'String')));
    b = double(str2num(get(handles.b,'String')));
    
    im = handles.img;
    [tamx, tamy] = size(im);
    ruido = (abs(a)+abs(b))*rand(tamx,tamy)+a;
    im = double(im)+ruido;
    handles.imgconruido = uint8(im);
    axes(handles.axes2);
    imshow(handles.imgconruido);
    
    
elseif(get(handles.gaussianoaditivo,'Value')==1)

    varianza = double(str2num(get(handles.varianza,'String')));
    media = double(str2num(get(handles.media,'String')));
    
    im = handles.img;
    [tamx, tamy] = size(im);
    ruido = sqrt(varianza)*randn(tamx,tamy)+media;
    im = double(im)+ruido;
    handles.imgconruido = uint8(im);
    axes(handles.axes2);
    imshow(handles.imgconruido);
    
elseif(get(handles.gaussianomultiplicativo,'Value')==1)

    alfa = double(str2num(get(handles.alfa,'String')));
    
    im = handles.img;
    [tamx, tamy] = size(im);
    ruido = sqrt(alfa*double(im)).*randn(tamx,tamy);
    im = double(im)+ruido;
    handles.imgconruido = uint8(im);
    axes(handles.axes2);
    imshow(handles.imgconruido);
    
elseif(get(handles.salpimienta,'Value')==1)

    sal = double(str2num(get(handles.sal,'String')))/100;
    pimienta = double(str2num(get(handles.pimienta,'String')))/100;
    
    handles.imgconruido = handles.img;
    [tamx, tamy] = size(handles.imgconruido);
    aux = rand(tamx,tamy);
    sal = aux <= sal;
    pimienta = aux >= 1-pimienta;
    handles.imgconruido(sal) = 0;
    handles.imgconruido(pimienta) = 255;
    ruido = handles.imgconruido - handles.img;
    axes(handles.axes2);
    imshow(handles.imgconruido);
end

%calculo del MSE entre original y con ruido
error = double(handles.img) - double(handles.imgconruido);
errorc = error.^2; 
tam = size(errorc);
mse = sum(sum(errorc))/(tam(1) * tam(2));
set(handles.mse,'String',num2str(mse));


%calculo SNR entre original y con ruido
media =  mean2(double(handles.img));
resta1 = double(handles.img) - media;
cuadrado1 = resta1.*resta1;
dividendo = sum(sum(cuadrado1));

resta2 = double(handles.img)-double(handles.imgconruido);
cuadrado2 = resta2.*resta2;
divisor = sum(sum(cuadrado2));

snr = 10.*log10(dividendo/divisor);
set(handles.snr,'String',snr);

% Update handles structure
guidata(hObject, handles);



function mse_Callback(hObject, eventdata, handles)
% hObject    handle to mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mse as text
%        str2double(get(hObject,'String')) returns contents of mse as a double


% --- Executes during object creation, after setting all properties.
function mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function snr_Callback(hObject, eventdata, handles)
% hObject    handle to snr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of snr as text
%        str2double(get(hObject,'String')) returns contents of snr as a double


% --- Executes during object creation, after setting all properties.
function snr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to snr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in diferencia.
function diferencia_Callback(hObject, eventdata, handles)
% hObject    handle to diferencia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.resta1,'Value') == 1 && get(handles.resta2,'Value') == 1

    res = double(handles.img)-double(handles.imgconruido);
    figure, imshow(res);
    
elseif get(handles.resta2,'Value') == 1 && get(handles.resta3,'Value') == 1

    res = double(handles.imgconruido)-double(handles.imgfiltrada);
    figure, imshow(res);
    
elseif get(handles.resta1,'Value') == 1 && get(handles.resta3,'Value') == 1

    res = double(handles.img)-double(handles.imgfiltrada);
    figure, imshow(res);
    
end

set(handles.resta1,'Value',0);
set(handles.resta2,'Value',0);
set(handles.resta3,'Value',0);

% Update handles structure
guidata(hObject, handles);




% --- Executes on selection change in tipofiltro.
function tipofiltro_Callback(hObject, eventdata, handles)
% hObject    handle to tipofiltro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns tipofiltro contents as cell array
%        contents{get(hObject,'Value')} returns selected item from tipofiltro

handles.tipodefiltro = get (handles.tipofiltro,'String');

    
% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function tipofiltro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tipofiltro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filtrar.
function filtrar_Callback(hObject, eventdata, handles)
% hObject    handle to filtrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tamfiltro = double(str2num(get(handles.tamfiltro, 'String')));

if (get(handles.filtromedia,'Value')==1)
    
    h = fspecial('average',tamfiltro);
    handles.imgfiltrada = imfilter(handles.imgconruido,h);
    axes(handles.axes3);
    imshow(handles.imgfiltrada);
    

elseif(get(handles.filtrogaussiano,'Value')==1)
    
    param1 = tamfiltro;
    param2 = sqrt(param1);
    param1 = param1*7;
    
    if(mod(param1,2) == 0)%hacemos el tamaño de la ventana impar
        
       param1 = param1+1;
        
    end    
    
    h = fspecial('gaussian',param1,param2);
    handles.imgfiltrada = imfilter(handles.imgconruido,h);
    axes(handles.axes3);
    imshow(handles.imgfiltrada);
    
elseif(get(handles.filtromaximo,'Value')==1)
    
    max = ceil(tamfiltro*tamfiltro);
    handles.imgfiltrada = ordfilt2(handles.imgconruido, max, ones(tamfiltro,tamfiltro));
    axes(handles.axes3);
    imshow(handles.imgfiltrada);
    
elseif(get(handles.filtrominimo,'Value')==1)
    
    handles.imgfiltrada = ordfilt2(handles.imgconruido, 1, ones(tamfiltro,tamfiltro));
    axes(handles.axes3);
    imshow(handles.imgfiltrada);
    
elseif(get(handles.filtromediana,'Value')==1)
    
    valor1 = ceil((tamfiltro*tamfiltro)/2);
    handles.imgfiltrada = ordfilt2(handles.imgconruido, valor1, ones(tamfiltro,tamfiltro));
    axes(handles.axes3);
    imshow(handles.imgfiltrada);
    
    
end


%calculo ISNR
resta1 = double(handles.img) - double(handles.imgconruido);
cuadrado1 = resta1.*resta1; 
dividendo = sum(sum(cuadrado1));


resta1 = double(handles.img) - double(handles.imgfiltrada);
cuadrado1 = resta1.*resta1; 
divisor = sum(sum(cuadrado1));

isnr = 10.*log10(dividendo/divisor);
set(handles.isnr,'String',isnr);


%calculo SNR entre original y filtrada
media =  mean2(double(handles.img));
resta1 = double(handles.img) - media;
cuadrado1 = resta1.*resta1;
dividendo = sum(sum(cuadrado1));

resta2 = double(handles.img)-double(handles.imgfiltrada);
cuadrado2 = resta2.*resta2;
divisor = sum(sum(cuadrado2));

snr2 = 10.*log10(dividendo/divisor);
set(handles.snr2,'String',snr2);


%calculo MSE2 entre original y filtrada
error = double(handles.img) - double(handles.imgfiltrada);
errorc = error.^2; 
tam = size(errorc);
mse2 = sum(sum(errorc))/(tam(1) * tam(2));
set(handles.mse2,'String',num2str(mse2));


% Update handles structure
guidata(hObject, handles);



function tamfiltro_Callback(hObject, eventdata, handles)
% hObject    handle to tamfiltro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tamfiltro as text
%        str2double(get(hObject,'String')) returns contents of tamfiltro as a double




% --- Executes during object creation, after setting all properties.
function tamfiltro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tamfiltro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function isnr_Callback(hObject, eventdata, handles)
% hObject    handle to isnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of isnr as text
%        str2double(get(hObject,'String')) returns contents of isnr as a double


% --- Executes during object creation, after setting all properties.
function isnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filtromedia.
function filtromedia_Callback(hObject, eventdata, handles)
% hObject    handle to filtromedia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filtromedia

set(handles.filtrominimo,'Value',0);
set(handles.filtromediana,'Value',0);
set(handles.filtrogaussiano,'Value',0);
set(handles.filtromaximo,'Value',0);

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in filtrogaussiano.
function filtrogaussiano_Callback(hObject, eventdata, handles)
% hObject    handle to filtrogaussiano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filtrogaussiano

set(handles.filtrominimo,'Value',0);
set(handles.filtromediana,'Value',0);
set(handles.filtromedia,'Value',0);
set(handles.filtromaximo,'Value',0);

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in filtromaximo.
function filtromaximo_Callback(hObject, eventdata, handles)
% hObject    handle to filtromaximo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filtromaximo

set(handles.filtrominimo,'Value',0);
set(handles.filtromediana,'Value',0);
set(handles.filtromedia,'Value',0);
set(handles.filtrogaussiano,'Value',0);

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in filtrominimo.
function filtrominimo_Callback(hObject, eventdata, handles)
% hObject    handle to filtrominimo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filtrominimo

set(handles.filtromaximo,'Value',0);
set(handles.filtromediana,'Value',0);
set(handles.filtromedia,'Value',0);
set(handles.filtrogaussiano,'Value',0);

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in filtromediana.
function filtromediana_Callback(hObject, eventdata, handles)
% hObject    handle to filtromediana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filtromediana

set(handles.filtromaximo,'Value',0);
set(handles.filtrominimo,'Value',0);
set(handles.filtromedia,'Value',0);
set(handles.filtrogaussiano,'Value',0);

% Update handles structure
guidata(hObject, handles);



function snr2_Callback(hObject, eventdata, handles)
% hObject    handle to snr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of snr2 as text
%        str2double(get(hObject,'String')) returns contents of snr2 as a double


% --- Executes during object creation, after setting all properties.
function snr2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to snr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mse2_Callback(hObject, eventdata, handles)
% hObject    handle to mse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mse2 as text
%        str2double(get(hObject,'String')) returns contents of mse2 as a double


% --- Executes during object creation, after setting all properties.
function mse2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resta1.
function resta1_Callback(hObject, eventdata, handles)
% hObject    handle to resta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of resta1



% --- Executes on button press in resta2.
function resta2_Callback(hObject, eventdata, handles)
% hObject    handle to resta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of resta2



% --- Executes on button press in resta3.
function resta3_Callback(hObject, eventdata, handles)
% hObject    handle to resta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of resta3


% --- Executes on button press in medianaiterativa.
function medianaiterativa_Callback(hObject, eventdata, handles)
% hObject    handle to medianaiterativa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tamfiltro = double(str2num(get(handles.tamfiltro, 'String')));
max = str2num(get(handles.iteraciones,'String'));
res = handles.imgconruido;

for i = 1:max
    
    hayruido = (uint8(res) == 255) + (uint8(res) == 0);
    
    %calculo la imagen filtrada con mediana
    val = ceil((tamfiltro*tamfiltro)/2);
    med = ordfilt2(handles.imgconruido, val, ones(tamfiltro,tamfiltro));
   
    res = (uint8(res) .* uint8((1-hayruido))) + (uint8(med) .* uint8(hayruido));
    
    if mod(i,5) == 0
        
        tamfiltro = tamfiltro + 2;
    end
    
    axes(handles.axes3);
    imshow(res);
end



function iteraciones_Callback(hObject, eventdata, handles)
% hObject    handle to iteraciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iteraciones as text
%        str2double(get(hObject,'String')) returns contents of iteraciones as a double


% --- Executes during object creation, after setting all properties.
function iteraciones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iteraciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
