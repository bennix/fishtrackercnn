function varargout = gui_mark_learning(varargin)
% GUI_MARK_LEARNING MATLAB code for gui_mark_learning.fig
%      GUI_MARK_LEARNING, by itself, creates a new GUI_MARK_LEARNING or raises the existing
%      singleton*.
%
%      H = GUI_MARK_LEARNING returns the handle to a new GUI_MARK_LEARNING or the handle to
%      the existing singleton*.
%
%      GUI_MARK_LEARNING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MARK_LEARNING.M with the given input arguments.
%
%      GUI_MARK_LEARNING('Property','Value',...) creates a new GUI_MARK_LEARNING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_mark_learning_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_mark_learning_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_mark_learning

% Last Modified by GUIDE v2.5 08-Jan-2016 14:13:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_mark_learning_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_mark_learning_OutputFcn, ...
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


% --- Executes just before gui_mark_learning is made visible.
function gui_mark_learning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_mark_learning (see VARARGIN)

% Choose default command line output for gui_mark_learning
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_mark_learning wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_mark_learning_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listSegment.
function listSegment_Callback(hObject, eventdata, handles)
% hObject    handle to listSegment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listSegment contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listSegment


% --- Executes during object creation, after setting all properties.
function listSegment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listSegment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edSegment_Callback(hObject, eventdata, handles)
% hObject    handle to edSegment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edSegment as text
%        str2double(get(hObject,'String')) returns contents of edSegment as a double


% --- Executes during object creation, after setting all properties.
function edSegment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edSegment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnLoadSegment.
function btnLoadSegment_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoadSegment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename =get(handles.edSegment,'String');
load(filename);
handles.all_segments=all_segments;
set(hObject,'BackgroundColor',[0 1 0]);
guidata(hObject, handles);

function edFilenameBase_Callback(hObject, eventdata, handles)
% hObject    handle to edFilenameBase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edFilenameBase as text
%        str2double(get(hObject,'String')) returns contents of edFilenameBase as a double


% --- Executes during object creation, after setting all properties.
function edFilenameBase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edFilenameBase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnSetFilenameBase.
function btnSetFilenameBase_Callback(hObject, eventdata, handles)
% hObject    handle to btnSetFilenameBase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filenamebase =get(handles.edFilenameBase,'String');
handles.filenamebase=filenamebase;
set(hObject,'BackgroundColor',[0 1 0]);
guidata(hObject, handles);

% --- Executes on selection change in popFishIDs.
function popFishIDs_Callback(hObject, eventdata, handles)
% hObject    handle to popFishIDs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: contents = cellstr(get(hObject,'String')) returns popFishIDs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popFishIDs
sel_id = get(handles.popFishIDs,'Value');
handles.current_tracks_id=sel_id;
seg_ids=handles.tracks{handles.current_tracks_id};
N=length(seg_ids);
disp_seg_ids=[];
for i=1:N
    disp_seg_ids{i}=num2str(seg_ids(i));
end
set(handles.listSegment,'String',disp_seg_ids);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popFishIDs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popFishIDs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% load('config.mat','filenamebase','database','total_frame','total_fish');
% handles.filenamebase=filenamebase;
% set(handles.edFilenameBase,'String',handles.filenamebase);
% set(handles.btnSetFilenameBase,'BackgroundColor',[0 1 0]);
guidata(hObject, handles);

function  MsgUp (object, eventdata)
handles = guidata(object);
C = get (handles.axes1, 'CurrentPoint');
mouse_x=C(1,1);
mouse_y=C(1,2);
filtered_segments=handles.filtered_segments;
N=length(filtered_segments);
com_xy=zeros(N,3);
for id=1:N
    x=filtered_segments{id}.segment_records(:,3);
    y=filtered_segments{id}.segment_records(:,4);
    tframe=filtered_segments{id}.segment_records(1,1);
    tid=filtered_segments{id}.segment_records(1,end);
    com_xy(id,1)=x(1);
    com_xy(id,2)=y(1);
    com_xy(id,3)=tid;
    %text(x(1),y(1)+5,[num2str(tid) ' @ '   num2str(tframe-handles.current_frame)],'Color','b','FontSize',15);
end
dist_v=sqrt((com_xy(:,1)-mouse_x).^2+(com_xy(:,2)-mouse_y).^2);
[min_dis,min_idx]=min(dist_v);
if min_dis<40
    sel_seg_id=com_xy(min_idx,3);
    current_tacks_id=handles.current_tracks_id;
    IDs=handles.tracks{current_tacks_id};
    IDs=[IDs sel_seg_id];
    N=length(IDs);
    disp_seg_ids=[];
    for i=1:N
        disp_seg_ids{i}=num2str(IDs(i));
    end
    set(handles.listSegment,'String',disp_seg_ids);
    handles.tracks{current_tacks_id}=IDs;
    
end
set(handles.hzoom,'Enable','off');
guidata(object,handles);

% --- Executes on button press in btnMarkAdd.
function btnMarkAdd_Callback(hObject, eventdata, handles)
% hObject    handle to btnMarkAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'hzoom')
    bo=get(handles.hzoom,'Enable');
    if ~strcmp(bo,'on')
        handles.hzoom=zoom;
        handles.hCMZ = uicontextmenu;
        handles.hZMenu = uimenu('Parent',handles.hCMZ,'Label','Mark',...
            'Callback',@MsgUp);
        set(handles.hzoom,'UIContextMenu',handles.hCMZ);
        set(handles.hzoom,'Enable','on');
    end
else
    handles.hzoom=zoom;
    handles.hCMZ = uicontextmenu;
    handles.hZMenu = uimenu('Parent',handles.hCMZ,'Label','Mark',...
        'Callback',@MsgUp);
    set(handles.hzoom,'UIContextMenu',handles.hCMZ);
    set(handles.hzoom,'Enable','on');
end
guidata(hObject, handles);

% --- Executes on button press in btnDel.
function btnDel_Callback(hObject, eventdata, handles)
% hObject    handle to btnDel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx=get(handles.listSegment,'Value');
current_tacks_id=handles.current_tracks_id;
IDs=handles.tracks{current_tacks_id};
IDs(idx)=[];
N=length(IDs);
disp_seg_ids=[];
for i=1:N
    disp_seg_ids{i}=num2str(IDs(i));
end
set(handles.listSegment,'String',disp_seg_ids,'Value',1);
handles.tracks{current_tacks_id}=IDs;
guidata(hObject, handles);

function edSegID_Callback(hObject, eventdata, handles)
% hObject    handle to edSegID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edSegID as text
%        str2double(get(hObject,'String')) returns contents of edSegID as a double


% --- Executes during object creation, after setting all properties.
function edSegID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edSegID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnAppend.
function btnAppend_Callback(hObject, eventdata, handles)
% hObject    handle to btnAppend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
current_tacks_id=handles.current_tracks_id;
IDs=handles.tracks{current_tacks_id};
seg_id=str2num(get(handles.edSegID,'String'));
IDs=[IDs seg_id];
N=length(IDs);
disp_seg_ids=[];
for i=1:N
    disp_seg_ids{i}=num2str(IDs(i));
end
set(handles.listSegment,'String',disp_seg_ids);
handles.tracks{current_tacks_id}=IDs;
guidata(hObject, handles);


% --- Executes on button press in btnFirst.
function btnFirst_Callback(hObject, eventdata, handles)
% hObject    handle to btnFirst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_frame=1;
frame=handles.current_frame;
set(handles.edFrameNo,'String',num2str(frame));
filename=sprintf(handles.filenamebase,frame);
im=imread(filename);
axes(handles.axes1);
imshow(im,[]);
filtered_segments=handles.filtered_segments;
hold on
N=length(filtered_segments);
for id=1:N
    x=filtered_segments{id}.segment_records(:,3);
    y=filtered_segments{id}.segment_records(:,4);
    tframe=filtered_segments{id}.segment_records(1,1);
    tid=filtered_segments{id}.segment_records(1,end);
    plot(x,y,'g-');
    text(x(1),y(1)+5,[num2str(tid) ' @ '   num2str(tframe-handles.current_frame)],'Color','b','FontSize',15);
end
guidata(hObject, handles);

% --- Executes on button press in btnPrev.
function btnPrev_Callback(hObject, eventdata, handles)
% hObject    handle to btnPrev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_frame=handles.current_frame-1;
if handles.current_frame<1
   handles.current_frame=1;
end
frame=handles.current_frame;
set(handles.edFrameNo,'String',num2str(frame));
filename=sprintf(handles.filenamebase,frame);
im=imread(filename);
axes(handles.axes1);
imshow(im,[]);
filtered_segments=handles.filtered_segments;
hold on
N=length(filtered_segments);
for id=1:N
    x=filtered_segments{id}.segment_records(:,3);
    y=filtered_segments{id}.segment_records(:,4);
    tframe=filtered_segments{id}.segment_records(1,1);
    tid=filtered_segments{id}.segment_records(1,end);
    plot(x,y,'g-');
    text(x(1),y(1)+5,[num2str(tid) ' @ '   num2str(tframe-handles.current_frame)],'Color','b','FontSize',15);
end
guidata(hObject, handles);

% --- Executes on button press in btnGotoFrame.
function btnGotoFrame_Callback(hObject, eventdata, handles)
% hObject    handle to btnGotoFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_frame=str2num(get(handles.edFrameNo,'String'));
frame=handles.current_frame;
%set(handles.edFrameNo,'String',num2str(frame));
filename=sprintf(handles.filenamebase,frame);
im=imread(filename);
axes(handles.axes1);
imshow(im,[]);
filtered_segments=handles.filtered_segments;
hold on
N=length(filtered_segments);
for id=1:N
    x=filtered_segments{id}.segment_records(:,3);
    y=filtered_segments{id}.segment_records(:,4);
    tframe=filtered_segments{id}.segment_records(1,1);
    tid=filtered_segments{id}.segment_records(1,end);
    plot(x,y,'g-');
    text(x(1),y(1)+5,[num2str(tid) ' @ '   num2str(tframe-handles.current_frame)],'Color','b','FontSize',15);
end
guidata(hObject, handles);

% --- Executes on button press in btnNext.
function btnNext_Callback(hObject, eventdata, handles)
% hObject    handle to btnNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_frame=handles.current_frame+1;
if handles.current_frame>handles.total_frame_number
   handles.current_frame=handles.total_frame_number;
end
frame=handles.current_frame;
set(handles.edFrameNo,'String',num2str(frame));
filename=sprintf(handles.filenamebase,frame);
im=imread(filename);
axes(handles.axes1);
imshow(im,[]);
filtered_segments=handles.filtered_segments;
hold on
N=length(filtered_segments);
for id=1:N
    x=filtered_segments{id}.segment_records(:,3);
    y=filtered_segments{id}.segment_records(:,4);
    tframe=filtered_segments{id}.segment_records(1,1);
    tid=filtered_segments{id}.segment_records(1,end);
    plot(x,y,'g-');
    text(x(1),y(1)+5,[num2str(tid) ' @ '   num2str(tframe-handles.current_frame)],'Color','b','FontSize',15);
end
guidata(hObject, handles);

% --- Executes on button press in btnLast.
function btnLast_Callback(hObject, eventdata, handles)
% hObject    handle to btnLast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_frame=handles.total_frame_number;
frame=handles.current_frame;
set(handles.edFrameNo,'String',num2str(frame));
filename=sprintf(handles.filenamebase,frame);
im=imread(filename);
axes(handles.axes1);
imshow(im,[]);
filtered_segments=handles.filtered_segments;
hold on
N=length(filtered_segments);
for id=1:N
    x=filtered_segments{id}.segment_records(:,3);
    y=filtered_segments{id}.segment_records(:,4);
    tframe=filtered_segments{id}.segment_records(1,1);
    tid=filtered_segments{id}.segment_records(1,end);
    plot(x,y,'g-');
    text(x(1),y(1)+5,[num2str(tid) ' @ '   num2str(tframe-handles.current_frame)],'Color','b','FontSize',15);
end
guidata(hObject, handles);

% --- Executes on button press in btnPlay.
function btnPlay_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.current_tracks_id
IDs=handles.tracks{handles.current_tracks_id};
all_segments=handles.all_segments;
%handles.filenamebase
segment_records=[];
segment_images=[];
for i=1:length(IDs)
 segment_records=[segment_records; all_segments{IDs(i)}.segment_records];
 segment_images=[segment_images all_segments{IDs(i)}.segment_pictures];
end
N=size(segment_records,1);
track_x=[];
track_y=[];
axes(handles.axes1);
for i=1:N
    
    frame=segment_records(i,1);
    filename=sprintf(handles.filenamebase,frame);
    im=imread(filename);
    
    imshow(im,[]);
    hold on
    sel_x=segment_records(i,3);
    sel_y=segment_records(i,4);
    track_x=[track_x;sel_x];
    track_y=[track_y;sel_y];
    plot(sel_x,sel_y,'g+');
    strack_x=track_x(max(1,end-150):end);
    strack_y=track_y(max(1,end-150):end);
    plot(strack_x,strack_y,'r-');
    hold off
    %refreshdata;
    set(handles.edFrameNo,'String',num2str(frame));
    %pause(0.03); 
     
    drawnow %limitrate nocallbacks
    %frame = getframe;
    %writeVideo(writerObj,frame);
end
handles.current_frame=frame;

before=0;
handles.total_fish=handles.fish_num;
[filtered_segments]=filter_all_segments(all_segments,sel_x,sel_y,handles.current_frame,before,handles);

hold on
N=length(filtered_segments);
for id=1:N
    x=filtered_segments{id}.segment_records(:,3);
    y=filtered_segments{id}.segment_records(:,4);
    tframe=filtered_segments{id}.segment_records(1,1);
    tid=filtered_segments{id}.segment_records(1,end);
    plot(x,y,'g-');
    text(x(1),y(1)+5,[num2str(tid) ' @ '   num2str(tframe-handles.current_frame)],'Color','b','FontSize',15);
end
handles.filtered_segments=filtered_segments;
guidata(hObject, handles);



function edFrameNo_Callback(hObject, eventdata, handles)
% hObject    handle to edFrameNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edFrameNo as text
%        str2double(get(hObject,'String')) returns contents of edFrameNo as a double


% --- Executes during object creation, after setting all properties.
function edFrameNo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edFrameNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edTotalFishNumber_Callback(hObject, eventdata, handles)
% hObject    handle to edTotalFishNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edTotalFishNumber as text
%        str2double(get(hObject,'String')) returns contents of edTotalFishNumber as a double


% --- Executes during object creation, after setting all properties.
function edTotalFishNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edTotalFishNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnSetFishNUmber.
function btnSetFishNUmber_Callback(hObject, eventdata, handles)
% hObject    handle to btnSetFishNUmber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fish_num=str2num(get(handles.edTotalFishNumber,'String'));
set(hObject,'BackgroundColor',[0 1 0]);
for i=1:handles.fish_num
   fishids{i}=num2str(i);
   tracks{i}=i;
end
handles.current_tracks_id=1;
handles.tracks=tracks;
seg_ids=handles.tracks{1};
N=length(seg_ids);
disp_seg_ids=[];
for i=1:N
    disp_seg_ids{i}=num2str(seg_ids(i));
end
set(handles.listSegment,'String',disp_seg_ids);
set(handles.popFishIDs,'String',fishids);
guidata(hObject, handles);


function edTotalFrameNo_Callback(hObject, eventdata, handles)
% hObject    handle to edTotalFrameNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edTotalFrameNo as text
%        str2double(get(hObject,'String')) returns contents of edTotalFrameNo as a double


% --- Executes during object creation, after setting all properties.
function edTotalFrameNo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edTotalFrameNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnSetTotalFrameNo.
function btnSetTotalFrameNo_Callback(hObject, eventdata, handles)
% hObject    handle to btnSetTotalFrameNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.total_frame_number=str2num(get(handles.edTotalFrameNo,'String'));
set(hObject,'BackgroundColor',[0 1 0]);
guidata(hObject, handles);


% --- Executes on button press in btnSaveClose.
function btnSaveClose_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tracks=handles.tracks;
save([handles.database '\tracks.mat'],'tracks');
close;

% --- Executes on button press in btnPlayLast.
function btnPlayLast_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlayLast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IDs=handles.tracks{handles.current_tracks_id};
all_segments=handles.all_segments;
%handles.filenamebase
segment_records=[];
segment_images=[];
for i=length(IDs):length(IDs)
 segment_records=[segment_records; all_segments{IDs(i)}.segment_records];
 segment_images=[segment_images all_segments{IDs(i)}.segment_pictures];
end
N=size(segment_records,1);
track_x=[];
track_y=[];
axes(handles.axes1);
for i=1:N
    
    frame=segment_records(i,1);
    filename=sprintf(handles.filenamebase,frame);
    im=imread(filename);
    
    imshow(im,[]);
    hold on
    sel_x=segment_records(i,3);
    sel_y=segment_records(i,4);
    track_x=[track_x;sel_x];
    track_y=[track_y;sel_y];
    plot(sel_x,sel_y,'g+');
    strack_x=track_x(max(1,end-150):end);
    strack_y=track_y(max(1,end-150):end);
    plot(strack_x,strack_y,'r-');
    hold off
    %refreshdata;
    set(handles.edFrameNo,'String',num2str(frame));
    %pause(0.03); 
     
    drawnow %limitrate nocallbacks
    %frame = getframe;
    %writeVideo(writerObj,frame);
end
handles.current_frame=frame;

before=0;
handles.total_fish=handles.fish_num;
[filtered_segments]=filter_all_segments(all_segments,sel_x,sel_y,handles.current_frame,before,handles);

hold on
N=length(filtered_segments);
for id=1:N
    x=filtered_segments{id}.segment_records(:,3);
    y=filtered_segments{id}.segment_records(:,4);
    tframe=filtered_segments{id}.segment_records(1,1);
    tid=filtered_segments{id}.segment_records(1,end);
    plot(x,y,'g-');
    text(x(1),y(1)+5,[num2str(tid) ' @ '   num2str(tframe-handles.current_frame)],'Color','b','FontSize',15);
end
handles.filtered_segments=filtered_segments;
guidata(hObject, handles);


% --- Executes on button press in btnLoad.
function btnLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.mat', 'Select a Marked file');
load(fullfile(pathname, filename));
handles.tracks=tracks;
handles.fish_num= length(handles.tracks);
for i=1:handles.fish_num
   fishids{i}=num2str(i);
   tracks{i}=i;
end

set(handles.popFishIDs,'Value',1);
handles.current_tracks_id=1;
seg_ids=handles.tracks{handles.current_tracks_id};
N=length(seg_ids);
disp_seg_ids=[];
for i=1:N
    disp_seg_ids{i}=num2str(seg_ids(i));
end
set(handles.listSegment,'String',disp_seg_ids);
set(handles.popFishIDs,'String',fishids);
guidata(hObject, handles);


% --- Executes on button press in btnPlaySelected.
function btnPlaySelected_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlaySelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IDs=handles.tracks{handles.current_tracks_id};
all_segments=handles.all_segments;
segment_records=[];
segment_images=[];
sel_idx=get(handles.listSegment,'Value');

for i=sel_idx:sel_idx
 segment_records=[segment_records; all_segments{IDs(i)}.segment_records];
 segment_images=[segment_images all_segments{IDs(i)}.segment_pictures];
end
N=size(segment_records,1);
track_x=[];
track_y=[];
axes(handles.axes1);
for i=1:N
    
    frame=segment_records(i,1);
    filename=sprintf(handles.filenamebase,frame);
    im=imread(filename);
    
    imshow(im,[]);
    hold on
    sel_x=segment_records(i,3);
    sel_y=segment_records(i,4);
    track_x=[track_x;sel_x];
    track_y=[track_y;sel_y];
    plot(sel_x,sel_y,'g+');
    strack_x=track_x(max(1,end-150):end);
    strack_y=track_y(max(1,end-150):end);
    plot(strack_x,strack_y,'r-');
    hold off
    %refreshdata;
    set(handles.edFrameNo,'String',num2str(frame));
    %pause(0.03); 
     
    drawnow %limitrate nocallbacks
    %frame = getframe;
    %writeVideo(writerObj,frame);
end
handles.current_frame=frame;

before=0;
handles.total_fish=handles.fish_num;
[filtered_segments]=filter_all_segments(all_segments,sel_x,sel_y,handles.current_frame,before,handles);

hold on
N=length(filtered_segments);
for id=1:N
    x=filtered_segments{id}.segment_records(:,3);
    y=filtered_segments{id}.segment_records(:,4);
    tframe=filtered_segments{id}.segment_records(1,1);
    tid=filtered_segments{id}.segment_records(1,end);
    plot(x,y,'g-');
    text(x(1),y(1)+5,[num2str(tid) ' @ '   num2str(tframe-handles.current_frame)],'Color','b','FontSize',15);
end
handles.filtered_segments=filtered_segments;
guidata(hObject, handles);


% --- Executes on button press in btnLoadConfig.
function btnLoadConfig_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoadConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('config.mat','filenamebase','database','total_frame','total_fish');
handles.database=database;
filename=[database '\\all_segments'];
set(handles.edSegment,'String',filename);
load(filename);
handles.all_segments=all_segments;
set(handles.btnLoadSegment,'BackgroundColor',[0 1 0]);
set(handles.edFilenameBase,'String',filenamebase);
handles.filenamebase=filenamebase;
set(handles.btnSetFilenameBase,'BackgroundColor',[0 1 0]);
handles.fish_num=total_fish;
set(handles.edTotalFishNumber,'String',num2str(handles.fish_num));
set(handles.btnSetFishNUmber,'BackgroundColor',[0 1 0]);
for i=1:handles.fish_num
   fishids{i}=num2str(i);
   tracks{i}=i;
end
handles.current_tracks_id=1;
handles.tracks=tracks;
seg_ids=handles.tracks{1};
N=length(seg_ids);
disp_seg_ids=[];
for i=1:N
    disp_seg_ids{i}=num2str(seg_ids(i));
end
set(handles.listSegment,'String',disp_seg_ids);
set(handles.popFishIDs,'String',fishids);
handles.total_frame_number=total_frame;
set(handles.edTotalFrameNo,'String',num2str(handles.total_frame_number));
set(handles.btnSetTotalFrameNo,'BackgroundColor',[0 1 0]);
set(hObject,'BackgroundColor',[0 1 0]);
guidata(hObject, handles);
