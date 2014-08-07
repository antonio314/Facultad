function varargout = m1(varargin)
% M1 MATLAB code for m1.fig
%      M1, by itself, creates a new M1 or raises the existing
%      singleton*.
%
%      H = M1 returns the handle to a new M1 or the handle to
%      the existing singleton*.
%
%      M1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in M1.M with the given input arguments.
%
%      M1('Property','Value',...) creates a new M1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before m1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to m1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help m1

% Last Modified by GUIDE v2.5 06-Nov-2013 13:25:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @m1_OpeningFcn, ...
                   'gui_OutputFcn',  @m1_OutputFcn, ...
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


% --- Executes just before m1 is made visible.
function m1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to m1 (see VARARGIN)

% Choose default command line output for m1
handles.output = hObject;

handles.valor_o1 = 0;
handles.valor_o2 = 0;
handles.valor_o3 = 0;

handles.valor_d1 = 0;
handles.valor_d2 = 0;
handles.valor_d3 = 0;

handles.valor_cb1 = 0;
handles.valor_cb2 = 0;
handles.valor_cb3 = 0;

handles.valor_resta1 = 0;
handles.valor_resta2 = 0;
handles.valor_resta3 = 0;

handles.valor_lineal = 0;
handles.valor_vecino = 0;
handles.valor_cubica = 0;

handles.valor_valor = 2;
set(handles.valor,'String',2);

handles.tipo_interpolacion = 'bilinear';

handles.auxcolor1 = get(handles.mapacolor,'String');
handles.auxcolor2 = get(handles.mapacolor,'Value');
handles.color = handles.auxcolor1{handles.auxcolor2};

set(handles.tam1,'String','0x0');
set(handles.tam2,'String','0x0');
set(handles.tam3,'String','0x0');

set(handles.promedio,'Value', 0);
handles.valor_promedio = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes m1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = m1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in o1.
function o1_Callback(hObject, eventdata, handles)
% hObject    handle to o1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o1

handles.valor_o1 = get(handles.o1,'Value');
set(handles.o2,'Value',0);
set(handles.o3,'Value',0);
handles.valor_o2=0;
handles.valor_o3=0;
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in d1.
function d1_Callback(hObject, eventdata, handles)
% hObject    handle to d1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of d1

handles.valor_d1 = get(handles.d1,'Value');
set(handles.d2,'Value',0);
set(handles.d3,'Value',0);
handles.valor_d2=0;
handles.valor_d3=0;
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in o2.
function o2_Callback(hObject, eventdata, handles)
% hObject    handle to o2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2

handles.valor_o2 = get(handles.o2,'Value');
set(handles.o1,'Value',0);
set(handles.o3,'Value',0);
handles.valor_o1=0;
handles.valor_o3=0;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in d2.
function d2_Callback(hObject, eventdata, handles)
% hObject    handle to d2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of d2

handles.valor_d2 = get(handles.d2,'Value');
set(handles.d1,'Value',0);
set(handles.d3,'Value',0);
handles.valor_d1=0;
handles.valor_d3=0;

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in o3.
function o3_Callback(hObject, eventdata, handles)
% hObject    handle to o3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o3

handles.valor_o3 = get(handles.o3,'Value');
set(handles.o1,'Value',0);
set(handles.o2,'Value',0);
handles.valor_o1=0;
handles.valor_o2=0;

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in d3.
function d3_Callback(hObject, eventdata, handles)
% hObject    handle to d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of d3

handles.valor_d3 = get(handles.d3,'Value');
set(handles.d1,'Value',0);
set(handles.d2,'Value',0);
handles.valor_d1=0;
handles.valor_d2=0;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in abrir.
function abrir_Callback(hObject, eventdata, handles)
% hObject    handle to abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if handles.valor_o1 == 1
    
    axes(handles.axes1);
    handles.img1 = imread(imgetfile());

    tama = size(size(handles.img1));
    tam=size(handles.img1);
    
    if tama(2)==3
        handles.img1 = rgb2gray(handles.img1);
    end
    
    imshow(handles.img1);
    set(handles.tam1,'String',strcat(num2str(tam(1)),'x',num2str(tam(2))));
    
    

elseif handles.valor_o2 == 1
    
     axes(handles.axes2);
         handles.img2 = imread(imgetfile());

     tama = size(size(handles.img2));
     tam=size(handles.img2);

     if tama(2)==3
         handles.img2 = rgb2gray(handles.img2);
     end
    
     imshow(handles.img2);
     set(handles.tam2,'String',strcat(num2str(tam(1)),'x',num2str(tam(2))));
     
     

elseif handles.valor_o3 == 1 
    axes(handles.axes3);
    
    handles.img3 = imread(imgetfile());

    tama = size(size(handles.img3));
    tam=size(handles.img3);

    if tama(2)==3
        handles.img3 = rgb2gray(handles.img3);
    end
    
    imshow(handles.img3);
    set(handles.tam3,'String',strcat(num2str(tam(1)),'x',num2str(tam(2))));
        
end

% Update handles structure
guidata(hObject, handles);
    


% --- Executes on button press in guardar.
function guardar_Callback(hObject, eventdata, handles)
% hObject    handle to guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if handles.valor_o1 == 1
    imwrite(uint8(handles.img1),imputfile());

elseif handles.valor_o2 == 1
     imwrite(uint8(handles.img2),imputfile());

elseif handles.valor_o3 == 1 
    imwrite(uint8(handles.img3),imputfile());
    
end


% --- Executes on selection change in mapacolor.
function mapacolor_Callback(hObject, eventdata, handles)
% hObject    handle to mapacolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mapacolor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mapacolor

handles.auxcolor1 = get(handles.mapacolor,'String');
handles.auxcolor2 = get(handles.mapacolor,'Value');
handles.color = handles.auxcolor1{handles.auxcolor2};

axes(handles.axes1);
colormap(handles.color);

axes(handles.axes2);
colormap(handles.color);

axes(handles.axes3);
colormap(handles.color);

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function mapacolor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mapacolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mostrarcolorbar.
function mostrarcolorbar_Callback(hObject, eventdata, handles)
% hObject    handle to mostrarcolorbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.valor_o1 == 1
    
    axes(handles.axes1);
    colorbar();   
    

elseif handles.valor_o2 == 1
    
	axes(handles.axes2);
	colorbar();

elseif handles.valor_o3 == 1 
    
    axes(handles.axes3);
    colorbar();    
    
end


% --- Executes on button press in cb1.
function cb1_Callback(hObject, eventdata, handles)
% hObject    handle to cb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb1

handles.valor_cb1 = get (handles.cb1, 'Value');
axes(handles.axes1);

if handles.valor_cb1 == 1

    colorbar();
    
else colorbar('hide');
    
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in cb2.
function cb2_Callback(hObject, eventdata, handles)
% hObject    handle to cb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb2

handles.valor_cb2 = get (handles.cb2, 'Value');

axes(handles.axes2);

if handles.valor_cb2 == 1
    
    colorbar();
    
else colorbar('hide');

end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in cb3.
function cb3_Callback(hObject, eventdata, handles)
% hObject    handle to cb3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb3

handles.valor_cb3 = get (handles.cb3, 'Value');

axes(handles.axes3);

if handles.valor_cb3 == 1
    
    colorbar();
    
else colorbar('hide');
    
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in restar.
function restar_Callback(hObject, eventdata, handles)
% hObject    handle to restar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if handles.valor_resta1 == 1 && handles.valor_resta2 == 1

    res = handles.img1-handles.img2;
    figure, imshow(res);
    
elseif handles.valor_resta1 == 1 && handles.valor_resta3 == 1

    res = handles.img1-handles.img3;
    figure, imshow(res);
    
elseif handles.valor_resta2 == 1 && handles.valor_resta3 == 1

    res = handles.img2-handles.img3;
    figure, imshow(res);
    
end

handles.valor_resta1 = 0;
handles.valor_resta2 = 0;
handles.valor_resta3 = 0;

set(handles.resta1,'Value',0);
set(handles.resta2,'Value',0);
set(handles.resta3,'Value',0);

% Update handles structure
guidata(hObject, handles);

    
% --- Executes on button press in resta1.
function resta1_Callback(hObject, eventdata, handles)
% hObject    handle to resta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of resta1

handles.valor_resta1 = get (handles.resta1, 'Value');

% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in resta2.
function resta2_Callback(hObject, eventdata, handles)
% hObject    handle to resta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of resta2

handles.valor_resta2 = get (handles.resta2, 'Value');

% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in resta3.
function resta3_Callback(hObject, eventdata, handles)
% hObject    handle to resta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of resta3

handles.valor_resta3 = get (handles.resta3, 'Value');

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in cubica.
function cubica_Callback(hObject, eventdata, handles)
% hObject    handle to cubica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cubica

handles.valor_cubica = get(handles.cubica,'Value');
set(handles.lineal,'Value',0);
set(handles.vecino,'Value',0);
handles.tipo_interpolacion = 'bicubic';

% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in vecino.
function vecino_Callback(hObject, eventdata, handles)
% hObject    handle to vecino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of vecino

handles.valor_vecino = get(handles.vecino,'Value');
set(handles.cubica,'Value',0);
set(handles.lineal,'Value',0);
handles.tipo_interpolacion = 'nearest';

% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in lineal.
function lineal_Callback(hObject, eventdata, handles)
% hObject    handle to lineal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lineal

handles.valor_lineal = get(handles.lineal,'Value');
set(handles.cubica,'Value',0);
set(handles.vecino,'Value',0);
handles.tipo_interpolacion = 'bilinear';

% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in interpolar.
function interpolar_Callback(hObject, eventdata, handles)
% hObject    handle to interpolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA

if handles.valor_o1 == 1
         
    if handles.valor_d1 == 1
        
        handles.img1 = imresize(handles.img1,handles.valor_valor,handles.tipo_interpolacion);
        axes(handles.axes1);
        imshow(handles.img1);
        tam1=size(handles.img1);
        set(handles.tam1,'String',strcat(num2str(num2str(tam1(1))),'x',num2str(tam1(2))));
    
    elseif handles.valor_d2 == 1
        
        handles.img2 = imresize(handles.img1,handles.valor_valor,handles.tipo_interpolacion);
        axes(handles.axes2);
        imshow(handles.img2);
        tam2=size(handles.img2);
        set(handles.tam2,'String',strcat(num2str(tam2(1)),'x',num2str(tam2(2))));
        
    elseif handles.valor_d3 == 1
        
        handles.img3 = imresize(handles.img1,handles.valor_valor,handles.tipo_interpolacion);
        axes(handles.axes3);
        imshow(handles.img3);
        tam3=size(handles.img3);
        set(handles.tam3,'String',strcat(num2str(tam3(1)),'x',num2str(tam3(2))));
        
    end
        
        
    
elseif handles.valor_o2 == 1
    
    
    if handles.valor_d1 == 1
        
        handles.img1 = imresize(handles.img2,handles.valor_valor,handles.tipo_interpolacion);
        axes(handles.axes1);
        imshow(handles.img1);
        tam1=size(handles.img1);
        set(handles.tam1,'String',strcat(num2str(tam1(1)),'x',num2str(tam1(2))));
        
    elseif handles.valor_d2 == 1
        
        handles.img2 = imresize(handles.img2,handles.valor_valor,handles.tipo_interpolacion);
        axes(handles.axes2);
        imshow(handles.img2);
        tam2=size(handles.img2);
        set(handles.tam2,'String',strcat(num2str(tam2(1)),'x',num2str(tam2(2))));
    
    elseif handles.valor_d3 == 1
        
        handles.img3 = imresize(handles.img2,handles.valor_valor,handles.tipo_interpolacion);
        axes(handles.axes3);
        imshow(handles.img3);
        tam3=size(handles.img3);
        set(handles.tam3,'String',strcat(num2str(tam3(1)),'x',num2str(tam3(2))));
        
    end
    
 
elseif handles.valor_o3 == 1
        
    if handles.valor_d1 == 1
        
        handles.img1 = imresize(handles.img3,handles.valor_valor,handles.tipo_interpolacion);
        axes(handles.axes1);
        imshow(handles.img1);
        tam1=size(handles.img1);
        set(handles.tam1,'String',strcat(num2str(tam1(1)),'x',num2str(tam1(2))));
    
    elseif handles.valor_d2 == 1
        
        handles.img2 = imresize(handles.img3,handles.valor_valor,handles.tipo_interpolacion);
        axes(handles.axes2);
        imshow(handles.img2);
        tam2=size(handles.img2);
        set(handles.tam2,'String',strcat(num2str(tam2(1)),'x',num2str(tam2(2))));
    
    elseif handles.valor_d3 == 1
        
        handles.img3 = imresize(handles.img3,handles.valor_valor,handles.tipo_interpolacion);
        axes(handles.axes3);
        imshow(handles.img3);
        tam3=size(handles.img3);
        set(handles.tam3,'String',strcat(num2str(tam3(1)),'x',num2str(tam3(2))));
    
    end

end 
   

% Update handles structure
guidata(hObject, handles);



function valor_Callback(hObject, eventdata, handles)
% hObject    handle to valor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valor as text
%        str2double(get(hObject,'String')) returns contents of valor as a double

handles.valor_valor = str2num(get(handles.valor,'String'));

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function valor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in submuestreo.
function submuestreo_Callback(hObject, eventdata, handles)
% hObject    handle to submuestreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


factor = str2num(get(handles.valor,'String'));


if handles.valor_promedio == 0
    

    if handles.valor_o1 == 1

        if handles.valor_d1 == 1

            handles.img1 = handles.img1(1:factor:end, 1:factor:end);
            axes(handles.axes1);
            imshow(handles.img1);
            tam1=size(handles.img1);
            set(handles.tam1,'String',strcat(num2str(tam1(1)),'x',num2str(tam1(2))));

        elseif handles.valor_d2 == 1

            handles.img2 = handles.img1(1:factor:end, 1:factor:end);
            axes(handles.axes2);
            imshow(handles.img2);
            tam2=size(handles.img2);
            set(handles.tam2,'String',strcat(num2str(tam2(1)),'x',num2str(tam2(2))));

        elseif handles.valor_d3 == 1

            handles.img3 = handles.img1(1:factor:end, 1:factor:end);
            axes(handles.axes3);
            imshow(handles.img3);
            tam3=size(handles.img3);
            set(handles.tam3,'String',strcat(num2str(tam3(1)),'x',num2str(tam3(2))));

        end


    elseif handles.valor_o2 == 1

        if handles.valor_d1 == 1   

            handles.img1 = handles.img2(1:factor:end, 1:factor:end);
            axes(handles.axes1);
            imshow(handles.img1);
            tam1=size(handles.img1);
            set(handles.tam1,'String',strcat(num2str(tam1(1)),'x',num2str(tam1(2))));

        elseif handles.valor_d2 == 1

            handles.img2 = handles.img2(1:factor:end, 1:factor:end);
            axes(handles.axes2);
            imshow(handles.img2);
            tam2=size(handles.img2);
            set(handles.tam2,'String',strcat(num2str(tam2(1)),'x',num2str(tam2(2))));

        elseif handles.valor_d3 == 1

            handles.img3 = handles.img2(1:factor:end, 1:factor:end);
            axes(handles.axes3);
            imshow(handles.img3);
            tam3=size(handles.img3);
            set(handles.tam3,'String',strcat(num2str(tam3(1)),'x',num2str(tam3(2))));

        end

    elseif handles.valor_o3 == 1

        if handles.valor_d1 == 1

            handles.img1 = handles.img3(1:factor:end, 1:factor:end);
            axes(handles.axes1);
            imshow(handles.img1);
            tam1=size(handles.img3);
            set(handles.tam1,'String',strcat(num2str(tam1(1)),'x',num2str(tam1(2))));

        elseif handles.valor_d2 == 1

            handles.img2 = handles.img3(1:factor:end, 1:factor:end);
            axes(handles.axes2);
            imshow(handles.img2);
            tam2=size(handles.img3);
            set(handles.tam2,'String',strcat(num2str(tam2(1)),'x',num2str(tam2(2))));

        elseif handles.valor_d3 == 1

            handles.img3 = handles.img3(1:factor:end, 1:factor:end);
            axes(handles.axes3);
            imshow(handles.img3);
            tam3=size(handles.img3);
            set(handles.tam3,'String',strcat(num2str(tam3(1)),'x',num2str(tam3(2))));

        end
    end
    
else
    
    if mod(factor,2) == 0
    
        promedio = factor + 1;

    else
    
        promedio = factor;
    
    end

    mascara = fspecial('average',promedio);
    
    
    if handles.valor_o1 == 1

        if handles.valor_d1 == 1

            handles.img1 = imfilter(handles.img1,mascara);
            handles.img1 = handles.img1(1:factor:end, 1:factor:end);
            axes(handles.axes1);
            imshow(handles.img1);
            tam1=size(handles.img1);
            set(handles.tam1,'String',strcat(num2str(tam1(1)),'x',num2str(tam1(2))));

        elseif handles.valor_d2 == 1

            handles.img1 = imfilter(handles.img1,mascara);
            handles.img2 = handles.img1(1:factor:end, 1:factor:end);
            axes(handles.axes2);
            imshow(handles.img2);
            tam2=size(handles.img2);
            set(handles.tam2,'String',strcat(num2str(tam2(1)),'x',num2str(tam2(2))));

        elseif handles.valor_d3 == 1

            handles.img1 = imfilter(handles.img1,mascara);
            handles.img3 = handles.img1(1:factor:end, 1:factor:end);
            axes(handles.axes3);
            imshow(handles.img3);
            tam3=size(handles.img3);
            set(handles.tam3,'String',strcat(num2str(tam3(1)),'x',num2str(tam3(2))));

        end


    elseif handles.valor_o2 == 1

        if handles.valor_d1 == 1   

            handles.img2 = imfilter(handles.img2,mascara);
            handles.img1 = handles.img2(1:factor:end, 1:factor:end);
            axes(handles.axes1);
            imshow(handles.img1);
            tam1=size(handles.img1);
            set(handles.tam1,'String',strcat(num2str(tam1(1)),'x',num2str(tam1(2))));

        elseif handles.valor_d2 == 1

            handles.img2 = imfilter(handles.img2,mascara);
            handles.img2 = handles.img2(1:factor:end, 1:factor:end);
            axes(handles.axes2);
            imshow(handles.img2);
            tam2=size(handles.img2);
            set(handles.tam2,'String',strcat(num2str(tam2(1)),'x',num2str(tam2(2))));

        elseif handles.valor_d3 == 1

            handles.img2 = imfilter(handles.img2,mascara);
            handles.img3 = handles.img2(1:factor:end, 1:factor:end);
            axes(handles.axes3);
            imshow(handles.img3);
            tam3=size(handles.img3);
            set(handles.tam3,'String',strcat(num2str(tam3(1)),'x',num2str(tam3(2))));

        end

    elseif handles.valor_o3 == 1

        if handles.valor_d1 == 1

            handles.img3 = imfilter(handles.img3,mascara);
            handles.img1 = handles.img3(1:factor:end, 1:factor:end);
            axes(handles.axes1);
            imshow(handles.img1);
            tam1=size(handles.img3);
            set(handles.tam1,'String',strcat(num2str(tam1(1)),'x',num2str(tam1(2))));

        elseif handles.valor_d2 == 1

            handles.img3 = imfilter(handles.img3,mascara);
            handles.img2 = handles.img3(1:factor:end, 1:factor:end);
            axes(handles.axes2);
            imshow(handles.img2);
            tam2=size(handles.img3);
            set(handles.tam2,'String',strcat(num2str(tam2(1)),'x',num2str(tam2(2))));

        elseif handles.valor_d3 == 1

            handles.img3 = imfilter(handles.img3,mascara);
            handles.img3 = handles.img3(1:factor:end, 1:factor:end);
            axes(handles.axes3);
            imshow(handles.img3);
            tam3=size(handles.img3);
            set(handles.tam3,'String',strcat(num2str(tam3(1)),'x',num2str(tam3(2))));

        end
    end
        
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in promedio.
function promedio_Callback(hObject, eventdata, handles)
% hObject    handle to promedio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of promedio

handles.valor_promedio = get (handles.promedio, 'Value');

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in mse.
function mse_Callback(hObject, eventdata, handles)
% hObject    handle to mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.valor_resta1 == 1 && handles.valor_resta2 == 1

    error = int16(handles.img1)-int16(handles.img2);
    errorc = error.^2; 
    disp(size(errorc));
    tam = size(errorc);
    disp(tam);
    mse = sum(sum(errorc))/(tam(1) * tam(2));
    disp(mse);
    
elseif handles.valor_resta1 == 1 && handles.valor_resta3 == 1

    error = int16(handles.img1)-int16(handles.img3);
    errorc = error.^2; 
    tam = size(errorc);
    mse = sum(sum(errorc))/(tam(1) * tam(2));
    
elseif handles.valor_resta2 == 1 && handles.valor_resta3 == 1

    error = handles.img2-handles.img3;
    errorc = error.^2; 
    tam = size(errorc);
    mse = sum(sum(errorc))/(tam(1) * tam(2));
    
end

handles.valor_resta1 = 0;
handles.valor_resta2 = 0;
handles.valor_resta3 = 0;

set(handles.valormse,'String',num2str(mse));
set(handles.resta1,'Value',0);
set(handles.resta2,'Value',0);
set(handles.resta3,'Value',0);

% Update handles structure
guidata(hObject, handles);


% --- Executes on slider movement.
function nivelescolor_Callback(hObject, eventdata, handles)
% hObject    handle to nivelescolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.auxcolor1 = get(handles.mapacolor,'String');
handles.auxcolor2 = get(handles.mapacolor,'Value');
handles.color = strcat(handles.auxcolor1{handles.auxcolor2},'(',num2str(get(handles.nivelescolor,'Value')),')');

axes(handles.axes1);
colormap(handles.color);

axes(handles.axes2);
colormap(handles.color);

axes(handles.axes3);
colormap(handles.color);


% --- Executes during object creation, after setting all properties.
function nivelescolor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nivelescolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
