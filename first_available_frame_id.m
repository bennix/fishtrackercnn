function [frame,id]=first_available_frame_id(pairs)
N=length(pairs);
id=-1;
frame=-1;
for i=1:N
    if ~isempty(pairs{i})
        if ~isempty(pairs{i}.match)
            cm=pairs{i}.match;
            id=cm(1,1);
            frame=i;
            break
        end
    end
end