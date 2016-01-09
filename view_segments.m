load('E:\\CoreView_258\\data\\all_segments.mat')
close all
figure;
% set(0,'DefaultLineCreateFcn','drawnow');
% set(0,'DefaultPatchCreateFcn','drawnow');
% set(0,'DefaultSurfaceCreateFcn','drawnow');
% set(gcf, 'renderer', 'painters');
%set(gcf,'renderermode','manual');
warning off
filenamebase='E:\\CoreView_258\\Master Camera\\CoreView_258_Master_Camera_%05d.bmp';
%N=length(all_segments);
%IDs=[1 17 22 23 24 28 31 35 40 55 68 71 73 75 90 91 114];
%IDs=[2 27 29 34 65 72 95 99 115];
%IDs=[3 15 60 62 70 93 108 111 116];
%IDs=[4 16 42 56 67 76 80 83 85 110];
%IDs=[5 45 59 107 112];
%IDs=[6 47 51 86 89];
%IDs=[7 77 82 92];
%IDs=[8 18 20 44 52 79 87 102];
%IDs=[9 26 54 63 94 100 103 106 109];
%IDs=[10 39 104];
%IDs=[11 19 25 32 37 41 43 49 61 88 98 105];
%IDs=[12 30 36 48 57 84 97 117];
%IDs=[13 53];
%IDs=[14 21 33 38 46 58 64 66 69 74 78 81 96 101 113];

% IDs=[1 ,17 ,22 ,23 ,24 ,28 ,31 ,35 ,40 ,55 ,68 ,71 ,73 ,75 ,90 ,91 ,114 ,125 ,135 ,153 ,174 ,182 ,204 ,248 ,256 ,266 ,285 ,303 ,311];
% IDs=[2 ,29 ,34 ,65 ,72 ,95 ,99 ,115 ,147 ,159 ,169 ,176 ,190 ,253 ,291 ,307 ,310 ];
% IDs=[3 ,15 ,60 ,62 ,70 ,93 ,108 ,111 ,116 ,142 ,179 ,188 ,195 ,206 ,228 ,246 ,277 ];
% IDs=[4 ,16 ,42 ,56 ,67 ,76 ,80 ,83 ,85 ,110 ,119 ,130 ,132 ,137 ,214 ,221 ,226 ,234 ,242 ,247 ,255 ];
% IDs=[5 ,45 ,59 ,107 ,112 ,171 ,201 ,222 ,227 ,237 ,241 ,250 ,270 ,287 ,289 ,301 ];
% IDs=[6 ,47 ,51 ,86 ,89 ,129 ,151 ,172 ,196 ,197 ,215 ,224 ,229 ,261 ,272 ,283 ];
% IDs=[7 ,77 ,82 ,92 ,121 ,150 ,160 ,165 ,185 ,209 ,216 ,233 ,249 ,268 ,282 ,300 ,312 ];
% IDs=[8 ,18 ,20 ,44 ,52 ,79 ,87 ,102 ,162 ,181 ,189 ,191 ,194 ,199 ,239 ,252 ,271 ];
% IDs=[9 ,26 ,54 ,63 ,94 ,100 ,103 ,106 ,109 ,122 ,130 ,138 ,141 ,170 ,173 ,183 ,186 ,198 ,205 ,213 ,217 ,223 ,230 ,244 ,259 ,264 ,274 ,275 ,304 ];
% IDs=[10 ,39 ,104 ,120 ,127 ,136 ,143 ,148 ,152 ,157 ,163 ,203 ,240 ,257 ,258 ,260 ,262 ,298 ];
% IDs=[11 ,19 ,25 ,32 ,37 ,41 ,43 ,47 ,49 ,61 ,88 ,98 ,105 ,123 ,133 ,140 ,149 ,161 ,167 ,184 ,211 ,232 ,269 ,294 ,302 ,305 ];
% IDs=[12 ,27 ,30 ,36 ,48 ,57 ,84 ,97 ,117 ,134 ,158 ,164 ,207 ,210 ,231 ,254 ,273 ,276 ,279 ,290 ,308];
% IDs=[13 ,53 ,126 ,132 ,139 ,145 ,156 ,166 ,177 ,193 ,212 ,220 ,238 ,243 ,245 ,251 ,263 ,284 ,293 ];
% IDs=[14 ,21 ,33 ,38 ,46 ,58 ,64 ,66 ,69 ,74 ,78 ,81 ,96 ,101 ,113 ,118 ,124 ,128 ,144 ,155 ,168 ,178 ,192 ,219 ,235 ,278 ,295 ];

IDs=[1 50 131  174 176];
IDs= [2 121];
IDs=[3 84 122 139 159 173];
IDs=[4 97 127];
IDs=[5 48 52 80 110 132 183];
IDs=[6 27 30 32 35 55 62 67 75 81 88 91 93 95 99 102 104 107 114 117 125 143 161 162 167 177 178 179];
IDs=[7 87];
IDs=[8 28 41 47 58 59 61 66 106];
IDs=[9 36 44 51 63 89 96 105 124 141 155];
IDs=[10 31 37 146 156 157];
IDs=[11 38 39 83 119 145 165 168];
IDs=[12 26 85];
IDs=[13 126 130 149];
IDs=[14 65 78 118 136];
IDs=[15 33 54 69 94];
IDs=[16 72 108 129 148];
IDs=[17 43 60 68 73 135 181];
IDs=[18 29 103] ;
IDs=[19 109 138 169];
IDs=[20 86 90];
IDs=[21 180];
IDs=[22 49 53 56 57 166];
IDs=[23];
IDs=[24 45 70 77 92 98 101 111 115];
IDs=[25 40 42 64 76 79 100 113 116 128 133 150 151 152 154 158 164];
IDs=1;

segment_records=[];
segment_images=[];
for i=1:length(IDs)
 segment_records=[segment_records; all_segments{IDs(i)}.segment_records];
 segment_images=[segment_images all_segments{IDs(i)}.segment_pictures];
end

N=size(segment_records,1);
track_x=[];
track_y=[];
for i=1:N
    
    frame=segment_records(i,1);
    filename=sprintf(filenamebase,frame);
    im=imread(filename);
%     f = clf;
%     set(f,'Visible','off');
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
    xlabel(num2str(frame));
    %pause(0.03); 
     
    drawnow %limitrate nocallbacks
    %frame = getframe;
    %writeVideo(writerObj,frame);
    %set(f,'Visible','on');
end
before=0;
handles.total_fish=25;
[filtered_segments]=filter_all_segments(all_segments,sel_x,sel_y,frame,before,handles);

hold on
N=length(filtered_segments);
for id=1:N
    x=filtered_segments{id}.segment_records(:,3);
    y=filtered_segments{id}.segment_records(:,4);
    tframe=filtered_segments{id}.segment_records(1,1);
    tid=filtered_segments{id}.segment_records(1,end);
    plot(x,y,'g-');
    text(x(1),y(1)+5,[num2str(tid) ' @ '   num2str(tframe-frame)],'Color','b','FontSize',15);
end

