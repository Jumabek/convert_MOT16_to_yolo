%you need to set dataset_root
dataset_root = 'F:\dataset\MOT\MOT17Det\train';


dirinfo = dir(dataset_root);

video_names = {dirinfo.name};
video_names = video_names(3:end);

%refer to table 6 of the MOT16 paper for class ids,
pedestrian_cls = 1;
person_on_vehicle = 2;
static_person = 7;
distractor_id = 8;
reflection_id = 12;

person_classes = [pedestrian_cls person_on_vehicle static_person]; 

filelist_name = fullfile(dataset_root,'filelist.txt');
filelist_stream = fopen(char(filelist_name),'w');

VISUALIZE = 1;

for i=1:1:length(video_names)
    video = video_names(i);
    
    drawn_img_root = fullfile(dataset_root,video,'drawn_img');
    drawn_img_root = char(drawn_img_root);
    if exist(drawn_img_root,'dir')~=7
        mkdir(drawn_img_root);
    end
   
    label_root = fullfile(dataset_root,video,'labels');
    label_root = char(label_root);
    if exist(label_root,'dir')~=7
        mkdir(label_root);
    end
    
    
    gt_path = fullfile(dataset_root,video,'gt','gt.txt');
    fileID = fopen(char(gt_path),'r');
    
    formatSpec = '%d,%d,%d,%d,%d,%d,%d,%d,%f\n';
    sizeA = [9 Inf];
    data = fscanf(fileID,formatSpec,sizeA);
    data = data';
    
    m = length(data)
    
    mapObj = containers.Map('KeyType', 'int32', 'ValueType', 'any');
    
    for j=1:1:m
        %fprintf('Processing.. %d',j);
        
        C = num2cell(data(j,:));
        [frm_id,seq_id,xmin,ymin,w,h,temp1,temp2,temp3] = C{:};
        
        frm_id = double(frm_id);
        
        if isKey(mapObj,frm_id)
            mapObj(frm_id) = [mapObj(frm_id) cell2annotation(C)];
        else
            %disp(frm_id);
            mapObj(frm_id) = cell2annotation(C);
        end        
    end
    
    
    
    num_frames = length(mapObj);
    %save the content of the map
    for j=1:1:num_frames
        annotations = mapObj(j);
        num_annotations = length(annotations);
        
        im_path = fullfile(dataset_root,video,sprintf('img1/%0.6d.jpg',j));
        im_path = char(im_path);
        
        fprintf(filelist_stream,'%s\n',im_path);
       
        
        label_path = strrep(im_path,'img1','labels');
        label_path = strrep(label_path,'.jpg','.txt');
        
        
        fileID = fopen(label_path,'w');
        

        I = imread(im_path);
        
        
        im_size = size(I);
        
        
            for k=1:1:num_annotations
                annotation = annotations(k);
                cls_id = 1;
                if ismember(annotation.class,person_classes)  
                    cls_id = 0; 
                end
                if ismember(annotation.class,[distractor_id reflection_id])
                    cls_id=-1;
                end
                
                if ~ismember(cls_id,[0,-1]) continue;end;
                             
                if annotation.visibility>=0.3
                    fprintf('annotation.class = %d\n',annotation.class);
                    
                    if VISUALIZE==1
                        I = draw_bbox(I,annotation.bbox,annotation.class);
                    end
                    [x y w h] = convert(annotation.bbox,im_size);
                
                    fprintf(fileID,'%d %f %f %f %f\n',cls_id,x,y,w,h);
                end
                
            end
        fclose(fileID);           
        if VISUALIZE
            drawn_img_path = strrep(im_path,'img1','drawn_img');
            imwrite(I,drawn_img_path);        
        end
    end
end

