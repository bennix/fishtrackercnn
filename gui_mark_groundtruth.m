function varargout = gui_mark_groundtruth(varargin)
% GUI_MARK_GROUNDTRUTH MATLAB code for gui_mark_groundtruth.fig
%      GUI_MARK_GROUNDTRUTH, by itself, creates a new GUI_MARK_GROUNDTRUTH or raises the existing
%      singleton*.
%
%      H = GUI_MARK_GROUNDTRUTH returns the handle to a new GUI_MARK_GROUNDTRUTH or the handle to
%      the existing singleton*.
%
%      GUI_MARK_GROUNDTRUTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MARK_GROUNDTRUTH.M with the given input arguments.
%
%      GUI_MARK_GROUNDTRUTH('Property','Value',...) creates a new GUI_MARK_GROUNDTRUTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_mark_groundtruth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_mark_groundtruth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_mark_groundtruth

% Last Modified by GUIDE v2.5 09-Dec-2015 20:39:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_mark_groundtruth_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_mark_groundtruth_OutputFcn, ...
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


% --- Executes just before gui_mark_groundtruth is made visible.
function gui_mark_groundtruth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_mark_groundtruth (see VARARGIN)

% Choose default command line output for gui_mark_groundtruth
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_mark_groundtruth wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_mark_groundtruth_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnLoadSegments.
function btnLoadSegments_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoadSegments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.mat','Select segment file');
load(fullfile(PathName, FileName));
handles.all_segments=all_segments;
set(hObject,'BackgroundColor',[0 1 0]);

guidata(hObject, handles);


    
% --- Executes on button press in btnLoadGroundTruth.
function btnLoadGroundTruth_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoadGroundTruth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.mat','Load Ground truth');
load(fullfile(PathName, FileName));
handles.fish_num=length(tracks);
set(hObject,'BackgroundColor',[0 1 0]);
handles.tracks=tracks;
handles.fish_num= length(handles.tracks);
for i=1:handles.fish_num
   fishids{i}=num2str(i);
   handles.ground_truth_xy{i}.x=-1*ones(handles.total_frame_number,1);
   handles.ground_truth_xy{i}.y=-1*ones(handles.total_frame_number,1);
   handles.ground_truth_xy{i}.frames=1:handles.total_frame_number;
end
for i=1:handles.fish_num
   track=tracks{i};
   N=length(track);
   for n=1:N
     seg_id=track(n);
     if seg_id~=-1
        sel_frames=handles.all_segments{seg_id}.segment_records(:,1);
        handles.ground_truth_xy{i}.x(sel_frames)=handles.all_segments{seg_id}.segment_records(:,3);
        handles.ground_truth_xy{i}.y(sel_frames)=handles.all_segments{seg_id}.segment_records(:,4);
     end
   end
   
end

set(handles.cbFishID,'Value',1);
handles.current_tracks_id=1;
seg_ids=handles.tracks{handles.current_tracks_id};
N=length(seg_ids);
disp_seg_ids=[];
for i=1:N
    disp_seg_ids{i}=num2str(seg_ids(i));
end
set(handles.listSegment,'String',disp_seg_ids);
set(handles.cbFishID,'String',fishids);
handles.current_frame=1;


guidata(hObject, handles);

% --- Executes on button press in btnFirst.
function btnFirst_Callback(hObject, eventdata, handles)
% hObject    handle to btnFirst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_frame=1;
set(handles.edFrameNo,'String',num2str(handles.current_frame));
frame=handles.current_frame;
set(handles.edFrameNo,'String',num2str(frame));
filename=sprintf(handles.filenamebase,frame);
im=imread(filename);
axes(handles.axes1);
cla;
imshow(im,[]);

x=handles.ground_truth_xy{handles.current_tracks_id}.x(handles.current_frame);
y=handles.ground_truth_xy{handles.current_tracks_id}.y(handles.current_frame);
if ~(x==-1 || y==-1)
   hold on;
   plot(x,y,'r+','Marker','+','MarkerEdgeColor',[1 .8 .1],'MarkerSize',16 );
  % hold off
end
startframe=max(1,handles.current_frame-10);
endframe=min(handles.current_frame+10,handles.total_frame_number);
for p=startframe:endframe
    if p~=handles.current_frame
        x=handles.ground_truth_xy{handles.current_tracks_id}.x(p);
        y=handles.ground_truth_xy{handles.current_tracks_id}.y(p);
        if ~(x==-1 || y==-1)
            hold on;
            plot(x,y,'bs','Marker','s','MarkerEdgeColor',[0 0 0.8],'MarkerSize',12 );
            %hold off
        end
    end
end
guidata(hObject, handles);

% --- Executes on button press in btnPrev.
function btnPrev_Callback(hObject, eventdata, handles)
% hObject    handle to btnPrev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_frame=handles.current_frame-1;
if  handles.current_frame<1
    handles.current_frame=1;
end
set(handles.edFrameNo,'String',num2str(handles.current_frame));
frame=handles.current_frame;
set(handles.edFrameNo,'String',num2str(frame));
filename=sprintf(handles.filenamebase,frame);
im=imread(filename);
axes(handles.axes1);
cla;
imshow(im,[]);

x=handles.ground_truth_xy{handles.current_tracks_id}.x(handles.current_frame);
y=handles.ground_truth_xy{handles.current_tracks_id}.y(handles.current_frame);
if ~(x==-1 || y==-1)
   hold on;
   plot(x,y,'r+','Marker','+','MarkerEdgeColor',[1 .8 .1],'MarkerSize',16 );
   %hold off
end
startframe=max(1,handles.current_frame-10);
endframe=min(handles.current_frame+10,handles.total_frame_number);
for p=startframe:endframe
    if p~=handles.current_frame
        x=handles.ground_truth_xy{handles.current_tracks_id}.x(p);
        y=handles.ground_truth_xy{handles.current_tracks_id}.y(p);
        if ~(x==-1 || y==-1)
            hold on;
            plot(x,y,'bs','Marker','s','MarkerEdgeColor',[0 0 0.8],'MarkerSize',12 );
            %hold off
        end
    end
end
guidata(hObject, handles);

% --- Executes on button press in btnNext.
function btnNext_Callback(hObject, eventdata, handles)
% hObject    handle to btnNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_frame=handles.current_frame+1;
if  handles.current_frame>handles.total_frame_number
    handles.current_frame=handles.total_frame_number;
end
set(handles.edFrameNo,'String',num2str(handles.current_frame));
frame=handles.current_frame;
set(handles.edFrameNo,'String',num2str(frame));
filename=sprintf(handles.filenamebase,frame);
im=imread(filename);
axes(handles.axes1);
cla;
imshow(im,[]);

x=handles.ground_truth_xy{handles.current_tracks_id}.x(handles.current_frame);
y=handles.ground_truth_xy{handles.current_tracks_id}.y(handles.current_frame);
if ~(x==-1 || y==-1)
   hold on;
   plot(x,y,'r+','Marker','+','MarkerEdgeColor',[1 .8 .1],'MarkerSize',16 );
   %hold off
end
startframe=max(1,handles.current_frame-10);
endframe=min(handles.current_frame+10,handles.total_frame_number);
for p=startframe:endframe
    if p~=handles.current_frame
        x=handles.ground_truth_xy{handles.current_tracks_id}.x(p);
        y=handles.ground_truth_xy{handles.current_tracks_id}.y(p);
        if ~(x==-1 || y==-1)
            hold on;
            plot(x,y,'bs','Marker','s','MarkerEdgeColor',[0 0 0.8],'MarkerSize',12 );
           % hold off
        end
    end
end
guidata(hObject, handles);

% --- Executes on button press in btnLast.
function btnLast_Callback(hObject, eventdata, handles)
% hObject    handle to btnLast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_frame=handles.total_frame_number;
set(handles.edFrameNo,'String',num2str(handles.current_frame));
frame=handles.current_frame;
set(handles.edFrameNo,'String',num2str(frame));
filename=sprintf(handles.filenamebase,frame);
im=imread(filename);
axes(handles.axes1);
cla;
imshow(im,[]);

x=handles.ground_truth_xy{handles.current_tracks_id}.x(handles.current_frame);
y=handles.ground_truth_xy{handles.current_tracks_id}.y(handles.current_frame);
if ~(x==-1 || y==-1)
   hold on;
   plot(x,y,'r+','Marker','+','MarkerEdgeColor',[1 .8 .1],'MarkerSize',16 );
  % hold off
end
startframe=max(1,handles.current_frame-10);
endframe=min(handles.current_frame+10,handles.total_frame_number);
for p=startframe:endframe
    if p~=handles.current_frame
        x=handles.ground_truth_xy{handles.current_tracks_id}.x(p);
        y=handles.ground_truth_xy{handles.current_tracks_id}.y(p);
        if ~(x==-1 || y==-1)
            hold on;
            plot(x,y,'bs','Marker','s','MarkerEdgeColor',[0 0 0.8],'MarkerSize',12 );
            %hold off
        end
    end
end
guidata(hObject, handles);

% --- Executes on selection change in cbFishID.
function cbFishID_Callback(hObject, eventdata, handles)
% hObject    handle to cbFishID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cbFishID contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cbFishID
sel_id = get(handles.cbFishID,'Value');
handles.current_tracks_id=sel_id;
seg_ids=handles.tracks{handles.current_tracks_id};
N=length(seg_ids);
disp_seg_ids=[];
for i=1:N
    disp_seg_ids{i}=num2str(seg_ids(i));
end
set(handles.listSegment,'String',disp_seg_ids);
set(handles.listSegment,'Value',1);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function cbFishID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cbFishID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in btnLoad.
function btnLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.mat','Load Groud XY As');
filename=fullfile(path,file);
load(filename,'ground_truth_xy');
handles.ground_truth_xy=ground_truth_xy;
guidata(hObject, handles);

% --- Executes on button press in btnSaveClose.
function btnSaveClose_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file,path] = uiputfile('*.mat','Save Groud XY As');
filename=fullfile(path,file);
ground_truth_xy=handles.ground_truth_xy;
save(filename,'ground_truth_xy');
close;


function edFrameTotal_Callback(hObject, eventdata, handles)
% hObject    handle to edFrameTotal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edFrameTotal as text
%        str2double(get(hObject,'String')) returns contents of edFrameTotal as a double


% --- Executes during object creation, after setting all properties.
function edFrameTotal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edFrameTotal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnSetTotalFrame.
function btnSetTotalFrame_Callback(hObject, eventdata, handles)
% hObject    handle to btnSetTotalFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.total_frame_number=str2num(get(handles.edFrameTotal,'String'));
set(hObject,'BackgroundColor',[0 1 0]);
guidata(hObject, handles);

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

function  MsgUp (object, eventdata)
handles = guidata(object);
C = get (handles.axes1, 'CurrentPoint');
mouse_x=C(1,1);
mouse_y=C(1,2);
handles.ground_truth_xy{handles.current_tracks_id}.x(handles.current_frame)=mouse_x;
handles.ground_truth_xy{handles.current_tracks_id}.y(handles.current_frame)=mouse_y;
handles.current_frame=handles.current_frame+1;
handles.current_frame=min(handles.current_frame,handles.total_frame_number);
set(handles.edFrameNo,'String',num2str(handles.current_frame));
filename=sprintf(handles.filenamebase,handles.current_frame);
im=imread(filename);
axes(handles.axes1);
cla;
imshow(im,[]);

x=handles.ground_truth_xy{handles.current_tracks_id}.x(handles.current_frame);
y=handles.ground_truth_xy{handles.current_tracks_id}.y(handles.current_frame);
if ~(x==-1 || y==-1)
   hold on;
   plot(x,y,'r+','Marker','+','MarkerEdgeColor',[1 .8 .1],'MarkerSize',16 );
   %hold off
end
startframe=max(1,handles.current_frame-10);
endframe=min(handles.current_frame+10,handles.total_frame_number);
for p=startframe:endframe
    if p~=handles.current_frame
        x=handles.ground_truth_xy{handles.current_tracks_id}.x(p);
        y=handles.ground_truth_xy{handles.current_tracks_id}.y(p);
        if ~(x==-1 || y==-1)
            hold on;
            plot(x,y,'bs','Marker','s','MarkerEdgeColor',[0 0 0.8],'MarkerSize',12 );
            %hold off
        end
    end
end

guidata(object,handles);

% --- Executes on button press in btnStartMark.
function btnStartMark_Callback(hObject, eventdata, handles)
% hObject    handle to btnStartMark (see GCBO)
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

track=handles.tracks{handles.current_tracks_id};
idx=get(handles.listSegment,'Value');
seg_id=track(idx);
frameno=handles.all_segments{seg_id}.segment_records(end,1);
frameno=frameno+1;
frameno=min(frameno,handles.total_frame_number);
set(handles.edFrameNo,'String',num2str(frameno));
handles.current_frame=str2num(get(handles.edFrameNo,'String'));
filename=sprintf(handles.filenamebase,handles.current_frame);
im=imread(filename);
axes(handles.axes1);
cla;
imshow(im,[]);

x=handles.ground_truth_xy{handles.current_tracks_id}.x(handles.current_frame);
y=handles.ground_truth_xy{handles.current_tracks_id}.y(handles.current_frame);
if ~(x==-1 || y==-1)
   hold on;
   plot(x,y,'r+','Marker','+','MarkerEdgeColor',[1 .8 .1],'MarkerSize',16 );
   %hold off
end
startframe=max(1,handles.current_frame-10);
endframe=min(handles.current_frame+10,handles.total_frame_number);
for p=startframe:endframe
    if p~=handles.current_frame
        x=handles.ground_truth_xy{handles.current_tracks_id}.x(p);
        y=handles.ground_truth_xy{handles.current_tracks_id}.y(p);
        if ~(x==-1 || y==-1)
            hold on;
            plot(x,y,'bs','Marker','s','MarkerEdgeColor',[0 0 0.8],'MarkerSize',12 );
            %hold off
        end
    end
end
guidata(hObject, handles);


function edBasePath_Callback(hObject, eventdata, handles)
% hObject    handle to edBasePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edBasePath as text
%        str2double(get(hObject,'String')) returns contents of edBasePath as a double


% --- Executes during object creation, after setting all properties.
function edBasePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edBasePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnSetPath.
function btnSetPath_Callback(hObject, eventdata, handles)
% hObject    handle to btnSetPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.filenamebase=get(handles.edBasePath,'String');
set(hObject,'BackgroundColor',[0 1 0]);
guidata(hObject, handles);

% --- Executes on button press in btnGoTo.
function btnGoTo_Callback(hObject, eventdata, handles)
% hObject    handle to btnGoTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_frame=str2num(get(handles.edFrameNo,'String'));
filename=sprintf(handles.filenamebase,handles.current_frame);
im=imread(filename);
axes(handles.axes1);
cla;
imshow(im,[]);

x=handles.ground_truth_xy{handles.current_tracks_id}.x(handles.current_frame);
y=handles.ground_truth_xy{handles.current_tracks_id}.y(handles.current_frame);
if ~(x==-1 || y==-1)
   hold on;
   plot(x,y,'r+','Marker','+','MarkerEdgeColor',[1 .8 .1],'MarkerSize',16 );
   %hold off
end
startframe=max(1,handles.current_frame-10);
endframe=min(handles.current_frame+10,handles.total_frame_number);
for p=startframe:endframe
    if p~=handles.current_frame
        x=handles.ground_truth_xy{handles.current_tracks_id}.x(p);
        y=handles.ground_truth_xy{handles.current_tracks_id}.y(p);
        if ~(x==-1 || y==-1)
            hold on;
            plot(x,y,'bs','Marker','s','MarkerEdgeColor',[0 0 0.8],'MarkerSize',12 );
            %hold off
        end
    end
end

guidata(hObject, handles);


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
%eventdata.Key
guidata(hObject, handles);